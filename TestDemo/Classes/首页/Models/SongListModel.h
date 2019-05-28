//
//  SongListModel.h
//  TestDemo
//
//  Created by taishu on 2019/5/20.
//  Copyright © 2019 taishu. All rights reserved.
//
//分类歌单
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SongListModel : NSObject
@property (nonatomic, copy) NSString *coverImgUrl;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *playCount;
@end

NS_ASSUME_NONNULL_END
