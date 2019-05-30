//
//  DouyinCell.h
//  TestDemo
//
//  Created by taishu on 2019/5/28.
//  Copyright © 2019 taishu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVPlayerView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^OnPlayerReady)(void);

@interface DouyinCell : UITableViewCell

@property (nonatomic, strong) NSString *videoUrl;
@property (nonatomic, strong) AVPlayerView *playerView;
@property (nonatomic, assign) BOOL isPlayerReady;
@property (nonatomic, strong) OnPlayerReady onPlayerReady;

- (void)play;
- (void)pause;
- (void)replay;
- (void)startDownloadBackgroundTask;

@end

NS_ASSUME_NONNULL_END
