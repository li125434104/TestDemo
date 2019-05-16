//
//  XJSwitchCellModel.m
//  TestDemo
//
//  Created by taishu on 2019/5/16.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "XJSwitchCellModel.h"
#import "XJSetTable.h"

@implementation XJSwitchCellModel

- (instancetype)initWithTitle:(NSString *)title switchType:(BOOL)on switchBlock:(switchBlock)block {
    if(self = [super initWithTitle:title actionBlock:^(XJBaseCellModel * _Nonnull model) {
        
    }]){
        self.switchBlock = block;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.showArrow = NO;
        self.on = on;
    }
    return self;
}

- (NSString *)cellClass {
    return HSSwitchCellModelCellClass;
}

@end
