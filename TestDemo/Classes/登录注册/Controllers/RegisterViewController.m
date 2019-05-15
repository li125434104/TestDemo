
//
//  RegisterViewController.m
//  TestDemo
//
//  Created by taishu on 2019/5/15.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "RegisterViewController.h"
#import "VerificationCodeView.h"
#import "PasswordView.h"

@interface RegisterViewController ()
@property (nonatomic, strong) UIView *inputBGView;
@property (nonatomic, strong) UITextField *accountTextField;     //账号textField
@property (nonatomic, strong) VerificationCodeView *vfCodeView;  //验证码view
@property (nonatomic, strong) PasswordView *pswView;             //密码view
@property (nonatomic, strong) UIButton *registerButton;          //注册button

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    [self configureUI];
}

- (void)setNav {
    self.title = @"注册";
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    //    [leftbutton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark -- ConfigureUI
- (void)configureUI {
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:self.inputBGView];
    [self.inputBGView addSubview:self.accountTextField];
    [self.inputBGView addSubview:self.vfCodeView];
    [self.inputBGView addSubview:self.pswView];
    [self.inputBGView addSubview:self.registerButton];
}

#pragma mark -- Action
- (void)backBtnClick:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)registerBtnClick:(UIButton *)button {
    NSLog(@"点击注册按钮%@",self.pswView.passwordTextField.text);
    if (![self.accountTextField.text vertifyMobilePhone]) {
        NSLog(@"请输入正确的手机号码");
        return;
    }
    if (![self.pswView.passwordTextField.text vertifyPassword]) {
        NSLog(@"密码需6-18位数字密码组合");
        return;
    }
}

#pragma mark -- Setter & Getter
- (UIView *)inputBGView {
    if (!_inputBGView) {
        _inputBGView = [[UIView alloc] initWithFrame:CGRectMake(30, 120, kScreenWidth - 60, 260)];
        _inputBGView.backgroundColor = [UIColor whiteColor];
    }
    return _inputBGView;
}

- (UITextField *)accountTextField {
    if (!_accountTextField) {
        _accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.inputBGView.width, 40)];
        _accountTextField.textColor = [UIColor blackColor];
        _accountTextField.font = [UIFont systemFontOfSize:15.f];
        _accountTextField.placeholder = @"请输入手机号";
        [_accountTextField setBorder:1.f borderColor:[UIColor groupTableViewBackgroundColor] borderPosition:MYUIViewBorderPositionBottom];
        _accountTextField.keyboardType = UIKeyboardTypePhonePad;
    }
    return _accountTextField;
}

- (VerificationCodeView *)vfCodeView {
    if (!_vfCodeView) {
        _vfCodeView = [[VerificationCodeView alloc] initWithFrame:CGRectMake(0, 40, self.inputBGView.width, 40)];
    }
    return _vfCodeView;
}

- (PasswordView *)pswView {
    if (!_pswView) {
        _pswView = [[PasswordView alloc] initWithFrame:CGRectMake(0, self.vfCodeView.bottom, self.inputBGView.width, 40)];
    }
    return _pswView;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.frame = CGRectMake(0, self.pswView.bottom + 30, self.inputBGView.width, 40);
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _registerButton.backgroundColor = [UIColor orangeColor];
        [_registerButton setCornerRadii:20.f roundingCorners:UIRectCornerAllCorners];
        [_registerButton addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
