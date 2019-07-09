//
//  CouponCell.h
//  TestDemo
//
//  Created by LXJ on 09/07/2019.
//  Copyright © 2019 taishu. All rights reserved.
//
//优惠劵cell
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CouponCell : UITableViewCell

@property (nonatomic, copy) void(^getCouponBlock)(void);

@end

NS_ASSUME_NONNULL_END
