//
//  MineHeaderCell.m
//  TestDemo
//
//  Created by taishu on 2019/5/16.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "MineHeaderCell.h"

#define kImageWidth  50

@interface MineHeaderCell()

@property (nonatomic, strong) UIImageView *avaterImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation MineHeaderCell

- (void)setupUI {
    [super setupUI];
    
    self.avaterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (self.height - kImageWidth)/ 2, kImageWidth, kImageWidth)];
    self.avaterImageView.image = [UIImage imageNamed:@"mine_default"];
    self.avaterImageView.clipsToBounds = YES;
    self.avaterImageView.layer.cornerRadius = kImageWidth / 2;
    [self.contentView addSubview:self.avaterImageView];
}

- (void)setupDataModel:(XJBaseCellModel *)model {
    
}

@end
