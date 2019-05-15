//
//  PasswordView.m
//  TestDemo
//
//  Created by taishu on 2019/5/15.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "PasswordView.h"

@implementation PasswordView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.passwordTextField];
        [self addSubview:self.showPswButton];
    }
    return self;
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.width - 40, self.height)];
        _passwordTextField.textColor = [UIColor blackColor];
        _passwordTextField.font = [UIFont systemFontOfSize:15.f];
        _passwordTextField.placeholder = @"请输入密码";
        _passwordTextField.secureTextEntry = YES;
        [_passwordTextField setBorder:1.f borderColor:[UIColor groupTableViewBackgroundColor] borderPosition:MYUIViewBorderPositionBottom];
        _passwordTextField.keyboardType = UIKeyboardTypeDefault;
    }
    return _passwordTextField;
}

- (UIButton *)showPswButton {
    if (!_showPswButton) {
        _showPswButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _showPswButton.frame = CGRectMake(self.passwordTextField.right, 0, 40, self.height);
        [_showPswButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _showPswButton.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [_showPswButton setTitle:@"显示" forState:UIControlStateNormal];
        [_showPswButton setTitle:@"隐藏" forState:UIControlStateSelected];
        [_showPswButton addTarget:self action:@selector(showOrHide:) forControlEvents:UIControlEventTouchUpInside];
        [_showPswButton setBorder:1.f borderColor:[UIColor groupTableViewBackgroundColor] borderPosition:MYUIViewBorderPositionBottom];
    }
    return _showPswButton;
}

- (void)showOrHide:(UIButton *)button {
    //获取验证码接口
    self.showPswButton.selected = !self.showPswButton.isSelected;
    self.passwordTextField.secureTextEntry = !self.showPswButton.selected;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
