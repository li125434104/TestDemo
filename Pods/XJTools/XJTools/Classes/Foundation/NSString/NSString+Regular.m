//
//  NSString+Regular.m
//  XJTools_Example
//
//  Created by taishu on 2019/4/24.
//  Copyright © 2019 125434104@qq.com. All rights reserved.
//

#import "NSString+Regular.h"

@implementation NSString (Regular)

- (BOOL)vertifyEmail {
    return [self vertifyStringWithExp: @"^(\\S+@\\S+\\.[a-zA-Z]{2,4})$"];
}

- (BOOL)vertifyChinese {
    return [self vertifyStringWithExp: @"^([\u4e00-\u9fa5]+)$"];
}

- (BOOL)vertifyPassword {
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,18}+$";
    return [self vertifyStringWithExp: passWordRegex];
}

- (BOOL)vertifyMobilePhone {
    return [self vertifyStringWithExp: @"^1\\d{10}$"];
    
//    /**
//     * 手机号码
//     * 移动：134(0-8)、135、136、137、138、139、147、150、151、152、157、158、159、172、178、182、183、184、187、188、198
//     *
//     * 联通：130、131、132、145、155、156、166、175、176、185、186
//     *
//     * 电信：133、149、153、173、177、180、181、189、199
//     *
//     虚拟运营商
//     电信：1700、1701、1702
//     移动：1703、1705、1706
//     联通：1704、1707、1708、1709、171
//     卫星通信：1349
//     */
//    /**
//     * 中国移动：China Mobile
//     * 134(0-8)、135、136、137、138、139、147、150、151、152、157、158、159、172、178、182、183、184、187、188、198
//
//     */
//    NSString * CM = @"^1(34[0-8]|3[5-9]|47|5[0127-9]|8[23478]|98)\\d{8}$";
//    /**
//     * 中国联通：China Unicom
//     * 130、131、132、145、155、156、166、175、176、185、186
//     */
//    NSString * CU = @"^1((3[0-2]|45|5[56]|66|7[56]|8[56]))\\d{8}$";
//    /**
//     * 中国电信：China Telecom
//     * 133、149、153、173、177、180、181、189、199
//     */
//    NSString * CT = @"^1((33|49|53|7[37]|8[019]|99))\\d{8}$";
//
//
//    if ([self vertifyStringWithExp:CM]) {
//        NSLog(@"手机运营商是====CM---中国移动");
//        return YES;
//    } else if ([self vertifyStringWithExp:CU]) {
//        NSLog(@"手机运营商是====CU---中国联通");
//        return YES;
//    } else if ([self vertifyStringWithExp:CT]){
//        NSLog(@"手机运营商是====CT---中国电信");
//        return YES;
//    } else {
//        return NO;
//    }
}

- (BOOL)vertifyTelephone {
    return [self vertifyStringWithExp: @"^(0\\d{2}-?\\d{8})|(\\d{8})|(0\\d{3}-?\\d{8})|(400-\\d{3}-\\d{4})$"];
}

- (BOOL)vertifyCarNumber {
    return [self vertifyStringWithExp: @"^([\u4e00-\u9fa5]{1}[a-zA-Z]{1}\\w{4}[a-zA-Z0-9[\u4e00-\u9fa5]]{1})$"];
}

- (BOOL)vertifyIdentifierNumber {
    return [self vertifyStringWithExp: @"(^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$)|(^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{2}[0-9Xx]$)"];
}

- (BOOL)vertifyIpAddress {
    return [self vertifyStringWithExp: @"^(([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(0\\.0\\.0\\.0)$"];
}

- (BOOL)vertifyHyperLink {
    return [self vertifyStringWithExp: @"^((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)$"];
}

- (BOOL)vertifyStringWithExp:(NSString *)exp {
    if (![exp isKindOfClass: [NSString class]]) {
        return NO;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", exp];
    return [predicate evaluateWithObject:self];
}
@end
