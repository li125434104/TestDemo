

//
//  XJBaseTableViewCell.m
//  TestDemo
//
//  Created by taishu on 2019/5/16.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "XJBaseTableViewCell.h"
#import "HSSetTableViewControllerConst.h"
#import "CALayer+Addition.h"

@implementation XJBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//cell初始化方法
+ (XJBaseTableViewCell *)cellWithIdentifier:(NSString *)cellIdentifier tableView:(UITableView *)tableView {
    XJBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[XJBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setupUI];
    }
    return self;
}

//初始化UI方法
- (void)setupUI {
    //添加顶部分割线
    CALayer *topLine = [CALayer layer];
    [topLine setFrame:CGRectMake(0, 0, self.frame.size.width, HS_KSeparateHeight)];
    [topLine setBackgroundColor:HS_KSeparateColor.CGColor];
    [self.contentView.layer addSublayer:topLine];
    self.topLine = topLine;
    
    //添加底部分割线
    CALayer *bottomLine = [CALayer layer];
    [bottomLine setFrame:CGRectMake(0, 0, self.frame.size.width, HS_KSeparateHeight)];
    [bottomLine setBackgroundColor:HS_KSeparateColor.CGColor];
    [self.contentView.layer addSublayer:bottomLine];
    self.bottomLine = bottomLine;
}

//设置数据源方法
- (void)setupDataModel:(XJBaseCellModel *)model {
    self.cellModel = model;
    self.selectionStyle = model.selectionStyle;
    [self.bottomLine setHs_y:model.cellHeight - model.separateHeight];
    [self.bottomLine setHs_height:model.separateHeight];
    [self.topLine setHs_height:model.separateHeight];
    [self.bottomLine setBackgroundColor:model.separateColor.CGColor];
    [self.topLine setBackgroundColor:model.separateColor.CGColor];
}

//获取cell高度方法
+ (CGFloat)getCellHeight:(XJBaseCellModel *)model {
    return model.cellHeight;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.bottomLine setHs_width:self.frame.size.width];
    [self.topLine setHs_width:self.frame.size.width];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
