//
//  XJScanView.m
//  LXJScanQRCode
//
//  Created by taishu on 2019/4/30.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "XJScanView.h"

@interface XJScanView ()

//动画线条
@property (nonatomic,strong) UIImageView *scanLine;
//网络状态提示语
@property (nonatomic,strong) UILabel *netLabel;
//菊花等待
@property(nonatomic,strong) UIActivityIndicatorView *activityView;
//扫描结果处理中
@property(nonatomic,strong) UIView *handlingView;
//是否正在动画
@property(nonatomic,assign) BOOL isAnimating;
//手电筒开关
@property(nonatomic,strong) UIButton *flashBtn;
//闪光灯开关的状态
@property (nonatomic, assign) BOOL flashOpen;

@end

@implementation XJScanView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _scanSweepAreaRect = CGRectMake(60, 130, frame.size.width - 2 * 60, frame.size.width - 2 * 60);
        _notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _isNeedShowRetangle = YES;
        _colorRetangleLine = [UIColor whiteColor];
        _photoframeAngleW = 20;
        _photoframeAngleH = 20;
        _colorAngle = [UIColor greenColor];
        _photoframeLineW = 4;
        _animationImage = [UIImage imageNamed:@"scanLine"];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self drawScanRect];
    // app退到后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterBackground) name:UIApplicationWillResignActiveNotification object:nil];
    // app进入前台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterPlayGround) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    UILabel * descLabel  = [[UILabel alloc] initWithFrame:CGRectMake(0, self.scanSweepAreaRect.origin.y + self.scanSweepAreaRect.size.height + 10, rect.size.width, 20)];
    descLabel.font = [UIFont systemFontOfSize:12];
    descLabel.textAlignment = NSTextAlignmentCenter;
    descLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    descLabel.text = @"将二维码/条码放入框内，即可自动扫描";
    [self addSubview:descLabel];
    
    UIButton * myCode = [[UIButton alloc] initWithFrame:CGRectMake(0, self.scanSweepAreaRect.origin.y + self.scanSweepAreaRect.size.height + 10 + 20 + 10, rect.size.width, 20)];
    myCode.titleLabel.font = [UIFont systemFontOfSize:15];
    [myCode setTitle:@"我的二维码" forState:UIControlStateNormal];
    [myCode setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [myCode addTarget:self action:@selector(myCodeClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:myCode];
    
    [self addSubview:self.scanLine];
}

//绘制扫描区域
- (void)drawScanRect {
    CGSize sizeSweepArea = self.scanSweepAreaRect.size;
    //扫码区域Y轴最小坐标
    CGFloat YMinRetangle = self.scanSweepAreaRect.origin.y;
    //扫码区域Y轴最大坐标
    CGFloat YMaxRetangle = YMinRetangle + sizeSweepArea.height;
    //扫码区域X轴最小坐标
    CGFloat XRetangleLeft = self.scanSweepAreaRect.origin.x;
    //扫码区域X轴最大坐标
    CGFloat XRetangleRight = self.frame.size.width - XRetangleLeft;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //非扫码区域半透明
    {
        //设置非识别区域颜色
        const CGFloat *components = CGColorGetComponents(self.notRecoginitonArea.CGColor);
        
        CGFloat red_notRecoginitonArea = components[0];
        CGFloat green_notRecoginitonArea = components[1];
        CGFloat blue_notRecoginitonArea = components[2];
        CGFloat alpa_notRecoginitonArea = components[3];
        
        CGContextSetRGBFillColor(context, red_notRecoginitonArea, green_notRecoginitonArea,
                                 blue_notRecoginitonArea, alpa_notRecoginitonArea);
        
        //填充矩形
        
        //扫码区域上面填充
        CGRect rect = CGRectMake(0, 0, self.frame.size.width, YMinRetangle);
        CGContextFillRect(context, rect);
        
        //扫码区域左边填充
        rect = CGRectMake(0, YMinRetangle, XRetangleLeft, sizeSweepArea.height);
        CGContextFillRect(context, rect);
        
        //扫码区域右边填充
        rect = CGRectMake(XRetangleRight, YMinRetangle, self.frame.size.width - XRetangleRight, sizeSweepArea.height);
        CGContextFillRect(context, rect);
        
        //扫码区域下面填充
        rect = CGRectMake(0, YMaxRetangle, self.frame.size.width, self.frame.size.height - YMaxRetangle);
        CGContextFillRect(context, rect);
        
        CGContextStrokePath(context);
    }
    
    if (self.isNeedShowRetangle) {
        //中间画矩形(正方形)
        CGContextSetStrokeColorWithColor(context, self.colorRetangleLine.CGColor);
        CGContextSetLineWidth(context, 1);
        
        CGContextAddRect(context, CGRectMake(XRetangleLeft, YMinRetangle, sizeSweepArea.width, sizeSweepArea.height));
        CGContextStrokePath(context);
    }
    
    //画矩形框4格外围相框角
    //相框角的宽度和高度
    int wAngle = self.photoframeAngleW;
    int hAngle = self.photoframeAngleH;
    //4个角的 线的宽度
    CGFloat linewidthAngle = self.photoframeLineW;// 经验参数：6和4
    
    //画扫码矩形以及周边半透明黑色坐标参数
    CGFloat diffAngle = 0.0f;
    //diffAngle = -linewidthAngle/3; //框外面4个角，与框有缝隙
    //diffAngle = linewidthAngle/3;  //框4个角 在线上加4个角效果
    //diffAngle = 0;//与矩形框重合
    diffAngle = -linewidthAngle/3;
    
    CGContextSetStrokeColorWithColor(context, self.colorAngle.CGColor);
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, linewidthAngle);
    
    //拐点位置
    CGFloat leftX = XRetangleLeft - diffAngle;
    CGFloat topY = YMinRetangle - diffAngle;
    CGFloat rightX = XRetangleRight + diffAngle;
    CGFloat bottomY = YMaxRetangle + diffAngle;
    
    //左上角水平线
    CGContextMoveToPoint(context, leftX - linewidthAngle / 2, topY);
    CGContextAddLineToPoint(context, leftX + wAngle, topY);
    //左上角垂直线
    CGContextMoveToPoint(context, leftX, topY - linewidthAngle / 2);
    CGContextAddLineToPoint(context, leftX, topY+hAngle);
    
    //左下角水平线
    CGContextMoveToPoint(context, leftX - linewidthAngle / 2, bottomY);
    CGContextAddLineToPoint(context, leftX + wAngle, bottomY);
    //左下角垂直线
    CGContextMoveToPoint(context, leftX, bottomY + linewidthAngle / 2);
    CGContextAddLineToPoint(context, leftX, bottomY - hAngle);
    
    //右上角水平线
    CGContextMoveToPoint(context, rightX + linewidthAngle / 2, topY);
    CGContextAddLineToPoint(context, rightX - wAngle, topY);
    //右上角垂直线
    CGContextMoveToPoint(context, rightX, topY - linewidthAngle / 2);
    CGContextAddLineToPoint(context, rightX, topY + hAngle);
    
    //右下角水平线
    CGContextMoveToPoint(context, rightX + linewidthAngle / 2, bottomY);
    CGContextAddLineToPoint(context, rightX - wAngle, bottomY);
    //右下角垂直线
    CGContextMoveToPoint(context, rightX, bottomY + linewidthAngle / 2);
    CGContextAddLineToPoint(context, rightX, bottomY - hAngle);
    
    CGContextStrokePath(context);
    
}

