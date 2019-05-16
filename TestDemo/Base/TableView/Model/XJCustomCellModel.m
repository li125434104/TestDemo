//
//  XJCustomCellModel.m
//  TestDemo
//
//  Created by taishu on 2019/5/16.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "XJCustomCellModel.h"
#import "XJSetTable.h"

@interface XJCustomCellModel()
{
    NSString *privateCellClass;///<私有变量
}
@end

@implementation XJCustomCellModel

- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier actionBlock:(ClickActionBlock)block {
    if(self = [super init]){
        self.cellHeight = HS_KCellHeight;
        self.actionBlock = block;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.separateOffset = HS_KCellMargin;
        self.separateColor = HS_KSeparateColor;
        self.separateHeight = HS_KSeparateHeight;
        //cellClass 为与cell类名绑定的自定义cell类名必须一致，类名作为identifier的重用标示符号,如果不一致将报错。
        privateCellClass = cellIdentifier;
    }
    return self;
}

- (NSString *)cellClass {
    return privateCellClass;
}


@end
