
//
//  VerificationCodeView.m
//  TestDemo
//
//  Created by taishu on 2019/5/15.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "VerificationCodeView.h"

@implementation VerificationCodeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.vertificationCodeTextField];
        [self addSubview:self.countButton];
    }
    return self;
}

#pragma mark -- Getter & Setter
- (UITextField *)vertificationCodeTextField {
    if (!_vertificationCodeTextField) {
        _vertificationCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.width - 80, self.height)];
        _vertificationCodeTextField.textColor = [UIColor blackColor];
        _vertificationCodeTextField.font = [UIFont systemFontOfSize:15.f];
        _vertificationCodeTextField.placeholder = @"请输入验证码";
        [_vertificationCodeTextField setBorder:1.f borderColor:[UIColor groupTableViewBackgroundColor] borderPosition:MYUIViewBorderPositionBottom];
        _vertificationCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _vertificationCodeTextField;
}

- (UIButton *)countButton {
    if (!_countButton) {
        _countButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _countButton.frame = CGRectMake(self.vertificationCodeTextField.right, 0, 80, self.height);
        [_countButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _countButton.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [_countButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_countButton addTarget:self action:@selector(getVerificationCode:) forControlEvents:UIControlEventTouchUpInside];
        [_countButton setBorder:1.f borderColor:[UIColor groupTableViewBackgroundColor] borderPosition:MYUIViewBorderPositionBottom];
    }
    return _countButton;
}

- (void)getVerificationCode:(UIButton *)button {
    //获取验证码接口
    [self.countButton scheduledTimerWithTimeInterval:60.f countDownText:@"s" completion:^(UIButton *countDownButton) {
        [self.countButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
