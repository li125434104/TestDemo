//
//  CouponSuccessView.m
//  TestDemo
//
//  Created by LXJ on 09/07/2019.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "CouponSuccessView.h"

@interface CouponSuccessView ()

@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UIImageView *successImage;

@end

@implementation CouponSuccessView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureUI];
        
        [self performSelector:@selector(hide) withObject:self afterDelay:2.0];
    }
    return self;
}

- (void)configureUI {
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    [self addSubview:self.successImage];
    [self addSubview:self.stateLabel];
}

- (void)hide {
    [self removeFromSuperview];
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 50, 300, 100, 30)];
        _stateLabel.textColor = [UIColor redColor];
        _stateLabel.font = [UIFont systemFontOfSize:17.f];
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.text = @"领取成功";
    }
    return _stateLabel;
}

- (UIImageView *)successImage {
    if (!_successImage) {
        _successImage = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 25, 200, 50, 50)];
        _successImage.image = [UIImage imageNamed:@"mine_default"];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        animation.fromValue = [NSNumber numberWithFloat:0.1];
        animation.toValue = [NSNumber numberWithFloat:1.0];
        animation.duration = 1.0;
        animation.repeatCount = 1;
        animation.removedOnCompletion = YES;
        animation.fillMode = kCAFillModeForwards;
        [_successImage.layer addAnimation:animation forKey:@"zoom"];
    }
    return _successImage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
