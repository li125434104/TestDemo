//
//  SongListDetailAdapter.m
//  TestDemo
//
//  Created by taishu on 2019/5/21.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "SongListDetailAdapter.h"

@implementation SongListDetailAdapter

- (NSString *)obtainCellNameWithCellData:(id)data tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"SongListDetailCell";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

@end
