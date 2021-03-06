//
//  XJTitleCellModel.m
//  TestDemo
//
//  Created by taishu on 2019/5/16.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "XJTitleCellModel.h"
#import "HSSetTableViewControllerConst.h"

@implementation XJTitleCellModel

- (instancetype)initWithTitle:(NSString *)title actionBlock:(ClickActionBlock)block {
    if(self = [super init]){
        self.cellHeight = HS_KCellHeight;
        self.title = title;
        self.showArrow = YES;
        self.actionBlock = block;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.separateOffset = HS_KCellMargin;
        self.separateColor = HS_KSeparateColor;
        self.separateHeight = HS_KSeparateHeight;
        self.titleFont = HS_KTitleFont;
        self.titleColor = HS_KTitleColor;
        self.arrowImage = [self imageNamed:@"ic_hs_tableView_arrow"];
        self.arrowWidth = HS_KArrowWidth;
        self.arrowHeight = HS_kArrowHeight;
        self.controlRightOffset = HS_KCellMargin;
        self.arrowControlRightOffset = HS_KCellMargin/2;
        self.titileTextAlignment = NSTextAlignmentLeft;
    }
    return self;
}

- (instancetype)initWithAttributeTitle:(NSAttributedString *)attributeTitle actionBlock:(ClickActionBlock)block {
    if(self = [super init]){
        self.cellHeight = HS_KCellHeight;
        self.attributeTitle = attributeTitle;
        self.showArrow = YES;
        self.actionBlock = block;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.separateColor = HS_KSeparateColor;
        self.separateHeight = HS_KSeparateHeight;
        self.titleFont = HS_KTitleFont;
        self.titleColor = HS_KTitleColor;
        self.arrowImage = [self imageNamed:@"ic_hs_tableView_arrow"];
        self.arrowWidth = HS_KArrowWidth;
        self.arrowHeight = HS_kArrowHeight;
        self.controlRightOffset = HS_KCellMargin;
        self.arrowControlRightOffset = HS_KCellMargin/2;
        self.titileTextAlignment = NSTextAlignmentLeft;
    }
    return self;
}

- (NSString *)cellClass {
    return HSTitleCellModelCellClass;
}

- (UIImage *)imageNamed:(NSString *)name {
    NSBundle *hs_Bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"HSSetTableViewController" ofType:@"bundle"]];
    CGFloat scale = [[UIScreen mainScreen] scale];
    name = 3.0 == scale ? [NSString stringWithFormat:@"%@@3x.png", name] : [NSString stringWithFormat:@"%@@2x.png", name];
    UIImage *image = [UIImage imageWithContentsOfFile:[[hs_Bundle resourcePath] stringByAppendingPathComponent:name]];
    return image;
}


@end
