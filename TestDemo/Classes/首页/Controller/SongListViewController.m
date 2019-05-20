

//
//  SongListViewController.m
//  TestDemo
//
//  Created by taishu on 2019/5/20.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "SongListViewController.h"
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"
#import "SingleSongListViewController.h"
#import "SongListDetailViewController.h"

@interface SongListViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@end

@implementation SongListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, kNavigationBar, kScreenWidth, 50)];
    self.categoryView.delegate = self;
    [self.view addSubview:self.categoryView];
    
    self.categoryView.titles = @[@"推荐", @"精品", @"华语", @"摇滚", @"民谣", @"电子", @"轻音乐"];
    self.categoryView.titleColorGradientEnabled = YES;
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithDelegate:self];
    self.listContainerView.defaultSelectedIndex = 0;
    [self.view addSubview:self.listContainerView];
    self.listContainerView.frame = CGRectMake(0, kNavigationBar + 50, kScreenWidth, kScreenHeight - 50 - kNavigationBar);
    
    self.categoryView.contentScrollView = self.listContainerView.scrollView;
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    [self.listContainerView didClickSelectedItemAtIndex:index];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    [self.listContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    SingleSongListViewController *listVC = [[SingleSongListViewController alloc] init];
    listVC.category = self.categoryView.titles[index];
    listVC.itemClickBlock = ^(SongListModel * _Nonnull model) {
        SongListDetailViewController *vcc = [[SongListDetailViewController alloc] init];
        [self.navigationController pushViewController:vcc animated:YES];
    };
    return listVC;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.categoryView.titles.count;
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
