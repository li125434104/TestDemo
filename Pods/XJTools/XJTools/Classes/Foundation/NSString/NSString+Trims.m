//
//  NSString+Trims.m
//  XJTools_Example
//
//  Created by taishu on 2019/4/24.
//  Copyright © 2019 125434104@qq.com. All rights reserved.
//

#import "NSString+Trims.h"

@implementation NSString (Trims)

- (NSString *)stringByStrippingHTML {
    return [self stringByReplacingOccurrencesOfString:@"<[^>]+>" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
}

- (NSString *)stringByRemovingScriptsAndStrippingHTML {
    NSMutableString *mString = [self mutableCopy];
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<script[^>]*>[\\w\\W]*</script>" options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:mString options:NSMatchingReportProgress range:NSMakeRange(0, [mString length])];
    for (NSTextCheckingResult *match in [matches reverseObjectEnumerator]) {
        [mString replaceCharactersInRange:match.range withString:@""];
    }
    return [mString stringByStrippingHTML];
}

- (NSString *)stirngByTrimReturnKey {
    NSString *string;
    string = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    string = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [self stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [self stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return string;
}

- (NSString *)trimmingWhitespaceAndNewlines {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
