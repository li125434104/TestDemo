//
//  XJScanTools.m
//  LXJScanQRCode
//
//  Created by taishu on 2019/4/30.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "XJScanTools.h"

@interface XJScanTools()<AVCaptureMetadataOutputObjectsDelegate,AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) AVCaptureSession * session;

/**
 扫描中心识别区域范围
 */
@property (nonatomic, assign) CGRect scanFrame;

/**
 展示输出流的视图——即照相机镜头下的内容
 */
@property (nonatomic, strong) UIView *preview;

@end

@implementation XJScanTools

- (instancetype)initWithPreview:(UIView *)preview andScanFrame:(CGRect)scanFrame {
    if (self == [super init]) {
        self.preview = preview;
        self.scanFrame = scanFrame;
        [self configuredScanTool];
    }
    return self;
}

//初始化采集配置信息
- (void)configuredScanTool {
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.preview.layer.bounds;
    [self.preview.layer insertSublayer:layer atIndex:0];
}

#pragma mark -- Event Handel

- (void)openFlashSwitch:(BOOL)open{
    if (self.flashOpen == open) {
        return;
    }
    self.flashOpen = open;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if ([device hasTorch] && [device hasFlash]){
        
        [device lockForConfiguration:nil];
        if (self.flashOpen){
            device.torchMode = AVCaptureTorchModeOn;
            device.flashMode = AVCaptureFlashModeOn;
        }
        else{
            device.torchMode = AVCaptureTorchModeOff;
            device.flashMode = AVCaptureFlashModeOff;
        }
        
        [device unlockForConfiguration];
    }
    
}

- (void)sessionStartRunning{
    [self.session startRunning];
}

- (void)sessionStopRunning{
    [self.session stopRunning];
}

- (void)scanImageQRCode:(UIImage *)imageCode {
    
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode
                                              context:nil
                                              options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:imageCode.CGImage]];
    if (features.count >= 1){
        CIQRCodeFeature *feature = [features firstObject];
        if(self.scanFinishedBlock != nil){
            self.scanFinishedBlock(feature.messageString);
        }
    }else{
        NSLog(@"无法识别图中二维码");
    }
}

#pragma mark -- AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects.count > 0){
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects firstObject];
        // 扫描完成后的字符
        NSLog(@"扫描出 %@",metadataObject.stringValue);
        if(self.scanFinishedBlock != nil){
            self.scanFinishedBlock(metadataObject.stringValue);
        }
    }
}

#pragma mark- AVCaptureVideoDataOutputSampleBufferDelegate的方法
//扫描过程中执行，主要用来判断环境的黑暗程度
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    
    if (self.monitorLightBlock == nil) {
        return;
    }
    
    CFDictionaryRef metadataDict = CMCopyDictionaryOfAttachments(NULL,sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    NSDictionary *metadata = [[NSMutableDictionary alloc] initWithDictionary:(__bridge NSDictionary*)metadataDict];
    CFRelease(metadataDict);
    NSDictionary *exifMetadata = [[metadata objectForKey:(NSString *)kCGImagePropertyExifDictionary] mutableCopy];
    float brightnessValue = [[exifMetadata objectForKey:(NSString *)kCGImagePropertyExifBrightnessValue] floatValue];
    
    //    NSLog(@"环境光感 ： %f",brightnessValue);
    
    // 根据brightnessValue的值来判断是否需要打开和关闭闪光灯
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    BOOL result = [device hasTorch];// 判断设备是否有闪光灯
    if ((brightnessValue < 0) && result) {
        // 环境太暗，可以打开闪光灯了
    }else if((brightnessValue > 0) && result){
        // 环境亮度可以
    }
    if (self.monitorLightBlock != nil) {
        self.monitorLightBlock(brightnessValue);
    }
    
}

#pragma mark - Getter
- (AVCaptureSession *)session {
    if (_session == nil) {
        
        if ([self isAvailableCamera]) {
            //获取摄像设备
            AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            //创建输入流
            AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
            if (!input) {
                return nil;
            }
            //创建二维码扫描输出流
            AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
            //设置代理，在主线程刷新
            [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
            
            //设置采集扫描区域的比例 默认全屏是（0，0，1，1）
            //rectOfInterest 填写的是一个比例，输出流视图preview.frame为 x , y, w, h, 要设置的矩形快的scanFrame 为 x1, y1, w1, h1. 那么rectOfInterest 应该设置为 CGRectMake(y1/y, x1/x, h1/h, w1/w)。
            CGFloat x = CGRectGetMinX(self.scanFrame) / CGRectGetWidth(self.preview.frame);
            CGFloat y = CGRectGetMinY(self.scanFrame) / CGRectGetHeight(self.preview.frame);
            CGFloat width = CGRectGetWidth(self.scanFrame) / CGRectGetWidth(self.preview.frame);
            CGFloat height = CGRectGetHeight(self.scanFrame) / CGRectGetHeight(self.preview.frame);
            output.rectOfInterest = CGRectMake(y, x, height, width);
            
            // 创建环境光感输出流
            AVCaptureVideoDataOutput *lightOutput = [[AVCaptureVideoDataOutput alloc] init];
            [lightOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
            
            _session = [[AVCaptureSession alloc] init];
            //高质量采集率
            [_session setSessionPreset:AVCaptureSessionPresetHigh];
            [_session addInput:input];
            [_session addOutput:output];
            [_session addOutput:lightOutput];
            
            //设置扫码支持的编码格式(这里设置条形码和二维码兼容)
            output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                           AVMetadataObjectTypeEAN13Code,
                                           AVMetadataObjectTypeEAN8Code,
                                           AVMetadataObjectTypeCode128Code];
        }
        
    }
    return _session;
}
#pragma mark -- Helper
- (BOOL)isAvailableCamera {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        /// 用户是否允许摄像头使用
        NSString * mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        /// 不允许弹出提示框
        if (authorizationStatus == AVAuthorizationStatusRestricted ||
            authorizationStatus == AVAuthorizationStatusDenied) {
            NSString *tipMessage = [NSString stringWithFormat:@"请到手机系统的\n【设置】->【隐私】->【相机】\n对App开启相机的访问权限"];
            [self showError:tipMessage andTitle:@"相机权限未开启"];
            
            return NO;
        }else{
            return  YES;
        }
    } else {
        //相机硬件不可用【一般是模拟器】
        return NO;
    }
}

- (void)showError:(NSString*)str {
    [self showError:str andTitle:@"提示"];
}

- (void)showError:(NSString*)str andTitle:(NSString *)title
{
    [self.session stopRunning];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:str preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *action1 = ({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.session startRunning];
        }];
        action;
    });
    
    [alert addAction:action1];
    
    [[self getCurrentVC] presentViewController:alert animated:YES completion:NULL];
}

- (UIViewController *)getCurrentVC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}
@end
