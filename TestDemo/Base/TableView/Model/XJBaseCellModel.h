//
//  XJBaseCellModel.h
//  TestDemo
//
//  Created by taishu on 2019/5/16.
//  Copyright © 2019 taishu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class XJBaseCellModel;
typedef void(^ClickActionBlock)(XJBaseCellModel *model);

@interface XJBaseCellModel : NSObject

/**
 基础属性
 */
@property (nonatomic, copy, readonly) NSString *identifier;  //唯一标识符(更新会用到)
@property (nonatomic, copy, readonly) NSString *cellClass;   //该模型绑定的cell类名
@property (nonatomic, strong) UIColor *backgroundColor;      //背景颜色
@property (nonatomic, assign) UITableViewCellSelectionStyle selectionStyle;//选中cell效果
@property (nonatomic, assign) CGFloat cellHeight;            //cell高度(默认有高度)
@property (nonatomic, assign) CGFloat separateHeight;        //分割线高度
@property (nonatomic, strong) UIColor *separateColor;        //分割线颜色
@property (nonatomic, assign) CGFloat separateOffset;        //分割线左边间距(默认为0)
@property (nonatomic, copy) ClickActionBlock actionBlock;    //cell点击事件

@end

NS_ASSUME_NONNULL_END
