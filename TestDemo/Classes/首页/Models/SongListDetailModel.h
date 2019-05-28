//
//  SongListDetailModel.h
//  TestDemo
//
//  Created by taishu on 2019/5/21.
//  Copyright © 2019 taishu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SongListDetailModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *mvid;
@property (nonatomic, copy) NSString *audioUrl;
@property (nonatomic, copy) NSString *coverUrl;
@property (nonatomic, copy) NSString *artistName;

@end

NS_ASSUME_NONNULL_END
