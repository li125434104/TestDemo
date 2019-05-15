//
//  NSString+Regular.h
//  XJTools_Example
//
//  Created by taishu on 2019/4/24.
//  Copyright © 2019 125434104@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Regular)

/**
 验证字符串是否邮箱格式
 */
- (BOOL)vertifyEmail;

/**
 验证字符串是否中文
 */
- (BOOL)vertifyChinese;

/**
 验证字符串是否6-18位大小字母混合数字密码
 */
- (BOOL)vertifyPassword;

/**
 验证是否是手机号码
 */
- (BOOL)vertifyMobilePhone;

/**
 验证是否是座机号码
 */
- (BOOL)vertifyTelephone;

/**
 验证是否是车牌号码
 */
- (BOOL)vertifyCarNumber;

/**
 验证是否是身份证号码
 */
- (BOOL)vertifyIdentifierNumber;

/**
 验证是否是IP地址
 */
- (BOOL)vertifyIpAddress;

/**
 验证是否是超链接
 */
- (BOOL)vertifyHyperLink;
@end

NS_ASSUME_NONNULL_END
