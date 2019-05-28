//
//  SongListDetailModel.m
//  TestDemo
//
//  Created by taishu on 2019/5/21.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "SongListDetailModel.h"

@implementation SongListDetailModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}
@end
