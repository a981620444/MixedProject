//
//  NewsViewController.m
//  MixedDemo
//
//  Created by simple on 2019/1/20.
//  Copyright © 2019年 MixedDemoTest. All rights reserved.
//

#import "NewsViewController.h"
#import "topSearchView.h"
#import "newsTableViewCell.h"
#import "newsModel.h"
#import "MJRefresh.h"
#import "DetailViewController.h"
#import "WCDB.h"

@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIView *line;
@property (nonatomic,strong)UITableView *newsTableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)WCTDatabase *dataBase;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [NSMutableArray array];
    [self.view addSubview:self.line];
    [self.view addSubview:self.newsTableView];
    
    [self initDataBase];
    [self getgetReachabilityStatus];
    self.newsTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
}
//网络状态
-(void)getgetReachabilityStatus{
    [HttpTool getReachabilityStatus:^(NSString *state) {
        NSString *wifi = @"WiFi网络";
        NSString *fourG = @"蜂窝数据网";
        if (state == wifi || fourG) {
            [self loadData];
        }else{
            [self getCacheData];
        };
    }];
}

-(void)loadData{
    __weak typeof(self) weakSelf = self;
    [HttpTool GET:hostUrl parameters:nil success:^(id responseObject) {
        NSDictionary *dataDic = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
        for (NSDictionary *itemDic in dataDic[weakSelf.newsCategory]) {
            newsModel *itemModel = [[newsModel alloc]initWithItem:itemDic];
            [weakSelf.dataArray addObject:itemModel];
        }
        [weakSelf.newsTableView reloadData];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (weakSelf.dataArray.count) {
                [weakSelf.dataBase deleteAllObjectsFromTable:newsTableName];
                [weakSelf.dataBase insertOrReplaceObjects:weakSelf.dataArray into:newsTableName];
            };
            
        });
    }];
    [self.newsTableView.mj_header endRefreshing];
}


-(void)initDataBase{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *fileName = [documentPath stringByAppendingPathComponent:@"NewsDataBase"];
    _dataBase = [[WCTDatabase alloc]initWithPath:fileName];
    BOOL result = [_dataBase createTableAndIndexesOfName:newsTableName withClass:newsModel.class];
    if (result) {
        //NSLog(@"创建表成功");
    }else{
        //NSLog(@"创建表失败");
    }
}

-(void)getCacheData{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *cacheData = [weakSelf.dataBase getAllObjectsOfClass:newsModel.class fromTable:newsTableName];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (cacheData.count == 0) {
                [self loadData];
            }else{
                [self.dataArray removeAllObjects];
                self.dataArray = [NSMutableArray arrayWithArray:cacheData];
                [self.newsTableView reloadData];
            };
        });
        
    });

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"newsTableViewCellID";
    newsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[newsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    newsModel *model = _dataArray[indexPath.row];
    [cell setCellData:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detail = [DetailViewController new];
    newsModel *model = _dataArray[indexPath.row];
    detail.webURL = model.link;
    [self.navigationController pushViewController:detail animated:YES];
}


-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
        _line.backgroundColor = [UIColor grayColor];
    }
    return _line;
}
-(UITableView *)newsTableView{
    if (!_newsTableView) {
        _newsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - (kHeight_NavContentBar)-(kHeight_NavBar)-(kHeight_TabBar)) style:UITableViewStylePlain];
        _newsTableView.delegate = self;
        _newsTableView.dataSource = self;
    }
    return _newsTableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