#pragma mark -- Events Handle

- (void)appWillEnterBackground {
    [self stopScanAnimation];
}

- (void)appWillEnterPlayGround {
    [self startScanAnimation];
}

- (void)myCodeClicked {
    if(self.myQRCodeBlock != nil){
        self.myQRCodeBlock();
    }
}

- (void)startScanAnimation {
    if(_isAnimating){
        return;
    }
    _isAnimating = YES;
    [self startScan];
}

- (void)startScan {
    
    if (_isAnimating == NO) {
        return;
    }
    
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:3.0 animations:^{
        weakSelf.scanLine.frame = CGRectMake(weakSelf.scanSweepAreaRect.origin.x, weakSelf.scanSweepAreaRect.origin.y + weakSelf.scanSweepAreaRect.size.height - 2, weakSelf.scanSweepAreaRect.size.width, 2);
    } completion:^(BOOL finished){
        if (finished == YES) {
            weakSelf.scanLine.frame = CGRectMake(weakSelf.scanSweepAreaRect.origin.x, weakSelf.scanSweepAreaRect.origin.y, weakSelf.scanSweepAreaRect.size.width, 2);
            [weakSelf performSelector:@selector(startScan) withObject:nil afterDelay:0.03];
        }
    }];
    
}

- (void)stopScanAnimation{
    self.scanLine.frame = CGRectMake(self.scanSweepAreaRect.origin.x, self.scanSweepAreaRect.origin.y, self.scanSweepAreaRect.size.width, 2);
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startScan) object:nil];
    _isAnimating = NO;
    [self.scanLine.layer removeAllAnimations];
}

