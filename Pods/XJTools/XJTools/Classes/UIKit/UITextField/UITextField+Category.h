//
//  UITextField+Category.h
//  XJTools_Example
//
//  Created by taishu on 2019/4/28.
//  Copyright © 2019 125434104@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Category)

@property (nonatomic, assign) NSInteger maxLength;

/**
 *  modify default placeholder padding
 */
@property (assign, nonatomic) CGFloat leftPadding;

/**
 *  modify default placeholder color
 */
@property (strong,nonatomic) UIColor *placeHolderColor;

@end

NS_ASSUME_NONNULL_END
