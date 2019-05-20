//
//  SongListCollectionViewCell.h
//  TestDemo
//
//  Created by taishu on 2019/5/20.
//  Copyright © 2019 taishu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SongListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SongListCollectionViewCell : UICollectionViewCell

- (void)setInfo:(SongListModel *)model;

@end

NS_ASSUME_NONNULL_END
