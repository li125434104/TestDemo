//
//  MYKitDefinition.h
//  MYKitDemo
//
//  Created by michael on 2019/2/12.
//  Copyright © 2019 com.51fanxing. All rights reserved.
//

#ifndef MYKitDefinition_h
#define MYKitDefinition_h

// 系统版本
#define SYSTEM_VERSION  [[[UIDevice currentDevice] systemVersion] floatValue]
#define IOS_8   (SYSTEM_VERSION >= 7.0 && SYSTEM_VERSION < 8.0)
#define IOS_9   (SYSTEM_VERSION >= 8.0 && SYSTEM_VERSION < 9.0)
#define IOS_10  (SYSTEM_VERSION >= 10.0 && SYSTEM_VERSION < 11.0)
#define IOS_11  (SYSTEM_VERSION >= 11.0 && SYSTEM_VERSION < 12.0)
#define IOS_12  (SYSTEM_VERSION >= 12.0 && SYSTEM_VERSION < 13.0)

#define IOS_AT_LEAST_8  (SYSTEM_VERSION >= 8.0)
#define IOS_AT_LEAST_9  (SYSTEM_VERSION >= 9.0)
#define IOS_AT_LEAST_10 (SYSTEM_VERSION >= 10.0)
#define IOS_AT_LEAST_11 (SYSTEM_VERSION >= 11.0)
#define IOS_AT_LEAST_12 (SYSTEM_VERSION >= 12.0)

// 型号
#define DEVICE_IPAD         (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define DEVICE_IPHONE       (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

// 特殊手机型号, 刘海屏: iPhoneX, iPhone XS, iPhone XR...
// 获取底部安全区域高度，iPhone X 竖屏下为 34.0，横屏下为 21.0，其他类型设备都为 0
#define DEVICE_IPHONE_X \
({  \
BOOL isIPhoneX = NO;    \
if (@available(iOS 11.0, *)) {  \
UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];    \
BOOL isDeviceX = NO;    \
CGFloat bottomSafeInset = keyWindow.safeAreaInsets.bottom;  \
isDeviceX = bottomSafeInset == 34.0f || bottomSafeInset == 21.0f;  \
isIPhoneX = isDeviceX && DEVICE_IPHONE;\
}   \
(isIPhoneX);    \
})  \

// 特殊手机型号, 小手机: iPhone4S, iPhone5S... (屏幕为3.5英寸或者4英寸)
#define DEVICE_IPHONE_SMALL (DEVICE_IPHONE && (DEFALUT_SCREEN_WIDTH == 320 || DEFALUT_SCREEN_HEIGHT == 320))

// 屏幕方向
#define DEVICE_STATUS_BAR_ORIENTATION   [[UIApplication sharedApplication] statusBarOrientation]
#define DEVICE_PORTRAIT \
(DEVICE_STATUS_BAR_ORIENTATION == UIInterfaceOrientationPortrait || DEVICE_STATUS_BAR_ORIENTATION == UIDeviceOrientationPortraitUpsideDown)
#define DEVICE_LANDSCAPE \
(DEVICE_STATUS_BAR_ORIENTATION == UIDeviceOrientationLandscapeRight || DEVICE_STATUS_BAR_ORIENTATION == UIDeviceOrientationLandscapeLeft)

// 像素
#define kScreenWidth     [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight    [[UIScreen mainScreen] bounds].size.height
#define DEFALUT_STATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
#define ORIENTATION_SCREEN_WIDTH   MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#define ORIENTATION_SCREEN_HEIGHT  MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)

#define kStateBar  (kScreenHeight >= 812.0 ? 44 : 20)            //状态栏高度
#define kNavigationBar (44+kStateBar)       //导航栏的高度
#define SafeAreaBottomHeight (kScreenHeight >= 812.0 ? 39 : 0)
#define kTabbar  (SafeAreaBottomHeight+49)             //工具栏的高度
#define kNavDistance ios7?64:44    //顶部的高度

// 默认设计稿像素
#define DEFALUT_PHONE_SCALE_PX 375.0
#define DEFALUT_PAD_SCALE_PX   1024.0

// 比例像素
#define PHONE_SCALE_PX(value)  ceil((value / (DEFALUT_PHONE_SCALE_PX / [UIScreen mainScreen].bounds.size.width)))
#define PAD_SCALE_PX(value)    ceil((value / (DEFALUT_PAD_SCALE_PX / [UIScreen mainScreen].bounds.size.width)))
#define ORIENTATION_PHONE_SCALE_PX(value)  ceil((value / (DEFALUT_PHONE_SCALE_PX / ORIENTATION_SCREEN_WIDTH)))

// 字体
#define DEFALUT_FONT(size)      [UIFont systemFontOfSize:size]
#define DEFALUT_BOLD_FONT(size) [UIFont boldSystemFontOfSize:size]
#define PF_REGULAR_FONT(_size_) [UIFont fontWithName:@"PingFangSC-Regular" size:_size_]
#define PF_MEDIUM_FONT(_size_)  [UIFont fontWithName:@"PingFangSC-Medium" size:_size_]

// 颜色
// RGBA
#define COLOR_RGBA(r, g, b ,a) \
[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define COLOR_RGB(r, g, b)  COLOR_RGBA(r, g, b, 1.0)

// 16进制
#define COLOR_HEXA(hex, a) \
[UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:a]
#define COLOR_HEX(hex)  COLOR_HEXA(hex, 1.0)

// 设备适配
#define ITGSafeAreaInsets() \
({ \
UIEdgeInsets insets; \
if (@available(iOS 11.0, *)) { \
insets = UIApplication.sharedApplication.keyWindow.safeAreaInsets; \
} else { \
insets = UIEdgeInsetsZero; \
} \
(insets); \
}) \

#endif /* MYKitDefinition_h */
