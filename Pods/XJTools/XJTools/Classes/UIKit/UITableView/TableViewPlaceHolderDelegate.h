//
//  TableViewPlaceHolderDelegate.h
//  XJTools
//
//  Created by taishu on 2019/4/29.
//  Copyright © 2019 125434104@qq.com. All rights reserved.
//

@protocol TableViewPlaceHolderDelegate <NSObject>

@required
/*!
 @brief  make an empty overlay view when the tableView is empty
 @return an empty overlay view
 */
- (UIView *)makePlaceHolderView;

@optional
/*!
 @brief enable tableView scroll when place holder view is showing, it is disabled by default.
 @attention There is no need to return  NO, it will be NO by default
 @return enable tableView scroll, you can only return YES
 */
- (BOOL)enableScrollWhenPlaceHolderViewShowing;

@end