- (void)handlingResultsOfScan {
    self.handlingView.center = CGPointMake(self.frame.size.width/2.0, self.scanSweepAreaRect.origin.y + self.scanSweepAreaRect.size.height/2);
    [self addSubview:self.handlingView];
    [self.activityView startAnimating];
}

- (void)finishedHandle {
    [self.activityView stopAnimating];
    [self.activityView removeFromSuperview];
    self.activityView = nil;
    [self.handlingView removeFromSuperview];
    self.handlingView = nil;
}

- (void)flashBtnClicked:(UIButton *)flashBtn {
    if (self.flashSwitchBlock != nil) {
        self.flashOpen = !self.flashOpen;
        self.flashSwitchBlock(self.flashOpen);
    }
}

- (void)showFlashSwitch:(BOOL)show {
    if (show == YES) {
        self.flashBtn.hidden = NO;
        [self addSubview:self.flashBtn];
    }else{
        self.flashBtn.hidden = YES;
        [self.flashBtn removeFromSuperview];
    }
}

#pragma mark -- Getter

- (UIImageView *)scanLine {
    if (_scanLine == nil) {
        _scanLine = [[UIImageView alloc] initWithFrame:CGRectMake(self.scanSweepAreaRect.origin.x, self.scanSweepAreaRect.origin.y, self.scanSweepAreaRect.size.width, 4)];
        _scanLine.image = self.animationImage;
        _scanLine.contentMode = UIViewContentModeScaleToFill;
    }
    return _scanLine;
}

// 加载中指示器
- (UIActivityIndicatorView *)activityView{
    if (_activityView == nil) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [_activityView startAnimating];
        _activityView.frame = CGRectMake(0, 0, self.scanSweepAreaRect.size.width, 40);
    }
    return _activityView;
}
//正在处理视图
- (UIView *)handlingView{
    if (_handlingView == nil) {
        _handlingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.scanSweepAreaRect.size.width, 40 + 40)];
        [_handlingView addSubview:self.activityView];
        UILabel * handleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, _handlingView.frame.size.width, 40)];
        handleLabel.font = [UIFont systemFontOfSize:12];
        handleLabel.textAlignment = NSTextAlignmentCenter;
        handleLabel.textColor = [UIColor whiteColor];
        handleLabel.text = @"正在处理...";
        [_handlingView addSubview:handleLabel];
    }
    return _handlingView;
}

- (UIButton *)flashBtn{
    if (_flashBtn == nil) {
        _flashBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_flashBtn setImage:[UIImage imageNamed:@"scanFlashlight"] forState:UIControlStateNormal];
        [_flashBtn addTarget:self action:@selector(flashBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _flashBtn.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height - 80);
    }
    return _flashBtn;
}

- (void)dealloc{
    [self stopScanAnimation];
    [self finishedHandle];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
