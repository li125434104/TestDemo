
//
//  MusicPlayerViewController.m
//  TestDemo
//
//  Created by taishu on 2019/5/22.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "MusicPlayerViewController.h"
#import "MusicSlider.h"
#import "Track.h"
#import "DOUAudioStreamer.h"
#import "UIView+Animations.h"

typedef NS_ENUM(NSInteger, MusicCycleType) {
    MusicCycleTypeLoopAll = 0,
    MusicCycleTypeLoopSingle = 1,
    MusicCycleTypeShuffle = 2,
};

static void *kStatusKVOKey = &kStatusKVOKey;
static void *kDurationKVOKey = &kDurationKVOKey;
static void *kBufferingRatioKVOKey = &kBufferingRatioKVOKey;

@interface MusicPlayerViewController ()

@property (weak, nonatomic) IBOutlet UIView *controlView;
//@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *beginTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *previousMusicButton;
@property (weak, nonatomic) IBOutlet UIButton *nextMusicButton;
@property (weak, nonatomic) IBOutlet UIButton *musicToggleButton;
@property (weak, nonatomic) IBOutlet UIButton *musicCycleButton;
@property (weak, nonatomic) IBOutlet MusicSlider *musicSlider;
@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) DOUAudioStreamer *streamer;
@property (nonatomic, assign) MusicCycleType musicCycleType;
@property (strong, nonatomic) SongListDetailModel *currentMusicModel;

@property (nonatomic) NSTimer *musicDurationTimer;
@property (nonatomic) BOOL musicIsPlaying;

@end

@implementation MusicPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.streamer = [[DOUAudioStreamer alloc] init];
    self.musicCycleType = 0;
    _musicDurationTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateSliderValue:) userInfo:nil repeats:YES];
    _currentIndex = 0;
    
    [self setNav];
    [self configureUI];
}

#pragma mark -- Nav
- (void)setNav {
    
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
    [self.view bringSubviewToFront:self.controlView];
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    [self setupMusicViewWithMusicEntity:self.songListArray[currentIndex]];
    [self createStreamer];
}

- (void)setupMusicViewWithMusicEntity:(SongListDetailModel *)model {
    self.currentMusicModel = model;
    self.title = model.name;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.coverUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.bgImageView.image = [self.bgImageView.image blurImage];
    }];
    [self.bgImageView startTransitionAnimation];
}

- (void)setMusicIsPlaying:(BOOL)musicIsPlaying {
    _musicIsPlaying = musicIsPlaying;
    if (_musicIsPlaying) {
        [self.musicToggleButton setImage:[UIImage imageNamed:@"big_pause_button"] forState:UIControlStateNormal];
    } else {
        [self.musicToggleButton setImage:[UIImage imageNamed:@"big_play_button"] forState:UIControlStateNormal];
    }
}

