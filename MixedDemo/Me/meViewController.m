//
//  meViewController.m
//  MixedDemo
//
//  Created by simple on 2019/2/19.
//  Copyright © 2019年 MixedDemoTest. All rights reserved.
//

#import "meViewController.h"
#import "MeTableViewCell.h"
#import "FindTableViewCell.h"

@interface meViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *dataArray;
}
@end

@implementation meViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    self.title = @"个人";
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:17]}];
    
    dataArray = @[@[@{@"headImg":@"avatar.jpg",@"name":@"Simple",@"number":@"账号：123456789"}],
                  @[@{@"headImg":@"MoreMyBankCard",@"title":@"钱包"}],
                  @[@{@"headImg":@"MoreMyFavorites", @"title":@"收藏"},
                    @{@"headImg":@"ff_IconShowAlbum", @"title":@"相册"},
                    @{@"headImg":@"MyCardPackageIcon", @"title":@"卡包"},
                    @{@"headImg":@"MoreExpressionShops", @"title":@"表情"}],
                  @[@{@"headImg":@"MoreSetting", @"title":@"设置"}]];
    UITableView *meTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-(kHeight_TabBar)-(kHeight_NavBar)) style:UITableViewStylePlain];
    meTab.dataSource = self;
    meTab.delegate = self;
    meTab.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [self.view addSubview:meTab];
}
#pragma mark - Table view data source

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    return view;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 90;
    }
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataArray[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId0 =@"meIdentifyCell";
    static NSString *cellId1 =@"findIdentifyCell";
    MeTableViewCell *meCell = [tableView dequeueReusableCellWithIdentifier:cellId0];
    FindTableViewCell *findCell = [tableView dequeueReusableCellWithIdentifier:cellId1];
    if (indexPath.section == 0) {
        if (meCell == nil) {
            meCell = [[MeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId0];
        }
        meCell.headImg.image = [UIImage imageNamed:dataArray[indexPath.section][indexPath.row][@"headImg"]];
        meCell.name.text = dataArray[indexPath.section][indexPath.row][@"name"];
        meCell.number.text = dataArray[indexPath.section][indexPath.row][@"number"];
        meCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return meCell;
    }else {
        if (findCell == nil)
            findCell = [[FindTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId1];
        findCell.headImg.image = [UIImage imageNamed:dataArray[indexPath.section][indexPath.row][@"headImg"]];
        findCell.title.text = dataArray[indexPath.section][indexPath.row][@"title"];
        findCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return findCell;
    }
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
