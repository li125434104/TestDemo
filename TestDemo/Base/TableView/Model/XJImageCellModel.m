//
//  XJImageCellModel.m
//  TestDemo
//
//  Created by taishu on 2019/5/16.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "XJImageCellModel.h"
#import "XJSetTable.h"

@implementation XJImageCellModel

- (instancetype)initWithTitle:(NSString *)title placeholderImage:(UIImage *)placeholderImage imageUrl:(NSString *)imageUrl actionBlock:(ClickActionBlock)actionblock imageBlock:(ClickImageBlock)imageBlock;
{
    if(self = [super initWithTitle:title actionBlock:actionblock]){
        self.placeHoderImage = placeholderImage;
        self.imageUrl = imageUrl;
        self.imageBlock = imageBlock;
        self.imageSize = CGSizeMake(HS_KImageWidth, HS_KImageHeight);
        self.cornerRadius = .0f;
        self.cellHeight  = HS_KImageCellHeight;
    }
    return self;
}

- (NSString *)cellClass
{
    return HSImageCellModelCellClass;
}

@end
