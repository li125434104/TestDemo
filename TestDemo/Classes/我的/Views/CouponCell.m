//
//  CouponCell.m
//  TestDemo
//
//  Created by LXJ on 09/07/2019.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "CouponCell.h"

@interface CouponCell ()
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *wholeLabel;
@property (weak, nonatomic) IBOutlet UILabel *deadlineLabel;

@end

@implementation CouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)getCouponClick:(UIButton *)sender {
    if (self.getCouponBlock) {
        self.getCouponBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
