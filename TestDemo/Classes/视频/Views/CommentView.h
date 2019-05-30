//
//  CommentView.h
//  TestDemo
//
//  Created by taishu on 2019/5/30.
//  Copyright © 2019 taishu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SendTextDelegate

@required
-(void)onSendText:(NSString *)text;

@end

@protocol HoverTextViewDelegate

@required
- (void)hoverTextViewStateChange:(BOOL)isHover;

@end


@interface CommentView : UIView

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, weak) id<HoverTextViewDelegate> hoverDelegate;
@property (nonatomic, weak) id<SendTextDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
