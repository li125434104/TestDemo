//
//  XJBaseTableViewCell.h
//  TestDemo
//
//  Created by taishu on 2019/5/16.
//  Copyright © 2019 taishu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJBaseCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XJBaseTableViewCell : UITableViewCell

@property (nonatomic, strong) XJBaseCellModel *cellModel;
@property (nonatomic, weak) CALayer *topLine;    //顶部分割线
@property (nonatomic, weak) CALayer *bottomLine; //底部分割线

//cell初始化方法
+ (XJBaseTableViewCell *)cellWithIdentifier:(NSString *)cellIdentifier tableView:(UITableView *)tableView;
//初始化UI方法
- (void)setupUI;
//设置数据源方法
- (void)setupDataModel:(XJBaseCellModel *)model;
//获取cell高度方法
+ (CGFloat)getCellHeight:(XJBaseCellModel *)model;

@end

NS_ASSUME_NONNULL_END
