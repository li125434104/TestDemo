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

@interface DouyinCell : UITableViewCell

@property (nonatomic, strong) AVPlayerView *playerView;
- (void)play;
- (void)pause;
- (void)replay;
- (void)startDownloadBackgroundTask;
- (void)startDownloadHighPriorityTask;

@end

NS_ASSUME_NONNULL_END
