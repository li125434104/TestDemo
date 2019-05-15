//
//  NSURL+Param.m
//  XJTools_Example
//
//  Created by taishu on 2019/4/25.
//  Copyright © 2019 125434104@qq.com. All rights reserved.
//

#import "NSURL+Param.h"

@implementation NSURL (Param)

- (NSDictionary *)parameters {
    NSMutableDictionary *parametersDictionary = [NSMutableDictionary dictionary];
    NSArray *queryComponents = [self.query componentsSeparatedByString:@"&"];
    for (NSString *queryComponent in queryComponents) {
        NSString *key = [queryComponent componentsSeparatedByString:@"="].firstObject;
        NSString *value = [queryComponent substringFromIndex:(key.length + 1)];
        [parametersDictionary setObject:value forKey:key];
    }
    return parametersDictionary;
}

- (NSString *)valueForParameter:(NSString *)parameterKey {
    return [[self parameters] objectForKey:parameterKey];
}

@end
