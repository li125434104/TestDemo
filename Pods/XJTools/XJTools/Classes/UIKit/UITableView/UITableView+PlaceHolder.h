//
//  UITableView+PlaceHolder.h
//  XJTools_Example
//
//  Created by taishu on 2019/4/29.
//  Copyright © 2019 125434104@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (PlaceHolder)

/**
 my_reloadData 替换 reloadData，自动添加或删除 place holder 视图
 */
- (void)my_reloadData;

@end

NS_ASSUME_NONNULL_END
