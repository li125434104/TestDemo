//
//  CommentView.m
//  TestDemo
//
//  Created by taishu on 2019/5/30.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "CommentView.h"
#import "NSNotification+Extension.h"

static const CGFloat kCommentViewLeftInset  = 40;
static const CGFloat kCommentRightInset     = 100;
static const CGFloat kCommentTopBottomInset = 15;

@interface CommentView ()<UITextViewDelegate>

@property (nonatomic, assign) CGFloat textHeight;
@property (nonatomic, assign) CGFloat keyboardHeight;
@property (nonatomic, retain) UILabel *placeholderLabel;
@property (nonatomic, strong) UIImageView *editImageView;
@property (nonatomic, strong) UIImageView *atImageView;
@property (nonatomic, strong) UIImageView *sendImageView;
@property (nonatomic, strong) UIView *splitLine;

@end

@implementation CommentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectZero];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGuesture:)]];
        
        _keyboardHeight = SafeAreaBottomHeight;
        
        [self.textView addSubview:self.placeholderLabel];
        [self.textView addSubview:self.editImageView];
        [self.textView addSubview:self.atImageView];
        [self.textView addSubview:self.sendImageView];
        [self.textView addSubview:self.splitLine];
        [self addSubview:self.textView];

        self.textView.delegate = self;
        //为软键盘弹出和收起动作注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

#pragma mark -- UI Frame
- (void)layoutSubviews {
    [super layoutSubviews];
    self.frame = [self superview].bounds;
    [self updateViewFrameAndState];
}

- (void)updateViewFrameAndState {
    [self updateIconState];
    [self updateRightViewsFrame];
    [self updateTextViewFrame];
}

- (void)updateIconState {
    _editImageView.image = _keyboardHeight > SafeAreaBottomHeight ? [UIImage imageNamed:@"ic90Pen1"] : (_textView.text.length > 0 ? [UIImage imageNamed:@"ic90Pen1"] : [UIImage imageNamed:@"ic30Pen1"]);
    _atImageView.image = _keyboardHeight > SafeAreaBottomHeight ? [UIImage imageNamed:@"ic90WhiteAt"] : (_textView.text.length > 0 ? [UIImage imageNamed:@"ic90WhiteAt"] : [UIImage imageNamed:@"ic30WhiteAt"]);
    _sendImageView.image = _textView.text.length > 0 ? [UIImage imageNamed:@"ic30RedSend"] : [UIImage imageNamed:@"ic30WhiteSend"];
}

- (void)updateRightViewsFrame {
    CGFloat originX = kScreenWidth;
    originX -= _keyboardHeight > SafeAreaBottomHeight ? 50 : (_textView.text.length > 0 ? 50 : 0);
    [UIView animateWithDuration:0.25 animations:^{
        self.sendImageView.frame = CGRectMake(originX, 0, 50, 50);
        self.atImageView.frame = CGRectMake(CGRectGetMinX(self.sendImageView.frame) - 50, 0, 50, 50);
    }];
}

- (void)updateTextViewFrame {
    CGFloat textViewHeight = _keyboardHeight > SafeAreaBottomHeight ? _textHeight + 2*kCommentTopBottomInset : ceilf(_textView.font.lineHeight) + 2*kCommentTopBottomInset;
    self.textView.frame = CGRectMake(0, kScreenHeight - _keyboardHeight - textViewHeight, kScreenWidth, textViewHeight);
}

#pragma mark -- textView delegate
-(void)textViewDidChange:(UITextView *)textView {
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:textView.attributedText];
    textView.attributedText = attributedText;
    if(!textView.hasText) {
        [_placeholderLabel setHidden:NO];
        _textHeight = ceilf(_textView.font.lineHeight);
    } else {
        [_placeholderLabel setHidden:YES];
        _textHeight = [textView.text getStringHeightWithWidth:kScreenWidth - kCommentViewLeftInset - kCommentRightInset font:[UIFont systemFontOfSize:16.0] lineSpacing:0];
    }
    [self updateViewFrameAndState];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        [self onSend];
        return NO;
    }
    return YES;
}


