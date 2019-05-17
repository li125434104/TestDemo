//
//  LoginViewController.m
//  TestDemo
//
//  Created by taishu on 2019/5/9.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "VerificationCodeView.h"
#import "PasswordView.h"
#import <YYText/YYText.h>

typedef NS_ENUM(NSUInteger, LoginType) {
    LoginTypeMobile,  //手机验证码方式
    LoginTypePSW      //账号密码方式
};

@interface LoginViewController ()

@property (nonatomic, strong) UIView *inputBGView;
@property (nonatomic, strong) UILabel *typeTitleLabel;
@property (nonatomic, strong) UITextField *accountTextField;   //firstTextField:0为手机号  1为账号
@property (nonatomic, strong) UIButton *loginButton;           //登录button
@property (nonatomic, strong) UIButton *changeTypeButton;      //切换登录方式
@property (nonatomic, assign) LoginType loginType;             //登录方式：0为手机号 1为账号密码
@property (nonatomic, strong) VerificationCodeView *vfCodeView;//验证码view
@property (nonatomic, strong) PasswordView *pswView;           //密码view
@property (nonatomic, strong) UIView *thirdLoginBGView;        //三方登录bg
@property (nonatomic, strong) YYLabel *agreementLabel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    [self configureUI];
}

- (void)setNav {
    self.title = @"登录";
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
//    [leftbutton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;

    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
    [rightButton setTitle:@"注册" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark -- ConfigureUI
- (void)configureUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.inputBGView];
    [self.inputBGView addSubview:self.typeTitleLabel];
    [self.inputBGView addSubview:self.accountTextField];
    [self.inputBGView addSubview:self.vfCodeView];
    [self.inputBGView addSubview:self.pswView];
    self.pswView.hidden = YES;
    [self.inputBGView addSubview:self.loginButton];
    [self.inputBGView addSubview:self.changeTypeButton];
    [self.view addSubview:self.thirdLoginBGView];
    
    [self createThirdLoginButtons];
    [self.thirdLoginBGView addSubview:self.agreementLabel];
}

- (void)createThirdLoginButtons {
    NSArray *titleArray  = @[@"微信", @"QQ", @"微博"];
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat margin = (self.thirdLoginBGView.width - 100 - 3 * 60) / 2;
        button.frame = CGRectMake(50 + i * (60 + margin), 60, 60, 60);
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [button setCornerRadii:30.f roundingCorners:UIRectCornerAllCorners borderWidth:1 borderColor:[UIColor groupTableViewBackgroundColor]];
        button.tag = i + 100;
        [button addTarget:self action:@selector(thirdLoginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.thirdLoginBGView addSubview:button];
    }
}

