//
//  SingleSongListViewController.m
//  TestDemo
//
//  Created by taishu on 2019/5/20.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "SingleSongListViewController.h"
#import "SongListCollectionViewCell.h"

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface SingleSongListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation SingleSongListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    self.view.backgroundColor = randomColor;
    [self.view addSubview:self.collectionView];

    if ([self.category isEqualToString:@"精品"]) {
        [self getData];
    }
}

#pragma mark -- Request
- (void)getData {
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"netease/songList/highQuality";
        request.httpMethod = kXMHTTPMethodGET;
    } onSuccess:^(id  _Nullable responseObject) {
        NSLog(@"response:%@",responseObject);
        NSMutableArray *array = responseObject;
        for (int i = 0; i < array.count; i++) {
            SongListModel *model = [SongListModel mj_objectWithKeyValues:array[i]];
            [self.dataArray addObject:model];
            [self.collectionView reloadData];
        }
        
    } onFailure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}

- (void)listDidAppear {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)listDidDisappear {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

#pragma mark -- dataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SongListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SongListCollectionViewCell" forIndexPath:indexPath];
    SongListModel *model = self.dataArray[indexPath.row];
    [cell setInfo:model];
    return cell;
}

//item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellImageWidth = (kScreenWidth - 40 - 20) / 3;
    return CGSizeMake(cellImageWidth, cellImageWidth + 40);
}

//调节item边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 20, 0, 20);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.itemClickBlock) {
        self.itemClickBlock(self.dataArray[indexPath.row]);
    }
}

#pragma mark -- Setter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBar - 50) collectionViewLayout:fl];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:0.8 ];
        //布局
        fl.minimumInteritemSpacing = 0;
        fl.minimumLineSpacing = 10;
    
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:@"SongListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SongListCollectionViewCell"];
        
        
    }
    return _collectionView;
}


@end
