
//
//  AudioPlayerViewController.m
//  TestDemo
//
//  Created by taishu on 2019/5/9.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "AudioPlayerViewController.h"
#import "DFPlayer.h"

//有关距离、位置
#define CountWidth(w)  ((w)/750.0)*kScreenWidth
#define CountHeight(hh) ([UIScreen mainScreen].bounds.size.height==812.0?((hh)/1334.0)*667.0:((hh)/1334.0)*kScreenHeight)
#define topH kScreenHeight - self.tabBarController.tabBar.frame.size.height-CountHeight(200)


@interface AudioPlayerViewController ()<DFPlayerDelegate, DFPlayerDataSource>

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) SongListDetailModel *currentModel;
@property (nonatomic, strong) NSMutableArray *df_ModelArray;

@end

@implementation AudioPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentModel = self.songListArray[self.number];
    [self setNav];
    [self configureUI];
    [self initDFPlayer];
    kScreenWidth;
    kScreenHeight;
}

#pragma mark -- Nav
- (void)setNav {
    self.title = self.currentModel.name;
    
    NSDictionary * dict=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    self.navigationController.navigationBar.translucent = YES;
    UIGraphicsBeginImageContext(CGSizeMake(kScreenWidth, 64));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, kScreenWidth, 64));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = YES;
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    //    [leftbutton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark -- ConfigureUI
- (void)configureUI {
    [self.view addSubview:self.bgImageView];
}

#pragma mark - 初始化DFPlayer
- (void)initDFPlayer{
    [[DFPlayer shareInstance] df_initPlayerWithUserId:nil];
    [DFPlayer shareInstance].dataSource  = self;
    [DFPlayer shareInstance].delegate    = self;
    [DFPlayer shareInstance].category    = DFPlayerAudioSessionCategoryPlayback;
    [DFPlayer shareInstance].isObserveWWAN = YES;
    //    [DFPlayer shareInstance].isManualToPlay = NO;
    //    [DFPlayer shareInstance].playMode = DFPlayerModeOnlyOnce;//DFPLayer默认单曲循环。
    [[DFPlayer shareInstance] df_reloadData];//须在传入数据源后调用（类似UITableView的reloadData）
    CGRect buffRect = CGRectMake(CountWidth(104), topH+CountHeight(28), CountWidth(542), CountHeight(4));
    CGRect proRect  = CGRectMake(CountWidth(104), topH+CountHeight(10), CountWidth(542), CountHeight(40));
    CGRect currRect = CGRectMake(CountWidth(10), topH+CountHeight(10), CountWidth(90), CountHeight(40));
    CGRect totaRect = CGRectMake(kScreenWidth-CountWidth(100), topH+CountHeight(10), CountWidth(90), CountHeight(40));
    CGRect playRect = CGRectMake(CountWidth(320), topH+CountHeight(70), CountWidth(110), CountWidth(110));
    CGRect nextRext = CGRectMake(CountWidth(490), topH+CountHeight(84), CountWidth(80), CountWidth(80));
    CGRect lastRect = CGRectMake(CountWidth(180), topH+CountHeight(84), CountWidth(80), CountWidth(80));
    CGRect typeRect = CGRectMake(CountWidth(40), topH+CountHeight(100), CountWidth(63), CountHeight(45));
    
    DFPlayerControlManager *manager = [DFPlayerControlManager shareInstance];
    //缓冲条
    [manager df_bufferProgressViewWithFrame:buffRect trackTintColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5] progressTintColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] superView:self.bgImageView];
    //进度条
    [manager df_sliderWithFrame:proRect minimumTrackTintColor:[UIColor redColor] maximumTrackTintColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.0] trackHeight:CountHeight(4) thumbSize:(CGSizeMake(CountWidth(34), CountWidth(34))) superView:self.bgImageView];
    //当前时间
    UILabel *curLabel = [manager df_currentTimeLabelWithFrame:currRect superView:self.bgImageView];
    curLabel.textColor = [UIColor whiteColor];
    //总时间
    UILabel *totLabel = [manager df_totalTimeLabelWithFrame:totaRect superView:self.bgImageView];
    totLabel.textColor = [UIColor whiteColor];
    
    //播放模式按钮
    [manager df_typeControlBtnWithFrame:typeRect superView:self.bgImageView block:nil];
    //播放暂停按钮
    [manager df_playPauseBtnWithFrame:playRect superView:self.bgImageView block:nil];
    //下一首按钮
    [manager df_nextAudioBtnWithFrame:nextRext superView:self.bgImageView block:nil];
    //上一首按钮
    [manager df_lastAudioBtnWithFrame:lastRect superView:self.bgImageView block:nil];
    
    [[DFPlayer shareInstance] df_setPlayerWithPreviousAudioModel];
    
    DFPlayerModel *model = self.df_ModelArray[self.number];
    [[DFPlayer shareInstance] df_playerPlayWithAudioId:model.audioId];
}

