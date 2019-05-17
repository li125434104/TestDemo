//
//  MineHeaderModel.m
//  TestDemo
//
//  Created by taishu on 2019/5/16.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "MineHeaderModel.h"

@implementation MineHeaderModel

- (instancetype)initWithLoginBlock:(loginAction)loginAction actionBlock:(ClickActionBlock)actionblock {
    if(self = [super initWithCellIdentifier:@"" actionBlock:^(XJBaseCellModel * _Nonnull model) {
        
    }]){
        self.loginAction = loginAction;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (NSString *)cellClass
{
    return @"MineHeaderCell";
}
@end
