//
//  SongListDetailViewController.m
//  TestDemo
//
//  Created by taishu on 2019/5/20.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "SongListDetailViewController.h"
#import "CHGAdapter.h"
#import "SongListDetailModel.h"
#import "SongListDetailAdapter.h"
#import "MusicPlayerViewController.h"
#import "VideoPlayerViewController.h"

@interface SongListDetailViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SongListDetailAdapter *adapter;
@property (nonatomic, strong) CHGTableViewAdapterData *adapterData;

@end


@implementation SongListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.dataArray = [NSMutableArray array];
    [self configureUI];
    
    if (self.songSheetID.length) {
        [self getData];
    }
}

#pragma mark -- configureUI
- (void)configureUI {
    __weak __typeof(self)weakSelf = self;

    [self.view addSubview:self.tableView];
    [self.tableView setEmptyDataShowWithTitle:@"暂无数据" image:@"money_bg"];
    
    self.tableView.tableViewDidSelectRowBlock = ^(UITableView *tableView, NSIndexPath *indexPath, id itemData) {
        NSLog(@"当前点击section:%li row:%li",indexPath.section,indexPath.row);
     
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MusicPlayerViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"MusicPlayerViewController"];
        vc.songListArray = [NSMutableArray arrayWithArray:weakSelf.adapterData.cellDatas];
        vc.currentIndex = indexPath.section;
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [weakSelf presentViewController:nav animated:YES completion:nil];
    };
    
    self.tableView.eventTransmissionBlock = ^id(id target, id params, NSInteger tag, CHGCallBack callBack) {
        
        SongListDetailModel *model = params;
        VideoPlayerViewController *vc = [[VideoPlayerViewController alloc] init];
        vc.videoId = model.mvid;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [weakSelf presentViewController:nav animated:YES completion:nil];
        return nil;
    };
    
}

#pragma mark -- Request
- (void)getData {
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"netease/songList";
        request.httpMethod = kXMHTTPMethodGET;
        request.parameters = @{@"id":self.songSheetID,
                               @"pageSize":@"3"};
    } onSuccess:^(id  _Nullable responseObject) {
        NSArray *array = [responseObject objectForKey:@"tracks"];
        NSMutableArray *tmpArray = [NSMutableArray array];

        for (int i = 0; i < array.count; i++) {
            SongListDetailModel *model = [SongListDetailModel mj_objectWithKeyValues:array[i]];
            model.coverUrl = [[array[i] objectForKey:@"album"] objectForKey:@"blurPicUrl"];
            model.audioUrl = [NSString stringWithFormat:@"https://v1.itooi.cn/netease/url?id=%@&quality=flac",model.ID];
            model.artistName = [[[array[i] objectForKey:@"artists"] firstObject] objectForKey:@"name"];
            [tmpArray addObject:model];
        }
        self.adapterData.cellDatas = tmpArray;
        self.adapter.adapterData = self.adapterData;
        self.tableView.tableViewAdapter = self.adapter;
        [self.tableView reloadData];

    } onFailure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark -- Setter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}

- (SongListDetailAdapter *)adapter{
    if (!_adapter) {
        _adapter = [SongListDetailAdapter new];
        _adapter.headerHeight = 0.01;
        _adapter.footerHeight = 0.01;
    }
    return _adapter;
}

- (CHGTableViewAdapterData *)adapterData {
    if (!_adapterData) {
        _adapterData = [CHGTableViewAdapterData new];
    }
    return _adapterData;
}
@end
