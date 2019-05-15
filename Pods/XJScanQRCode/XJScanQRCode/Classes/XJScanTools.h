//
//  XJScanTools.h
//  LXJScanQRCode
//
//  Created by taishu on 2019/4/30.
//  Copyright © 2019 taishu. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AVFoundation;
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface XJScanTools : NSObject

/**
 扫描结果回调
 */
@property (nonatomic, copy) void(^scanFinishedBlock)(NSString *);

/**
 监听环境光感的回调
 @param brightness 亮度值
 */
@property (nonatomic, copy) void(^monitorLightBlock)(float);

/**
 闪光灯的状态,不需要设置，仅供外边判断状态使用
 */
@property (nonatomic, assign) BOOL flashOpen;

- (instancetype)initWithPreview:(UIView *)preview andScanFrame:(CGRect)scanFrame;

/**
 闪光灯开关
 */
- (void)openFlashSwitch:(BOOL)open;

- (void)sessionStartRunning;

- (void)sessionStopRunning;

/**
 识别图中二维码
 */
- (void)scanImageQRCode:(UIImage *_Nullable)imageCode;

@end

NS_ASSUME_NONNULL_END
