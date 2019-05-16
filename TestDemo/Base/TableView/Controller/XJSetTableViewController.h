//
//  XJSetTableViewController.h
//  TestDemo
//
//  Created by taishu on 2019/5/15.
//  Copyright © 2019 taishu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJBaseCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XJSetTableViewController : UIViewController

@property (nonatomic, weak) UITableView *xj_tableView;       //tableView
@property (nonatomic, strong) NSMutableArray *xj_dataArry;   //数据源

/**
 更新cell模型方法
 
 @param cellModel model
 */
- (void)updateCellModel:(XJBaseCellModel *)cellModel;


/**
 更新cell模型方法
 
 @param cellModel model
 @param animation 动画效果
 */
- (void)updateCellModel:(XJBaseCellModel *)cellModel animation:(UITableViewRowAnimation)animation;


/**
 footer 高度 tableView代理方法
 
 @param tableView tableView
 @param section section
 @return footer高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;


/**
 footer View tableView代理方法
 
 @param tableView tableView
 @param section section
 @return footer View
 */
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;


/**
 header view tableView代理方法
 
 @param tableView tableView
 @param section section
 @return header
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;


/**
 header 高度 tableView代理方法
 
 @param tableView tableView
 @param section section
 @return header 高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