#pragma mark -- Action
- (void)backBtnClick:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - DFPLayer dataSource
- (NSArray<DFPlayerModel *> *)df_playerModelArray {
    if (_df_ModelArray.count == 0) {
        _df_ModelArray = [NSMutableArray array];
    }else{
        [_df_ModelArray removeAllObjects];
    }
    for (int i = 0; i < self.songListArray.count; i++) {
        SongListDetailModel *yourModel = self.songListArray[i];
        DFPlayerModel *model = [[DFPlayerModel alloc] init];
        model.audioId = i;//****重要。AudioId从0开始，仅标识当前音频在数组中的位置。
        if ([yourModel.audioUrl hasPrefix:@"http"]) {//网络音频
            model.audioUrl  = [NSURL URLWithString:yourModel.audioUrl];
        }else{//本地音频
            NSString *path = [[NSBundle mainBundle] pathForResource:yourModel.audioUrl ofType:@""];
            if (path) {model.audioUrl = [NSURL fileURLWithPath:path];}
        }
        [_df_ModelArray addObject:model];
    }
    return self.df_ModelArray;
}

- (DFPlayerInfoModel *)df_playerAudioInfoModel:(DFPlayer *)player {
    SongListDetailModel *yourModel = self.songListArray[player.currentAudioModel.audioId];
    DFPlayerInfoModel *infoModel = [[DFPlayerInfoModel alloc] init];
    //音频名 歌手 专辑名
    infoModel.audioName = yourModel.name;
//    infoModel.audioSinger = yourModel.yourSinger;
//    infoModel.audioAlbum  = yourModel.yourAlbum;
    //歌词
//    NSString *lyricPath     = [[NSBundle mainBundle] pathForResource:yourModel.yourLyric ofType:nil];
//    infoModel.audioLyric    = [NSString stringWithContentsOfFile:lyricPath encoding:NSUTF8StringEncoding error:nil];
    //配图
    NSURL *imageUrl         = [NSURL URLWithString:yourModel.coverUrl];
    NSData *imageData       = [NSData dataWithContentsOfURL:imageUrl];
    infoModel.audioImage    = [UIImage imageWithData: imageData];
    return infoModel;
}

#pragma mark - DFPlayer delegate
//加入播放队列
- (void)df_playerAudioWillAddToPlayQueue:(DFPlayer *)player {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *audioImage = player.currentAudioInfoModel.audioImage;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *audioName = player.currentAudioInfoModel.audioName;
            self.navigationItem.title = [NSString stringWithFormat:@"%@",audioName];
            self.bgImageView.image = audioImage;
        });
    });
}
//缓冲进度代理
- (void)df_player:(DFPlayer *)player bufferProgress:(CGFloat)bufferProgress totalTime:(CGFloat)totalTime{
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:player.currentAudioModel.audioId
//                                                inSection:0];
//    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"正在缓冲%lf",bufferProgress];
//    cell.detailTextLabel.hidden = NO;
}
//播放进度代理
- (void)df_player:(DFPlayer *)player progress:(CGFloat)progress currentTime:(CGFloat)currentTime totalTime:(CGFloat)totalTime{
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:player.currentAudioModel.audioId
//                                                inSection:0];
//    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"当前进度%lf--当前时间%.0f--总时长%.0f",progress,currentTime,totalTime];
//    cell.detailTextLabel.hidden = NO;
}
//状态信息代理
- (void)df_player:(DFPlayer *)player didGetStatusCode:(DFPlayerStatusCode)statusCode{
//    if (statusCode == 0) {
//        [self showAlertWithTitle:@"没有网络连接" message:nil yesBlock:nil];
//    }else if(statusCode == 1){
//        [self showAlertWithTitle:@"继续播放将产生流量费用" message:nil noBlock:nil yseBlock:^{
//            [DFPlayer shareInstance].isObserveWWAN = NO;
//            [[DFPlayer shareInstance] df_playerPlayWithAudioId:player.currentAudioModel.audioId];
//        }];
//        return;
//    }else if(statusCode == 2){
//        [self showAlertWithTitle:@"请求超时" message:nil yesBlock:nil];
//    }else if(statusCode == 8){
//        [self tableViewReloadData];return;
//    }
}


#pragma mark -- Setter
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.frame = UIScreen.bounds;
        _bgImageView.image = [UIImage imageNamed:@"default_bg.jpg"];
        _bgImageView.userInteractionEnabled = YES;
        
        //这里使用iOS8以后才能使用的虚化方法
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        effectView.frame = _bgImageView.frame;
        [_bgImageView addSubview:effectView];
    }
    return _bgImageView;
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
