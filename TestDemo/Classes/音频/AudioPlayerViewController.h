//
//  AudioPlayerViewController.h
//  TestDemo
//
//  Created by taishu on 2019/5/9.
//  Copyright © 2019 taishu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SongListDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AudioPlayerViewController : UIViewController

@property (nonatomic, strong) NSMutableArray <SongListDetailModel *>*songListArray;
@property (nonatomic, assign) NSInteger number;   //歌的序号

@end

NS_ASSUME_NONNULL_END
