
//
//  HomeViewController.m
//  TestDemo
//
//  Created by taishu on 2019/5/9.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getData];
}

#pragma mark -- Request
- (void)getData {
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"netease/songList/highQuality";
        request.httpMethod = kXMHTTPMethodGET;
    } onSuccess:^(id  _Nullable responseObject) {
        NSLog(@"response:%@",responseObject);
    } onFailure:^(NSError * _Nullable error) {
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
