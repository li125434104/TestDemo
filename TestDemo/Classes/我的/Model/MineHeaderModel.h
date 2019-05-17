//
//  MineHeaderModel.h
//  TestDemo
//
//  Created by taishu on 2019/5/16.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "XJCustomCellModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^loginAction)(void);

@interface MineHeaderModel : XJCustomCellModel

@property (nonatomic, copy) loginAction loginAction;
@property (nonatomic, assign) BOOL isLogin;  //是否登录

- (instancetype)initWithLoginBlock:(loginAction)loginAction actionBlock:(ClickActionBlock)actionblock;
@end

NS_ASSUME_NONNULL_END
