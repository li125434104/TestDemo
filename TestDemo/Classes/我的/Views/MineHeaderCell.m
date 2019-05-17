//
//  MineHeaderCell.m
//  TestDemo
//
//  Created by taishu on 2019/5/16.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "MineHeaderCell.h"
#import "XJSetTable.h"
#import "MineHeaderModel.h"

#define kImageWidth  50

@interface MineHeaderCell()

@property (nonatomic, strong) UIImageView *avaterImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIImageView *arrow;
@property (nonatomic, strong) MineHeaderModel *model;

@end

@implementation MineHeaderCell

- (void)setupUI {
    [super setupUI];
    
    [self.contentView addSubview:self.avaterImageView];
    [self.contentView addSubview:self.loginButton];
    [self.contentView addSubview:self.arrow];
    [self.contentView addSubview:self.nameLabel];
}

- (void)setupDataModel:(XJBaseCellModel *)model {
    self.model = (MineHeaderModel *)model;
    self.avaterImageView.frame = CGRectMake(10, (model.cellHeight - kImageWidth) / 2, kImageWidth, kImageWidth);
    self.loginButton.frame = CGRectMake(self.avaterImageView.right + 15, (model.cellHeight - 30) / 2, 100, 30);
    self.arrow.frame = CGRectMake(kScreenWidth - HS_KCellMargin - HS_KArrowWidth, (model.cellHeight - HS_kArrowHeight) / 2, HS_KArrowWidth, HS_kArrowHeight);
    self.nameLabel.frame = CGRectMake(self.avaterImageView.right + 15, (model.cellHeight - 40) / 2, kScreenWidth - 3 * HS_KCellMargin - HS_KArrowWidth - kImageWidth, 40);
    
    self.nameLabel.hidden = !self.model.isLogin;
    self.loginButton.hidden = self.model.isLogin;
    self.nameLabel.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
}


+ (CGFloat)getCellHeight:(XJBaseCellModel *)model {
    return model.cellHeight;
}

#pragma mark -- Action
- (void)loginBtnClick:(UIButton *)button {
    MineHeaderModel *model = self.model;
    if (model.loginAction) {
        model.loginAction();
    }
}

#pragma mark -- Setter
- (UIImageView *)avaterImageView {
    if (!_avaterImageView) {
        _avaterImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _avaterImageView.image = [UIImage imageNamed:@"mine_default"];
        _avaterImageView.clipsToBounds = YES;
        _avaterImageView.layer.cornerRadius = kImageWidth / 2;
    }
    return _avaterImageView;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:17.f];
        [_loginButton setTitle:@"登录/注册" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _loginButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_loginButton addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIImageView *)arrow {
    if (!_arrow) {
        _arrow = [[UIImageView alloc] initWithFrame:CGRectZero];
        _arrow.image = [self imageNamed:@"ic_hs_tableView_arrow"];
    }
    return _arrow;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:17.f];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

- (UIImage *)imageNamed:(NSString *)name {
    NSBundle *hs_Bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"HSSetTableViewController" ofType:@"bundle"]];
    CGFloat scale = [[UIScreen mainScreen] scale];
    name = 3.0 == scale ? [NSString stringWithFormat:@"%@@3x.png", name] : [NSString stringWithFormat:@"%@@2x.png", name];
    UIImage *image = [UIImage imageWithContentsOfFile:[[hs_Bundle resourcePath] stringByAppendingPathComponent:name]];
    return image;
}

@end
