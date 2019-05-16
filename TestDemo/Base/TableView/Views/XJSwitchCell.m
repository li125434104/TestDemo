//
//  XJSwitchCell.m
//  TestDemo
//
//  Created by taishu on 2019/5/16.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "XJSwitchCell.h"
#import "XJSetTable.h"
#import "XJSwitchCellModel.h"

@interface XJSwitchCell()

@property (nonatomic, weak) UISwitch *switchItem;  ///<开关
@property (nonatomic, weak) NSLayoutConstraint *switchRightConstaint;  ///<

@end
@implementation XJSwitchCell

+ (XJBaseTableViewCell *)cellWithIdentifier:(NSString *)cellIdentifier tableView:(UITableView *)tableView {
    XJSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[XJSwitchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setupUI {
    [super setupUI];
    //添加开关控件
    UISwitch *switchItem = [[UISwitch alloc] initWithFrame:CGRectZero];
    [switchItem addTarget:self action:@selector(switchChang:) forControlEvents:UIControlEventValueChanged];
    switchItem.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:switchItem];
    self.switchItem = switchItem;
    
    [self setupSwitchItemConstrnts];
}

- (void)setupSwitchItemConstrnts {
    
    NSLayoutConstraint *switchRightConstaint = [NSLayoutConstraint constraintWithItem:self.switchItem attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant: -HS_KCellMargin];
    [self.contentView addConstraint:switchRightConstaint];
    self.switchRightConstaint = switchRightConstaint;
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.switchItem attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.switchItem attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:HS_KSwitchWidth]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.switchItem attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:HS_KSwitchHeight]];
}

- (void)setupDataModel:(XJBaseCellModel *)model {
    [super setupDataModel:model];
    XJSwitchCellModel *switchModel = (XJSwitchCellModel *)model;
    self.switchItem.on = switchModel.on;
    if (switchModel.onTintColor) {
        self.switchItem.onTintColor = switchModel.onTintColor;
    }
    self.switchRightConstaint.constant = - switchModel.controlRightOffset;
    
}

- (void)switchChang:(UISwitch *)switchItem {
    XJSwitchCellModel *model = (XJSwitchCellModel *)self.cellModel;
    model.on = switchItem.on;
    if(model.switchBlock){
        model.switchBlock(self.cellModel,switchItem.on);
    }
}

@end
