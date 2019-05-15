//
//  NSString+Trims.h
//  XJTools_Example
//
//  Created by taishu on 2019/4/24.
//  Copyright © 2019 125434104@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Trims)

/**
 清除html标签

 @return 清除后的html字符串
 */
- (NSString *)stringByStrippingHTML;

/**
 清除js脚本

 @return 清除后的字符串
 */
- (NSString *)stringByRemovingScriptsAndStrippingHTML;

/**
 去除字符串中的回车

 @return 返回的字符串
 */
- (NSString *)stirngByTrimReturnKey;

/**
 去除空格与空行

 @return 返回的字符串
 */
- (NSString *)trimmingWhitespaceAndNewlines;
@end

NS_ASSUME_NONNULL_END
