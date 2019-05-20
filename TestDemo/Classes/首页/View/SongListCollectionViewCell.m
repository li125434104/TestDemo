//
//  SongListCollectionViewCell.m
//  TestDemo
//
//  Created by taishu on 2019/5/20.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "SongListCollectionViewCell.h"

@interface SongListCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end

@implementation SongListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setInfo:(SongListModel *)model {
    self.nameLabel.text = model.name;
    self.numberLabel.text = model.playCount;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.coverImgUrl] placeholderImage:[UIImage imageNamed:@"money_bg"]];
}

@end
