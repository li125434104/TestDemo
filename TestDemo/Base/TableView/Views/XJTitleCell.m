//
//  XJTitleCell.m
//  TestDemo
//
//  Created by taishu on 2019/5/16.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "XJTitleCell.h"
#import "XJSetTable.h"

@interface XJTitleCell()

@property (nonatomic, weak)NSLayoutConstraint *arrowWidthContraint;  //箭头宽度contraint
@property (nonatomic, weak)NSLayoutConstraint *arrowHeightContraint; //箭头高度contraint
@property (nonatomic, weak)NSLayoutConstraint *arrowRightContraint;  //箭头距右边contraint

@end

@implementation XJTitleCell

+ (XJBaseTableViewCell *)cellWithIdentifier:(NSString *)cellIdentifier tableView:(UITableView *)tableView;
{
    XJTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[XJTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)setupUI
{
    [super setupUI];
    //添加右边剪头
    UIImageView *arrow = [[UIImageView alloc] init];
    arrow.frame = CGRectZero;
    arrow.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:arrow];
    self.arrow = arrow;
    [self setupArrowImageConstraints];//设置图片约束
}

- (void)setupArrowImageConstraints
{
    
    NSLayoutConstraint *arrowRightContraint = [NSLayoutConstraint constraintWithItem:self.arrow attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-HS_KCellMargin];
    [self.contentView addConstraint:arrowRightContraint];
    self.arrowRightContraint = arrowRightContraint;
    
    
    NSLayoutConstraint *arrowWidthContraint = [NSLayoutConstraint constraintWithItem:self.arrow attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:HS_KArrowWidth];
    [self.contentView addConstraint:arrowWidthContraint];
    self.arrowWidthContraint = arrowWidthContraint;
    
    
    NSLayoutConstraint *arrowHeightContraint = [NSLayoutConstraint constraintWithItem:self.arrow attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:HS_kArrowHeight];
    
    [self.contentView addConstraint:arrowHeightContraint];
    self.arrowHeightContraint = arrowHeightContraint;
    
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.arrow attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
}

- (void)setupDataModel:(XJBaseCellModel *)model {
    [super setupDataModel:model];
    
    XJTitleCellModel *cellMoldel = (XJTitleCellModel *)model;
    if (cellMoldel.attributeTitle) {
        self.textLabel.attributedText = cellMoldel.attributeTitle;
    } else {
        self.textLabel.text = cellMoldel.title;
        self.textLabel.textColor = cellMoldel.titleColor;
        self.textLabel.font = cellMoldel.titleFont;
    }
    self.textLabel.textAlignment = cellMoldel.titileTextAlignment;
    self.imageView.image = cellMoldel.icon;
    
    self.backgroundColor = model.backgroundColor?:[UIColor whiteColor];
    self.arrow.hidden = !cellMoldel.showArrow;
    self.selectionStyle = cellMoldel.selectionStyle;
    self.arrow.image = cellMoldel.arrowImage;
    
    self.arrowWidthContraint.constant = cellMoldel.arrowWidth;
    self.arrowHeightContraint.constant = cellMoldel.arrowHeight;
    self.arrowRightContraint.constant = - cellMoldel.controlRightOffset;
}

@end
