//
//  XJSetTableViewController.m
//  TestDemo
//
//  Created by taishu on 2019/5/15.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "XJSetTableViewController.h"
#import "XJBaseTableViewCell.h"
#import "CALayer+Addition.h"
#import "HSSetTableViewControllerConst.h"

@interface XJSetTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation XJSetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    
    if(floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_8_x_Max){
        tableView.cellLayoutMarginsFollowReadableWidth = NO;
    }
    [self.view addSubview:tableView];
    self.xj_tableView = tableView;
    
    [self setupTableViewConstrint];
}

//设置tableView约束
- (void)setupTableViewConstrint {
    
    if (@available(iOS 11.0, *)) {
        NSLayoutConstraint *tableViewTopConstraint = [NSLayoutConstraint constraintWithItem:self.xj_tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view.safeAreaLayoutGuide attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        [self.view addConstraint:tableViewTopConstraint];
        
        
        NSLayoutConstraint *tableViewLeftConstraint = [NSLayoutConstraint constraintWithItem:self.xj_tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view.safeAreaLayoutGuide attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        [self.view addConstraint:tableViewLeftConstraint];
        
        
        NSLayoutConstraint *tableViewRightConstraint = [NSLayoutConstraint constraintWithItem:self.xj_tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view.safeAreaLayoutGuide attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        [self.view addConstraint:tableViewRightConstraint];
        
        NSLayoutConstraint *tableViewBottomConstraint = [NSLayoutConstraint constraintWithItem:self.xj_tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view.safeAreaLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        [self.view addConstraint:tableViewBottomConstraint];
    }else{
        NSLayoutConstraint *tableViewTopConstraint = [NSLayoutConstraint constraintWithItem:self.xj_tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        [self.view addConstraint:tableViewTopConstraint];
        
        
        NSLayoutConstraint *tableViewLeftConstraint = [NSLayoutConstraint constraintWithItem:self.xj_tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        [self.view addConstraint:tableViewLeftConstraint];
        
        
        NSLayoutConstraint *tableViewRightConstraint = [NSLayoutConstraint constraintWithItem:self.xj_tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        [self.view addConstraint:tableViewRightConstraint];
        
        NSLayoutConstraint *tableViewBottomConstraint = [NSLayoutConstraint constraintWithItem:self.xj_tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        [self.view addConstraint:tableViewBottomConstraint];
    }
}

#pragma mark -- TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.xj_dataArry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *rows = [self.xj_dataArry objectWithIndex:section];
    NSAssert([rows isKindOfClass:[NSMutableArray class]], @"此对象必须为一个可变数组,请检查数据源组装方式是否正确!");
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *sections = [self.xj_dataArry objectWithIndex:indexPath.section];
    NSAssert([sections isKindOfClass:[NSMutableArray class]], @"此对象必须为一个可变数组,请检查数据源组装方式是否正确!");
    XJBaseCellModel *cellModel = (XJBaseCellModel *)[sections objectWithIndex:indexPath.row];
    Class class = NSClassFromString(cellModel.cellClass);
    XJBaseTableViewCell *cell = [class cellWithIdentifier:cellModel.cellClass tableView:tableView];
    [cell setupDataModel:cellModel];
    //处理分割线
    cell.topLine.hidden = indexPath.row != 0;
    [cell.bottomLine setHs_x:(indexPath.row == sections.count - 1 ? 0:cellModel.separateOffset)];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *sections = [self.xj_dataArry objectWithIndex:indexPath.section];
    NSAssert([sections isKindOfClass:[NSMutableArray class]], @"此对象必须为一个可变数组,请检查数据源组装方式是否正确!");
    XJBaseCellModel *cellModel = (XJBaseCellModel *)[sections objectWithIndex:indexPath.row];
    Class class =  NSClassFromString(cellModel.cellClass);
    return [class getCellHeight:cellModel];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *sections = [self.xj_dataArry objectWithIndex:indexPath.section];
    NSAssert([sections isKindOfClass:[NSMutableArray class]], @"此对象必须为一个可变数组,请检查数据源组装方式是否正确!");
    XJBaseCellModel *cellModel = (XJBaseCellModel *)[sections objectWithIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:cellModel.actionBlock == nil];
    if(cellModel.actionBlock){
        cellModel.actionBlock(cellModel);
    }
}

#pragma mark tableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return  0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //如果是第一个section
    if (section == 0) return nil;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, HS_SectionHeight)];
    [view setBackgroundColor:[UIColor clearColor]];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    //默认
    if(section == 0) return 0.01;
    return HS_SectionHeight;
}

- (void)updateCellModel:(XJBaseCellModel *)cellModel {
    [self updateCellModel:cellModel animation:UITableViewRowAnimationFade];
}

- (void)updateCellModel:(XJBaseCellModel *)cellModel animation:(UITableViewRowAnimation)animation {
    //这里根据模型标题是否一样，是更新的哪个model
    NSMutableArray *tempData = [NSMutableArray arrayWithArray:self.xj_dataArry];
    [tempData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx1, BOOL * _Nonnull stop) {
        NSMutableArray *sections = (NSMutableArray *)obj;
        NSAssert([sections isKindOfClass:[NSMutableArray class]], @"此对象必须为一个可变数组,请检查数据源组装方式是否正确!");
        [sections enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx2, BOOL * _Nonnull stop) {
            XJBaseCellModel *model  = (XJBaseCellModel *)obj;
            if([model.identifier isEqualToString:cellModel.identifier]){
                //找到section中的数组
                NSMutableArray *rows = [self.xj_dataArry objectWithIndex:idx1];
                //找到某个具体哪一行，进行数据替换
                [rows replaceObjectAtIndex:idx2 withObject:cellModel];
                //更新cell
                NSIndexPath *path = [NSIndexPath indexPathForRow:idx2 inSection:idx1];
                [self.xj_tableView beginUpdates];
                [self.xj_tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:animation];
                [self.xj_tableView endUpdates];
                *stop = YES;
                return;
            }
        }];
    }];
}

#pragma mark -- Setter & Getter
- (NSMutableArray *)xj_dataArry {
    if (!_xj_dataArry) {
        _xj_dataArry = [NSMutableArray array];
    }
    return _xj_dataArry;
}

- (void)dealloc {
    if(self.xj_tableView){
        self.xj_tableView.delegate = nil;
        self.xj_tableView.dataSource = nil;
        [self.xj_tableView removeFromSuperview];
        self.xj_tableView = nil;
    }
    if(self.xj_dataArry){
        [self.xj_dataArry removeAllObjects];
        self.xj_dataArry = nil;
    }
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
