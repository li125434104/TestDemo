//
//  NSString+URLEncode.h
//  XJTools_Example
//
//  Created by taishu on 2019/4/25.
//  Copyright © 2019 125434104@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (URLEncode)

/**
 urlEncode操作
 */
- (NSString *)urlEncode;

/**
 urlEncode操作

 @param encoding encoding模式
 @return 返回的字符串 
 */
- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;

/**
 urlDecode
 */
- (NSString *)urlDecode;

/**
 urlDecoding操作

 @param encoding decoding模式
 @return 返回的字符串
 */
- (NSString *)urlDecodeUsingEncoding:(NSStringEncoding)encoding;

@end

NS_ASSUME_NONNULL_END