#pragma mark -- Action
- (void)backBtnClick:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerBtnClick:(UIButton *)button {
    RegisterViewController *vc = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loginBtnClick:(UIButton *)button {
    NSLog(@"登录点击");
    if (self.loginType == 0) {
        if (![self.accountTextField.text vertifyMobilePhone]) {
            NSLog(@"请输入正确的手机号码");
            return;
        }
    } else {
        if (![self.accountTextField.text vertifyMobilePhone] || [self.accountTextField.text vertifyEmail]) {
            NSLog(@"请输入正确的手机号或者邮箱");
            return;
        }
        if (![self.pswView.passwordTextField.text vertifyPassword]) {
            NSLog(@"密码需8-16位数字密码组合");
            return;
        }
    }
    
    //登录接口，回调中获取到userInfo信息
    #warning NSUserDefault存储登录信息
    NSUserDefaults *useName = [NSUserDefaults standardUserDefaults];
    [useName setObject:self.accountTextField.text forKey:@"userName"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
}

//第三方登录
- (void)thirdLoginBtnClick:(UIButton *)button {
    NSLog(@"第三方登录：%ld",button.tag);
}

//切换登录方式
- (void)changeTypeBtnClick:(UIButton *)button {
    [self.view endEditing:YES];
    button.selected = !button.isSelected;
    self.loginType = button.isSelected;
    [self changeLoginType];
}

- (void)changeLoginType {
    NSString *typeStr = self.loginType ? @"账号密码登录" : @"手机验证码登录";
    self.typeTitleLabel.text = typeStr;
    self.vfCodeView.hidden = self.loginType;
    self.pswView.hidden = !self.loginType;
    self.accountTextField.placeholder = self.loginType ? @"请输入手机号或邮箱" : @"请输入手机号";
    self.accountTextField.keyboardType = self.loginType ? UIKeyboardTypeDefault : UIKeyboardTypePhonePad;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark -- Setter & Getter
- (UIView *)inputBGView {
    if (!_inputBGView) {
        _inputBGView = [[UIView alloc] initWithFrame:CGRectMake(30, 120, kScreenWidth - 60, 260)];
        _inputBGView.backgroundColor = [UIColor whiteColor];
    }
    return _inputBGView;
}

- (UIView *)typeTitleLabel {
    if (!_typeTitleLabel) {
        _typeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.inputBGView.width, 30)];
        _typeTitleLabel.textColor = [UIColor blackColor];
        _typeTitleLabel.font = [UIFont systemFontOfSize:22.f];
        _typeTitleLabel.text = @"手机验证码登录";
        _typeTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _typeTitleLabel;
}

- (UITextField *)accountTextField {
    if (!_accountTextField) {
        _accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, self.typeTitleLabel.bottom + 10, self.inputBGView.width, 40)];
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
        _vfCodeView = [[VerificationCodeView alloc] initWithFrame:CGRectMake(0, self.accountTextField.bottom, self.inputBGView.width, 40)];
    }
    return _vfCodeView;
}

- (PasswordView *)pswView {
    if (!_pswView) {
        _pswView = [[PasswordView alloc] initWithFrame:CGRectMake(0, self.accountTextField.bottom, self.inputBGView.width, 40)];
    }
    return _pswView;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.frame = CGRectMake(0, self.vfCodeView.bottom + 20, self.inputBGView.width, 40);
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.backgroundColor = [UIColor orangeColor];
        [_loginButton setCornerRadii:20.f roundingCorners:UIRectCornerAllCorners];
        [_loginButton addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)changeTypeButton {
    if (!_changeTypeButton) {
        _changeTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _changeTypeButton.frame = CGRectMake(self.inputBGView.width / 2 - 50, self.loginButton.bottom + 20, 100, 30);
        _changeTypeButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_changeTypeButton setTitle:@"账号密码登录" forState:UIControlStateNormal];
        [_changeTypeButton setTitle:@"手机验证码登录" forState:UIControlStateSelected];
        [_changeTypeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_changeTypeButton addTarget:self action:@selector(changeTypeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeTypeButton;
}

- (UIView *)thirdLoginBGView {
    if (!_thirdLoginBGView) {
        _thirdLoginBGView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 150, self.view.width, 150)];
        _thirdLoginBGView.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_thirdLoginBGView.width / 2 - 50, 15, 100, 20)];
        titleLabel.text = @"其他方式登录";
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.font = [UIFont systemFontOfSize:14.f];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_thirdLoginBGView addSubview:titleLabel];
        
        UILabel *leftLine = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.left - 60, titleLabel.center.y, 50, 1)];
        leftLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_thirdLoginBGView addSubview:leftLine];
        
        UILabel *rightLine = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.right + 10, titleLabel.center.y, 50, 1)];
        rightLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_thirdLoginBGView addSubview:rightLine];
    }
    return _thirdLoginBGView;
}

- (YYLabel *)agreementLabel {
    if (!_agreementLabel) {
        _agreementLabel = [YYLabel new];
        _agreementLabel.frame = CGRectMake(0, self.thirdLoginBGView.height - 20, self.thirdLoginBGView.width, 20);

        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"登录代表您已经同意：用户协议"];
        NSRange range = NSMakeRange(text.length-4, 4);
        [text yy_setTextHighlightRange:range
                                 color:[UIColor orangeColor]
                       backgroundColor:[UIColor clearColor]
                             tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                 NSLog(@"点击用户协议");
                             }];
        _agreementLabel.attributedText = text;
        _agreementLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _agreementLabel;
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
