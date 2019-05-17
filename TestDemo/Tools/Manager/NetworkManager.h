//
//  NetworkManager.h
//  TestDemo
//
//  Created by taishu on 2019/5/17.
//  Copyright © 2019 taishu. All rights reserved.
//
/**
 XMNetworking 使用配置示例
 */
#import <Foundation/Foundation.h>
#import "XMNetworking.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XMNetworkErrorCode) {
    kXMSuccessCode = 200,      //!< 接口请求成功
    kXMErrorCode = 1,        //!< 接口请求失败
    kXMUnknownCode = -1,     //!< 未知错误
};

@interface NetworkManager : NSObject

/**
 初始化网络配置
 */
+ (void)setup;

@end

NS_ASSUME_NONNULL_END
