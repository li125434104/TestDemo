//
//  XJBaseCellModel.m
//  TestDemo
//
//  Created by taishu on 2019/5/16.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "XJBaseCellModel.h"

@interface XJBaseCellModel()
{
    NSString *privateCellModelIdentifier;  //私有变量
}
@end

@implementation XJBaseCellModel

- (instancetype)init {
    if (self = [super init]) {
        //获取当前时间
        CFAbsoluteTime now = CFAbsoluteTimeGetCurrent();
        //获取当前线程id
        NSString *threadNumber = [[[NSString stringWithFormat:@"%@",[NSThread currentThread]] componentsSeparatedByString:@"number = "].lastObject componentsSeparatedByString:@","].firstObject;
        privateCellModelIdentifier = [NSString stringWithFormat:@"%lf%@",now,threadNumber];
    }
    return self;
}

- (NSString *)identifier {
    return privateCellModelIdentifier;
}

+ (BOOL)accessInstanceVariablesDirectly {
    return NO;
}

@end