#pragma mark -- Action
- (void)onSend {
    if(_delegate) {
        [_delegate onSendText:_textView.text];
        [_placeholderLabel setHidden:NO];
        _textView.text = @"";
        _textHeight = ceilf(_textView.font.lineHeight);
        [_textView resignFirstResponder];
    }
}

//handle guesture tap
- (void)handleGuesture:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:_textView];
    if(![_textView.layer containsPoint:point]) {
        [_textView resignFirstResponder];
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    if(hitView == self){
        if(hitView.backgroundColor == [UIColor clearColor]) {
            return nil;
        }
    }
    return hitView;
}


#pragma mark --  keyboard notification
- (void)keyboardWillShow:(NSNotification *)notification {
    self.backgroundColor = COLOR_RGBA(0.0, 0.0, 0.0, 0.4);
    //获取当前软键盘高度
    _keyboardHeight = [notification keyBoardHeight];
    [self updateViewFrameAndState];
    if(_hoverDelegate){
        [_hoverDelegate hoverTextViewStateChange:YES];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    self.backgroundColor = [UIColor clearColor];
    //软键盘高度置0
    _keyboardHeight = SafeAreaBottomHeight;
    [self updateViewFrameAndState];
    if(_hoverDelegate){
        [_hoverDelegate hoverTextViewStateChange:NO];
    }
}

#pragma mark -- Setter
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [UIColor clearColor];
        
        _textView.clipsToBounds = NO;
        _textView.textColor = [UIColor whiteColor];
        _textView.font = [UIFont systemFontOfSize:16.0];
        _textView.returnKeyType = UIReturnKeySend;
        _textView.scrollEnabled = NO;
        _textView.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
        _textView.textContainerInset = UIEdgeInsetsMake(kCommentTopBottomInset, kCommentViewLeftInset, kCommentTopBottomInset, kCommentRightInset);
        _textView.textContainer.lineFragmentPadding = 0;
        _textHeight = ceilf(_textView.font.lineHeight);
    }
    return _textView;
}

- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc]init];
        _placeholderLabel.text = @"有爱评论，说点儿好听的~";
        _placeholderLabel.textColor = COLOR_RGBA(255.0, 255.0, 255.0, 0.4);
        _placeholderLabel.font = [UIFont systemFontOfSize:16.f];
        _placeholderLabel.frame = CGRectMake(kCommentViewLeftInset, 0, kScreenWidth - kCommentViewLeftInset - kCommentRightInset, 50);
    }
    return _placeholderLabel;
}

- (UIImageView *)editImageView {
    if (!_editImageView) {
        _editImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 50)];
        _editImageView.contentMode = UIViewContentModeCenter;
        _editImageView.image = [UIImage imageNamed:@"ic30Pen1"];
    }
    return _editImageView;
}

- (UIImageView *)atImageView {
    if (!_atImageView) {
        _atImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 50, 0, 50, 50)];
        _atImageView.contentMode = UIViewContentModeCenter;
        _atImageView.image = [UIImage imageNamed:@"ic30WhiteAt"];
    }
    return _atImageView;
}

- (UIImageView *)sendImageView {
    if (!_sendImageView) {
        _sendImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, 50, 50)];
        _sendImageView.contentMode = UIViewContentModeCenter;
        _sendImageView.image = [UIImage imageNamed:@"ic30WhiteSend"];
        _sendImageView.userInteractionEnabled = YES;
        [_sendImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSend)]];
    }
    return _sendImageView;
}

- (UIView *)splitLine {
    if (!_splitLine) {
        _splitLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5f)];
        _splitLine.backgroundColor = COLOR_RGBA(255.0, 255.0, 255.0, 0.4);
    }
    return _splitLine;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
