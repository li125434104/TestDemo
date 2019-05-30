
//
//  VideoPlayerViewController.m
//  TestDemo
//
//  Created by taishu on 2019/5/23.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "VideoPlayerViewController.h"
#import <ZFPlayer/ZFPlayer.h>
#import <ZFPlayer/ZFAVPlayerManager.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import "ZFUtilities.h"
#import "UIImageView+ZFCache.h"
#import "DouyinViewController.h"

static NSString *kVideoCover = @"https://upload-images.jianshu.io/upload_images/635942-14593722fe3f0695.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";

@interface VideoPlayerViewController ()

@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) UIImageView *containerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;

@end

@implementation VideoPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"mvId:%@",self.videoId);
    [self setNav];
     
    [self setVideoPlayer];
    
    [self douyin];
    
    
}
    
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.player.viewControllerDisappear = NO;
}
    
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.player.viewControllerDisappear = YES;
}

- (void)setNav {
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    //    [leftbutton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)douyin {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"抖音" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 400, 80, 50);
    [button addTarget:self action:@selector(gotoDouyin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

#pragma mark -- Action
- (void)backBtnClick:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)gotoDouyin {
//    NSArray *array = @[@"https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4",
//                       @"https://www.apple.com/105/media/cn/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/bruce/mac-bruce-tpl-cn-2018_1280x720h.mp4",
//                       @"https://www.apple.com/105/media/us/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/peter/mac-peter-tpl-cc-us-2018_1280x720h.mp4",
//                       @"https://www.apple.com/105/media/us/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/grimes/mac-grimes-tpl-cc-us-2018_1280x720h.mp4",
//                       @"http://flv3.bn.netease.com/tvmrepo/2018/6/H/9/EDJTRBEH9/SD/EDJTRBEH9-mobile.mp4",
//                       @"http://flv3.bn.netease.com/tvmrepo/2018/6/9/R/EDJTRAD9R/SD/EDJTRAD9R-mobile.mp4",
//                       @"http://www.flashls.org/playlists/test_001/stream_1000k_48k_640x360.m3u8",
//                       @"http://tb-video.bdstatic.com/tieba-video/7_517c8948b166655ad5cfb563cc7fbd8e.mp4",
//                       @"http://tb-video.bdstatic.com/tieba-smallvideo/68_20df3a646ab5357464cd819ea987763a.mp4",
//                       @"http://tb-video.bdstatic.com/tieba-smallvideo/118_570ed13707b2ccee1057099185b115bf.mp4",
//                       @"http://tb-video.bdstatic.com/tieba-smallvideo/15_ad895ac5fb21e5e7655556abee3775f8.mp4",
//                       @"http://tb-video.bdstatic.com/tieba-smallvideo/12_cc75b3fb04b8a23546d62e3f56619e85.mp4",
//                       @"http://tb-video.bdstatic.com/tieba-smallvideo/5_6d3243c354755b781f6cc80f60756ee5.mp4",
//                       @"http://tb-video.bdstatic.com/tieba-movideo/11233547_ac127ce9e993877dce0eebceaa04d6c2_593d93a619b0.mp4"];

    NSArray *array = @[@"https://aweme.snssdk.com/aweme/v1/play/?video_id=v0200ff70000bck86n4mavf9lsqsr7m0&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0",
                       @"https://aweme.snssdk.com/aweme/v1/play/?video_id=v0200fbd0000bbp4qkelg9jt2h2a2qsg&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0",
                       @"https://aweme.snssdk.com/aweme/v1/play/?video_id=v0200ff00000bcv0okld2r6fb5itjj10&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0",
                       @"https://aweme.snssdk.com/aweme/v1/play/?video_id=v0200f180000bcstfbv3cp53oaad7s00&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0",
                       @"https://aweme.snssdk.com/aweme/v1/play/?video_id=v0200ff00000bccf84viv420lssd9is0&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0",
                       @"https://aweme.snssdk.com/aweme/v1/play/?video_id=v0200ff50000bcki6irc86dlg7jsq6ug&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0",
                       @"https://aweme.snssdk.com/aweme/v1/play/?video_id=v0200ff00000bchogtf2gddrulo6f2rg&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0",
                       @"https://aweme.snssdk.com/aweme/v1/play/?video_id=v0200ff50000bcshae7a1hap4ad0hdh0&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0",
                       @"https://aweme.snssdk.com/aweme/v1/play/?video_id=v0200ff50000bccs048ckqbl35li5cf0&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0",
                       @"https://aweme.snssdk.com/aweme/v1/play/?video_id=v0200f660000bc145moa2pejvu6q1n30&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0",
                       @"https://aweme.snssdk.com/aweme/v1/play/?video_id=e10f7688daae4c07ad89441e60965030&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0",
                       @"https://aweme.snssdk.com/aweme/v1/play/?video_id=v0200f180000bcv3d0o9lr7ddj9npmcg&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0"
                       ];
    
    DouyinViewController *vc = [[DouyinViewController alloc] init];
    vc.dataArray = array;
    [self.navigationController pushViewController:vc animated:YES];
}
     
- (void)setVideoPlayer {
    [self.view addSubview:self.containerView];
    CGFloat x = 0;
    CGFloat y = kNavigationBar;
    CGFloat w = CGRectGetWidth(self.view.frame);
    CGFloat h = w*9/16;
    self.containerView.frame = CGRectMake(x, y, w, h);
    
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    //    KSMediaPlayerManager *playerManager = [[KSMediaPlayerManager alloc] init];
    //    ZFIJKPlayerManager *playerManager = [[ZFIJKPlayerManager alloc] init];
     
    /// 播放器相关
    self.player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:self.containerView];
    self.player.controlView = self.controlView;
    /// 设置退到后台继续播放
    self.player.pauseWhenAppResignActive = NO;
     
    @weakify(self)
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        @strongify(self)
        [self setNeedsStatusBarAppearanceUpdate];
    };
     
    /// 播放完成
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @strongify(self)
        [self.player.currentPlayerManager replay];
        [self.player playTheNext];
        if (!self.player.isLastAssetURL) {
            NSString *title = [NSString stringWithFormat:@"视频标题%zd",self.player.currentPlayIndex];
            [self.controlView showTitle:title coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeLandscape];
        } else {
            [self.player stop];
        }
    };
     
    self.player.customAudioSession = YES;
    self.player.playerReadyToPlay = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, NSURL * _Nonnull assetURL) {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionAllowBluetooth error:nil];
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
    };
    
    self.player.assetURL = [NSURL URLWithString:@"https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4"];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.player.isFullScreen) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    /// 如果只是支持iOS9+ 那直接return NO即可，这里为了适配iOS8
    return self.player.isStatusBarHidden;
}
    
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}
    
- (BOOL)shouldAutorotate {
    return self.player.shouldAutorotate;
}
    
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.player.isFullScreen) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}
    
- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
        _controlView.fastViewAnimated = YES;
        _controlView.autoHiddenTimeInterval = 5;
        _controlView.autoFadeTimeInterval = 0.5;
        _controlView.prepareShowLoading = YES;
    }
    return _controlView;
}
    
- (UIImageView *)containerView {
    if (!_containerView) {
        _containerView = [UIImageView new];
        [_containerView setImageWithURLString:kVideoCover placeholder:[ZFUtilities imageWithColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] size:CGSizeMake(1, 1)]];
    }
    return _containerView;
}
    
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
