

//
//  DouyinCell.m
//  TestDemo
//
//  Created by taishu on 2019/5/28.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "DouyinCell.h"
#import "CommentView.h"
#import "Masonry.h"

@interface DouyinCell ()<AVPlayerUpdateDelegate, SendTextDelegate, HoverTextViewDelegate>

@property (nonatomic, strong) UIView *container;
@property (nonatomic ,strong) CAGradientLayer *gradientLayer;

@property (nonatomic ,strong) UIImageView *pauseIcon;
@property (nonatomic, strong) UITapGestureRecognizer *singleTapGesture;

@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) CommentView *commentView;

@end

@implementation DouyinCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    //init player view;
    _playerView = [AVPlayerView new];
    _playerView.delegate = self;
    [self.contentView addSubview:_playerView];
    
    //init hover on player view container
    _container = [UIView new];
    [self.contentView addSubview:_container];
    
    _gradientLayer = [CAGradientLayer layer];
    _gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor, (__bridge id)COLOR_RGBA(0, 0, 0, 0.2).CGColor, (__bridge id)COLOR_RGBA(0, 0, 0, 0.4).CGColor];
    _gradientLayer.locations = @[@0.3, @0.6, @1.0];
    _gradientLayer.startPoint = CGPointMake(0.0f, 0.0f);
    _gradientLayer.endPoint = CGPointMake(0.0f, 1.0f);
    [_container.layer addSublayer:_gradientLayer];
    
    _singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [_container addGestureRecognizer:_singleTapGesture];
    
    _pauseIcon = [[UIImageView alloc] init];
    _pauseIcon.image = [UIImage imageNamed:@"icon_play_pause"];
    _pauseIcon.contentMode = UIViewContentModeCenter;
    _pauseIcon.layer.zPosition = 3;
    _pauseIcon.hidden = YES;
    _pauseIcon.frame = CGRectMake(kScreenWidth / 2 - 50, kScreenHeight / 2 - 50, 100, 100);
    _pauseIcon.width = _pauseIcon.height = 100;
    [_container addSubview:_pauseIcon];
    
    [self.container addSubview:self.commentView];
    
    [_playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [_container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [_pauseIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.mas_equalTo(100);
    }];
}


-(void)prepareForReuse {
    [super prepareForReuse];
    
    _isPlayerReady = NO;
    [self.playerView cancelLoading];
    [self.pauseIcon setHidden:YES];
    
    [self.commentView.textView setText:@""];
//    [_avatar setImage:[UIImage imageNamed:@"img_find_default"]];
//    
//    [_musicAlum resetView];
//    [_favorite resetView];
//    [_focus resetView];
}

#pragma mark -- Control

- (void)play {
    [_playerView play];
    [_pauseIcon setHidden:YES];
}

- (void)pause {
    [_playerView pause];
    [_pauseIcon setHidden:NO];
}

- (void)replay {
    [_playerView replay];
    [_pauseIcon setHidden:YES];
}

- (void)startDownloadBackgroundTask {
    NSString *playUrl = self.videoUrl;
    [_playerView setPlayerWithUrl:playUrl];
}

#pragma mark -- Action
- (void)handleGesture:(UITapGestureRecognizer *)sender {
//    switch (sender.view.tag) {
//        case kAwemeListLikeCommentTag: {
//            CommentsPopView *popView = [[CommentsPopView alloc] initWithAwemeId:_aweme.aweme_id];
//            [popView show];
//            break;
//        }
//        case kAwemeListLikeShareTag: {
//            SharePopView *popView = [[SharePopView alloc] init];
//            [popView show];
//            break;
//        }
//        default: {
            //获取点击坐标，用于设置爱心显示位置
            CGPoint point = [sender locationInView:_container];
            //获取当前时间
            NSTimeInterval time = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
            //判断当前点击时间与上次点击时间的时间间隔
//            if(time - _lastTapTime > 0.25f) {
                //推迟0.25秒执行单击方法
                [self performSelector:@selector(singleTapAction) withObject:nil afterDelay:0.25f];
//            }else {
                //取消执行单击方法
//                [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(singleTapAction) object: nil];
                //执行连击显示爱心的方法
//                [self showLikeViewAnim:point oldPoint:_lastTapPoint];
//            }
//            //更新上一次点击位置
//            _lastTapPoint = point;
//            //更新上一次点击时间
//            _lastTapTime =  time;
//            break;
//        }
//    }
    
}


- (void)singleTapAction {
    if([self.commentView isFirstResponder]) {
        [self.commentView resignFirstResponder];
    }else {
        [self showPauseViewAnim:[_playerView rate]];
        [_playerView updatePlayerState];
    }
}

//暂停播放动画
- (void)showPauseViewAnim:(CGFloat)rate {
    if(rate == 0) {
        [UIView animateWithDuration:0.25f
                         animations:^{
                             self.pauseIcon.alpha = 0.0f;
                         } completion:^(BOOL finished) {
                             [self.pauseIcon setHidden:YES];
                         }];
    }else {
        [_pauseIcon setHidden:NO];
        _pauseIcon.transform = CGAffineTransformMakeScale(1.8f, 1.8f);
        _pauseIcon.alpha = 1.0f;
        [UIView animateWithDuration:0.25f delay:0
                            options:UIViewAnimationOptionCurveEaseIn animations:^{
                                self.pauseIcon.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                            } completion:^(BOOL finished) {
                            }];
    }
}

#pragma mark --
#pragma mark -- SendTextDelegate

- (void)onSendText:(NSString *)text {
    NSLog(@"评论成功");
}

#pragma mark -- HoverTextViewDelegate

- (void)hoverTextViewStateChange:(BOOL)isHover {
//    _container.alpha = isHover ? 0.01f : 1.0f;
}


#pragma mark --  AVPlayerUpdateDelegate
-(void)onProgressUpdate:(CGFloat)current total:(CGFloat)total {
    //播放进度更新xxx
}

-(void)onPlayItemStatusUpdate:(AVPlayerItemStatus)status {
    switch (status) {
        case AVPlayerItemStatusUnknown:
//            [self startLoadingPlayItemAnim:YES];
            NSLog(@"AVPlayerItemStatusUnknown");
            break;
        case AVPlayerItemStatusReadyToPlay:
//            [self startLoadingPlayItemAnim:NO];
            
            _isPlayerReady = YES;
//            [_musicAlum startAnimation:_aweme.rate];
            
            if(_onPlayerReady) {
                _onPlayerReady();
            }
            NSLog(@"AVPlayerItemStatusReadyToPlay");

            break;
        case AVPlayerItemStatusFailed:
//            [self startLoadingPlayItemAnim:NO];
//            [UIWindow showTips:@"加载失败"];
            NSLog(@"AVPlayerItemStatusFailed");

            break;
        default:
            break;
    }
}


#pragma mark -- Setter
- (CommentView *)commentView {
    if (!_commentView) {
        //init _commentView
        _commentView = [CommentView new];
        _commentView.delegate = self;
        _commentView.hoverDelegate = self;
    }
    return _commentView;
}


//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