#pragma mark -- Action
- (void)backBtnClick:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)musicCycleBtnClick:(id)sender {
    switch (_musicCycleType) {
        case MusicCycleTypeLoopAll: {
            self.musicCycleType = MusicCycleTypeShuffle;
            NSLog(@"随机播放");
        }
            break;
        case MusicCycleTypeShuffle: {
            self.musicCycleType = MusicCycleTypeLoopSingle;
            NSLog(@"单曲循环");
        }
            break;
        case MusicCycleTypeLoopSingle: {
            self.musicCycleType = MusicCycleTypeLoopAll;
            NSLog(@"列表循环");
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)musicToggleBtnClick:(id)sender {
    if (self.musicIsPlaying) {
        [self.streamer pause];
    } else {
        [self.streamer play];
    }
}

- (IBAction)previousMusicBtnClick:(id)sender {
    if (self.songListArray.count == 1) {
        NSLog(@"已经是第一首歌曲");
        return;
    }
    if (_musicCycleType == MusicCycleTypeShuffle && self.songListArray.count > 2) {
        [self setupRandomMusicIfNeed];
    } else {
        NSInteger firstIndex = 0;
        if (self.currentIndex == firstIndex || [self currentIndexIsInvalid]) {
            self.currentIndex = self.songListArray.count - 1;
        } else {
            self.currentIndex--;
        }
    }
    
    [self setupStreamer];
}

- (IBAction)nextMusicBtnClick:(id)sender {
    if (self.songListArray.count == 1) {
        NSLog(@"已经是最后一首歌曲");
        return;
    }
    if (_musicCycleType == MusicCycleTypeShuffle && self.songListArray.count > 2) {
        [self setupRandomMusicIfNeed];
    } else {
        [self checkNextIndexValue];
    }
    
    [self setupStreamer];
}

- (IBAction)musicSliderChanged:(id)sender {
    if (self.streamer.status == DOUAudioStreamerFinished) {
        self.streamer = nil;
        [self createStreamer];
    }
    
    [self.streamer setCurrentTime:[self.streamer duration] * self.musicSlider.value];
    [self updateProgressLabelValue];
}

# pragma mark - Musics delegate

- (void)playMusicWithSpecialIndex:(NSInteger)index {
    self.currentIndex = index;
    [self createStreamer];
}

# pragma mark - Setup streamer

- (void)setupStreamer {
    [self createStreamer];
}

- (void)createStreamer {
    
    [self setupMusicViewWithMusicEntity:self.songListArray[self.currentIndex]];
//    [self loadPreviousAndNextMusicImage];
//    [MusicHandler configNowPlayingInfoCenter];
    
    Track *track = [[Track alloc] init];
    track.audioFileURL = [NSURL URLWithString:self.currentMusicModel.audioUrl];
    
    @try {
        [self removeStreamerObserver];
    } @catch(id anException){
    }
    
    _streamer = nil;
    _streamer = [DOUAudioStreamer streamerWithAudioFile:track];
    
    [self addStreamerObserver];
    [self.streamer play];
}



# pragma mark - Setup streamer

- (void)setupRandomMusicIfNeed {
//    [self loadOriginArrayIfNeeded];
//    int t = arc4random()%_originArray.count;
//    _randomArray[0] = _originArray[t];
//    _originArray[t] = _originArray.lastObject;
//    [_originArray removeLastObject];
//    self.currentIndex = [_randomArray[0] integerValue];
}

# pragma mark - Check Current Index

- (BOOL)currentIndexIsInvalid {
    return _currentIndex >= self.songListArray.count;
}

- (void)checkCurrentIndex {
    if ([self currentIndexIsInvalid]) {
        _currentIndex = 0;
    }
}

- (void)checkNextIndexValue {
    NSInteger lastIndex = self.songListArray.count - 1;
    if (_currentIndex == lastIndex || [self currentIndexIsInvalid]) {
        self.currentIndex = 0;
    } else {
        self.currentIndex++;
    }
}


#pragma mark -- Setter
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.frame = UIScreen.bounds;
        _bgImageView.image = [[UIImage imageNamed:@"default_bg.jpg"] blurImage];
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}

- (void)setMusicCycleType:(MusicCycleType)musicCycleType {
    _musicCycleType = musicCycleType;
    [self updateMusicCycleButton];
}

- (void)updateMusicCycleButton {
    switch (_musicCycleType) {
        case MusicCycleTypeLoopAll:
            [_musicCycleButton setImage:[UIImage imageNamed:@"loop_all_icon"] forState:UIControlStateNormal];
            break;
        case MusicCycleTypeShuffle:
            [_musicCycleButton setImage:[UIImage imageNamed:@"shuffle_icon"] forState:UIControlStateNormal];
            break;
        case MusicCycleTypeLoopSingle:
            [_musicCycleButton setImage:[UIImage imageNamed:@"loop_single_icon"] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}

- (void)removeStreamerObserver {
    [_streamer removeObserver:self forKeyPath:@"status"];
    [_streamer removeObserver:self forKeyPath:@"duration"];
    [_streamer removeObserver:self forKeyPath:@"bufferingRatio"];
}

- (void)addStreamerObserver {
    [_streamer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:kStatusKVOKey];
    [_streamer addObserver:self forKeyPath:@"duration" options:NSKeyValueObservingOptionNew context:kDurationKVOKey];
    [_streamer addObserver:self forKeyPath:@"bufferingRatio" options:NSKeyValueObservingOptionNew context:kBufferingRatioKVOKey];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == kStatusKVOKey) {
        [self performSelector:@selector(updateStatus)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    } else if (context == kDurationKVOKey) {
        [self performSelector:@selector(updateSliderValue:)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    } else if (context == kBufferingRatioKVOKey) {
        [self performSelector:@selector(updateBufferingStatus)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

# pragma mark - Handle Music Slider

- (void)updateSliderValue:(id)timer {
    if (!_streamer) {
        return;
    }
    if (_streamer.status == DOUAudioStreamerFinished) {
        [_streamer play];
    }
    
    if ([_streamer duration] == 0.0) {
        [_musicSlider setValue:0.0f animated:NO];
    } else {
        if (_streamer.currentTime >= _streamer.duration) {
            _streamer.currentTime -= _streamer.duration;
        }
        
        [_musicSlider setValue:[_streamer currentTime] / [_streamer duration] animated:YES];
        [self updateProgressLabelValue];
    }
    
}

- (void)updateProgressLabelValue {
    _beginTimeLabel.text = [self timeIntervalToMMSSFormat:_streamer.currentTime];
    _endTimeLabel.text = [self timeIntervalToMMSSFormat:_streamer.duration];
}

- (void)updateStatus {
    self.musicIsPlaying = NO;
    switch ([_streamer status]) {
        case DOUAudioStreamerPlaying:
            self.musicIsPlaying = YES;
            break;
            
        case DOUAudioStreamerPaused:
            break;
            
        case DOUAudioStreamerIdle:
            break;
            
        case DOUAudioStreamerFinished:
            if (_musicCycleType == MusicCycleTypeLoopSingle) {
                [_streamer play];
            } else {
                [self nextMusicBtnClick:nil];
            }
            break;
            
        case DOUAudioStreamerBuffering:
            break;
            
        case DOUAudioStreamerError:
            break;
    }
}

- (void)updateBufferingStatus {}

- (NSString *)timeIntervalToMMSSFormat:(NSTimeInterval)interval {
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    return [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
}

@end
