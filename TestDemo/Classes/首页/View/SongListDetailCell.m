//
//  SongListDetailCell.m
//  TestDemo
//
//  Created by taishu on 2019/5/21.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "SongListDetailCell.h"
#import "SongListDetailModel.h"

@interface SongListDetailCell ()

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *mvButton;

@end

@implementation SongListDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)cellForRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView withData:(id)data {
    [super cellForRowAtIndexPath:indexPath tableView:tableView withData:data];
    SongListDetailModel *model = data;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",indexPath.section + 1];
    self.nameLabel.text = model.name;
    self.mvButton.hidden = [model.mvid isEqualToString:@"0"] ? YES : NO;
}

@end
