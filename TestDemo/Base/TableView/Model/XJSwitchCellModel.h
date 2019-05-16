//
//  XJSwitchCellModel.h
//  TestDemo
//
//  Created by taishu on 2019/5/16.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "XJTitleCellModel.h"
#import "XJTitleCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@class XJBaseCellModel;
typedef void(^switchBlock)(XJBaseCellModel *model,BOOL on);

@interface XJSwitchCellModel : XJTitleCellModel

@property (nonatomic, assign) BOOL on;  //开关状态
@property (nonatomic, strong) UIColor *onTintColor;  //开启状态颜色
@property (nonatomic, copy) switchBlock switchBlock;  //block调用

/**
 开关cell初始化方法
 
 @param title 开关cell标题
 @param on 开关状态
 @param block block
 @return HSSwitchCellModel
 */
- (instancetype)initWithTitle:(NSString *)title switchType:(BOOL)on switchBlock:(switchBlock)block;

@end

NS_ASSUME_NONNULL_END
