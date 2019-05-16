

//
//  MineViewController.m
//  TestDemo
//
//  Created by taishu on 2019/5/9.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"
#import "XJSetTable.h"
#import "MineHeaderModel.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EBEDEF"];

//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:@"登录" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    button.frame = CGRectMake(100, 100, 100, 40);
//    [self.view addSubview:button];
    
    MineHeaderModel *header = [[MineHeaderModel alloc] initWithCellIdentifier:@"MineHeaderCell" actionBlock:^(XJBaseCellModel * _Nonnull model) {
        
    }];
    header.cellHeight = 80;
    
    //消息通知
    XJTitleCellModel *msg = [[XJTitleCellModel alloc] initWithTitle:@"消息通知" actionBlock:^(XJBaseCellModel * _Nonnull model) {
        
    }];
    //聊天记录
    XJTitleCellModel *record = [[XJTitleCellModel alloc] initWithTitle:@"聊天记录" actionBlock:^(XJBaseCellModel * _Nonnull model) {
        
    }];
    //空间清理
    XJTitleCellModel *clean = [[XJTitleCellModel alloc] initWithTitle:@"空间清理" actionBlock:^(XJBaseCellModel * _Nonnull model) {
        
    }];
    //消息通知
    XJTitleCellModel *security = [[XJTitleCellModel alloc] initWithTitle:@"账号、设备安全" actionBlock:^(XJBaseCellModel * _Nonnull model) {
        
    }];
    //聊天记录
    XJTitleCellModel *privacy = [[XJTitleCellModel alloc] initWithTitle:@"联系人、隐私" actionBlock:^(XJBaseCellModel * _Nonnull model) {
        
    }];
    //空间清理
    XJTitleCellModel *help = [[XJTitleCellModel alloc] initWithTitle:@"辅助功能" actionBlock:^(XJBaseCellModel * _Nonnull model) {
           
    }];
    //关于QQ与帮助
    XJTitleCellModel *about = [[XJTitleCellModel alloc] initWithTitle:@"关于QQ与帮助" actionBlock:^(XJBaseCellModel * _Nonnull model) {
        
    }];
    
    NSMutableArray *section0 = [NSMutableArray arrayWithObjects:header,nil];
    NSMutableArray *section1 = [NSMutableArray arrayWithObjects:msg, record,clean,nil];
    NSMutableArray *section2 = [NSMutableArray arrayWithObjects:security, privacy,help,nil];
    NSMutableArray *section3 = [NSMutableArray arrayWithObjects:about,nil];
    [self.xj_dataArry addObject:section0];
    [self.xj_dataArry addObject:section1];
    [self.xj_dataArry addObject:section2];
    [self.xj_dataArry addObject:section3];
    [self.xj_tableView reloadData];
}

- (void)loginBtnClick:(UIButton *)button {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:nav animated:YES completion:nil];
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
