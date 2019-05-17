

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
#import "MineHeaderCell.h"

@interface MineViewController ()
@property (nonatomic, strong) MineHeaderModel *header;  //头部ViewcCell
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EBEDEF"];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:@"loginSuccess" object:nil];
    
    self.header = [[MineHeaderModel alloc] initWithLoginBlock:^{
        [self loginBtnClick];
        NSLog(@"dddd");
    } actionBlock:^(XJBaseCellModel * _Nonnull model) {
        
    }];
    self.header.isLogin = NO;
    self.header.cellHeight = 80;

  
    
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
    
    NSMutableArray *section0 = [NSMutableArray arrayWithObjects:self.header,nil];
    NSMutableArray *section1 = [NSMutableArray arrayWithObjects:msg, record,clean,nil];
    NSMutableArray *section2 = [NSMutableArray arrayWithObjects:security, privacy,help,nil];
    NSMutableArray *section3 = [NSMutableArray arrayWithObjects:about,nil];
    [self.xj_dataArry addObject:section0];
    [self.xj_dataArry addObject:section1];
    [self.xj_dataArry addObject:section2];
    [self.xj_dataArry addObject:section3];
    [self.xj_tableView reloadData];
}

- (void)loginBtnClick {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)loginSuccess {
    self.header.isLogin = YES;
    [self updateCellModel:self.header];
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
