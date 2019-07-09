//
//  CouponListViewController.m
//  TestDemo
//
//  Created by LXJ on 09/07/2019.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "CouponListViewController.h"
#import "CouponCell.h"
#import "CouponSuccessView.h"

static NSString *kCouponCell = @"CouponCell";

@interface CouponListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation CouponListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的优惠劵";
    
    [self vcInit];
    
    [self configureUI];
    
    [self getData];
}

- (void)vcInit {
    self.dataArray = [NSMutableArray array];
}

#pragma mark - ConfigureUI
- (void)configureUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.sectionHeaderHeight = 0.01;
    self.tableView.sectionFooterHeight = 0.01;
    
    [self.tableView registerNib:[UINib nibWithNibName:kCouponCell bundle:nil] forCellReuseIdentifier:kCouponCell];
}

#pragma mark - Request
- (void)getData {
    [self.dataArray addObject:@"1"];
    [self.dataArray addObject:@"2"];
    
    [self.tableView reloadData];
}

#pragma mark - TableView datasouce & delegate
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CouponCell *cell = [tableView dequeueReusableCellWithIdentifier:kCouponCell forIndexPath:indexPath];
    cell.getCouponBlock = ^{
        NSLog(@"领取成功");
        CouponSuccessView *couponView = [[CouponSuccessView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [self.view addSubview:couponView];
    };
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

@end
