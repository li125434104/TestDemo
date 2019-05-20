
//
//  HomeViewController.m
//  TestDemo
//
//  Created by taishu on 2019/5/9.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "HomeViewController.h"
#import "SongListViewController.h"
#define TICK   NSDate *startTime = [NSDate date];
#define TOCK   NSLog(@"Time: %f", -[startTime timeIntervalSinceNow]);


@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"歌单" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 100, 100, 50);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(songListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
//    [self getData];
}

- (void)songListBtnClick:(UIButton *)button {
    SongListViewController *vc = [[SongListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- Request
- (void)getData {
    TICK
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"netease/songList?id=560609382";
        request.httpMethod = kXMHTTPMethodGET;
    } onSuccess:^(id  _Nullable responseObject) {
        NSLog(@"response:%@",responseObject);
        TOCK
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
