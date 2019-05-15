//
//  NSURL+Param.h
//  XJTools_Example
//
//  Created by taishu on 2019/4/25.
//  Copyright © 2019 125434104@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (Param)

/**
 url参数转字典

 @return 转换够得到的字典
 */
- (NSDictionary *)parameters;

/**
 根据参数名获取参数值

 @param parameterKey 参数名
 @return 返回的参数值
 */
- (NSString *)valueForParameter:(NSString *)parameterKey;
@end

NS_ASSUME_NONNULL_END
