//
//  MusicPlayerViewController.h
//  TestDemo
//
//  Created by taishu on 2019/5/22.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "BaseViewController.h"
#import "SongListDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MusicPlayerViewController : BaseViewController

@property (nonatomic, strong) NSMutableArray <SongListDetailModel *> *songListArray;
@property (nonatomic) NSInteger currentIndex;

@end

NS_ASSUME_NONNULL_END
