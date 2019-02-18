//
//  ChildTableViewController.m
//  MixedDemo
//
//  Created by simple on 2019/2/15.
//  Copyright © 2019年 MixedDemoTest. All rights reserved.
//

#import "ChildTableViewController.h"
#import "SynopsisTableViewCell.h"
#import "HttpTool.h"
#import "videoModel.h"
#import "VideoDetailViewController.h"
#import "MJRefresh.h"

@interface ChildTableViewController ()<UIScrollViewDelegate>
@property(nonatomic, assign) BOOL canScroll;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation ChildTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //页面滑动监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:kHomeGoTopNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:kHomeLeaveTopNotification object:nil];
    _dataArray = [NSMutableArray array];
    [self loadData];
}

-(void)loadData{
    [HttpTool GET:@"https://api.apiopen.top/todayVideo" parameters:nil success:^(id responseObject) {
        NSLog(@"%@",responseObject[@"message"]);
        for (NSDictionary *temp in responseObject[@"result"]) {
            if ([temp[@"type"]isEqualToString:@"followCard"]) {
                videoModel *item = [[videoModel alloc] videoInitWithItem:temp[@"data"][@"content"][@"data"]];
                [self.dataArray addObject:item];
            }
        }
        [self.tableView reloadData];
    }];
}

#pragma mark - notification

-(void)acceptMsg:(NSNotification *)notification {
    NSString *notificationName = notification.name;
    if ([notificationName isEqualToString:kHomeGoTopNotification]) {
        NSDictionary *userInfo = notification.userInfo;
        NSString *canScroll = userInfo[@"canScroll"];
        if ([canScroll isEqualToString:@"1"]) {
            self.canScroll = YES;
            self.tableView.showsVerticalScrollIndicator = YES;
        }
    }else if([notificationName isEqualToString:kHomeLeaveTopNotification]){
        self.tableView.contentOffset = CGPointZero;
        self.canScroll = NO;
        self.tableView.showsVerticalScrollIndicator = NO;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!self.canScroll) {
        [scrollView setContentOffset:CGPointZero];
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kHomeLeaveTopNotification object:nil userInfo:@{@"canScroll":@"1"}];
    }
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *videoCellID = @"videoCellID";
    SynopsisTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:videoCellID];
    if (!cell) {
        cell = [[SynopsisTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:videoCellID];
    }
    [cell setCellDataVideoModel:_dataArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    videoModel *model = _dataArray[indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:kChangeVideoNotification object:nil userInfo:@{@"playUrl":model.playUrl}];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
