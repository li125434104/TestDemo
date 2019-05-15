//
//  UITextField+Category.m
//  XJTools_Example
//
//  Created by taishu on 2019/4/28.
//  Copyright © 2019 125434104@qq.com. All rights reserved.
//

#import "UITextField+Category.h"
#import <objc/runtime.h>

static const void *TextFieldInputLimitMaxLength = &TextFieldInputLimitMaxLength;
static const void *leftPaddingKey= &leftPaddingKey;
static const void *placeHolderColorKey = &placeHolderColorKey;

@implementation UITextField (Category)

- (NSInteger)maxLength {
    return [objc_getAssociatedObject(self, TextFieldInputLimitMaxLength) integerValue];
}

- (void)setMaxLength:(NSInteger)maxLength {
    objc_setAssociatedObject(self, TextFieldInputLimitMaxLength, @(maxLength), OBJC_ASSOCIATION_ASSIGN);
    [self addTarget:self
             action:@selector(textFieldTextDidChange)
   forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldTextDidChange {
    NSString *toBeString = self.text;
    // 获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    // 在iOS7下,position对象总是不为nil
    if ((!position ||!selectedRange) && (self.maxLength > 0 && toBeString.length > self.maxLength)) {
        NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.maxLength];
        if (rangeIndex.length == 1) {
            self.text = [toBeString substringToIndex:self.maxLength];
        } else {
            NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.maxLength)];
            NSInteger tmpLength;
            if (rangeRange.length > self.maxLength) {
                tmpLength = rangeRange.length - rangeIndex.length;
            } else {
                tmpLength = rangeRange.length;
            }
            self.text = [toBeString substringWithRange:NSMakeRange(0, tmpLength)];
        }
    }
}

- (CGFloat)leftPadding {
    return [objc_getAssociatedObject(self, leftPaddingKey) integerValue];
}

- (void)setLeftPadding:(CGFloat)leftPadding {
    CGRect frame = self.frame;
    frame.size.width =leftPadding;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftview;
    objc_setAssociatedObject(self,leftPaddingKey,[NSNumber numberWithFloat:leftPadding], OBJC_ASSOCIATION_ASSIGN);
}

-(UIColor *)placeHolderColor {
    return objc_getAssociatedObject(self, placeHolderColorKey);
}

-(void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    [self setValue:placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];
    objc_setAssociatedObject(self,placeHolderColorKey, placeHolderColor, OBJC_ASSOCIATION_RETAIN);
}

@end
