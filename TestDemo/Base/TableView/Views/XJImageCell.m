//
//  XJImageCell.m
//  TestDemo
//
//  Created by taishu on 2019/5/16.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "XJImageCell.h"
#import "XJImageCellModel.h"
#import "XJSetTable.h"

@interface XJImageCell()

@property (nonatomic, weak) UIImageView *bigImageView;  ///<右边图片显示
@property (nonatomic, weak) NSLayoutConstraint *bigImageRightConstraint;  //大图约束
@property (nonatomic, weak) NSLayoutConstraint *bigImageWidthConstraint;  //大图宽度
@property (nonatomic, weak) NSLayoutConstraint *bigImageHeightConstaint;  //大图高度

@end


@implementation XJImageCell

+ (XJBaseTableViewCell *)cellWithIdentifier:(NSString *)cellIdentifier tableView:(UITableView *)tableView {
    XJImageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[XJImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

- (void)setupUI {
    [super setupUI];
    //添加默认图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectZero;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = YES;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:imageView];
    self.bigImageView = imageView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
    [self.bigImageView addGestureRecognizer:tap];
    
    [self setupBigImageConstraint];
}

//设置大图约束
- (void)setupBigImageConstraint {
    NSLayoutConstraint *bigImageRightConstraint = [NSLayoutConstraint constraintWithItem:self.bigImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-HS_KCellMargin];
    [self.contentView addConstraint:bigImageRightConstraint];
    self.bigImageRightConstraint = bigImageRightConstraint;
    
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.bigImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    
    NSLayoutConstraint *bigImageWidthConstraint = [NSLayoutConstraint constraintWithItem:self.bigImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:HS_KImageWidth];
    [self.contentView addConstraint:bigImageWidthConstraint];
    self.bigImageWidthConstraint = bigImageWidthConstraint;
    
    
    NSLayoutConstraint *bigImageHeightConstaint = [NSLayoutConstraint constraintWithItem:self.bigImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:HS_KImageHeight];
    [self.contentView addConstraint:bigImageHeightConstaint];
    self.bigImageHeightConstaint = bigImageHeightConstaint;
    
}

- (void)setupDataModel:(XJBaseCellModel *)model {
    [super setupDataModel:model];
    
    XJImageCellModel *bigModel = (XJImageCellModel *)model;
    if (!bigModel.imageIcon) {
//        [self.bigImageView sd_setImageWithURL: [NSURL URLWithString:bigModel.imageUrl] placeholderImage:bigModel.placeHoderImage];
    } else {
        self.bigImageView.image = bigModel.imageIcon;
    }
    
    self.bigImageView.layer.cornerRadius = bigModel.cornerRadius > 0 ? bigModel.cornerRadius : 0.f;
    self.bigImageWidthConstraint.constant = bigModel.imageSize.width;
    self.bigImageHeightConstaint.constant = bigModel.imageSize.height;
    if (bigModel.showArrow) {
        self.bigImageRightConstraint.constant = - bigModel.controlRightOffset - bigModel.arrowControlRightOffset - bigModel.arrowWidth;
    } else {
        self.bigImageRightConstraint.constant = - bigModel.controlRightOffset;
    }
}

//点击图片
- (void)clickImage:(UITapGestureRecognizer *)tap {
    XJImageCellModel *bigModel = (XJImageCellModel *)self.cellModel;
    if(bigModel.imageBlock){
        bigModel.imageBlock(self.cellModel);
    }
}
@end
