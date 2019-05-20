//
//  SingleSongListViewController.h
//  TestDemo
//
//  Created by taishu on 2019/5/20.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "BaseViewController.h"
#import "JXCategoryListContainerView.h"
#import "SongListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SingleSongListViewController : BaseViewController<JXCategoryListContentViewDelegate>

@property (nonatomic, strong) NSString *category;
@property (nonatomic, copy) void(^itemClickBlock)(SongListModel *model);
@end

NS_ASSUME_NONNULL_END
