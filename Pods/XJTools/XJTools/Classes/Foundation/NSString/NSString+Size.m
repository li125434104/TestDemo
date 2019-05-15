//
//  NSString+Size.m
//  XJTools_Example
//
//  Created by taishu on 2019/4/24.
//  Copyright © 2019 125434104@qq.com. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

/**
 * 计算文字高度，可以处理计算带行间距的
 */
- (CGFloat)getStringHeightWithWidth:(CGFloat)width
                               font:(UIFont*)font
                        lineSpacing:(CGFloat)lineSpacing {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle *paragraghStyle = [[NSMutableParagraphStyle alloc] init];
    paragraghStyle.lineSpacing = lineSpacing;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraghStyle range:NSMakeRange(0, self.length)];
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.length)];
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);
    CGRect rect = [attributedString boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil];
    return ceil(rect.size.height);
}

@end
