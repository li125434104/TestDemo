//
//  NSString+Size.h
//  XJTools_Example
//
//  Created by taishu on 2019/4/24.
//  Copyright © 2019 125434104@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Size)

/**
 * 计算文字高度，可以处理计算带行间距的
 */
- (CGFloat)getStringHeightWithWidth:(CGFloat)width
                               font:(UIFont*)font
                        lineSpacing:(CGFloat)lineSpacing;


@end

NS_ASSUME_NONNULL_END
