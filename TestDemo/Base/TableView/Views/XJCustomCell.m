//
//  XJCustomCell.m
//  TestDemo
//
//  Created by taishu on 2019/5/16.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "XJCustomCell.h"

@implementation XJCustomCell

+ (XJBaseTableViewCell *)cellWithIdentifier:(NSString *)cellIdentifier tableView:(UITableView *)tableView {
    XJCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        Class cellClass = NSClassFromString(cellIdentifier);
        NSAssert([cellClass isSubclassOfClass:[XJCustomCell class]], @"此cellclass类必须存在,并且继承HSCustomTableViewCell");
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

@end
