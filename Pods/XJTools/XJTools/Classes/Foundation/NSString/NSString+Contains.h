//
//  NSString+Contains.h
//  XJTools_Example
//
//  Created by taishu on 2019/4/25.
//  Copyright © 2019 125434104@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Contains)

/**
 是否包含空格

 @return 是否
 */
- (BOOL)isContainBlank;

/**
 是否包含某字符串

 @param string 字符串
 @return 是否
 */
- (BOOL)isContainsString:(NSString *)string;

/**
 Unicode编码转换成字符串

 @return 返回的字符串
 */
- (NSString *)makeUnicodeToString;

/**
 *  @brief 获取字符数量
 */
- (int)stringCount;
@end

NS_ASSUME_NONNULL_END
