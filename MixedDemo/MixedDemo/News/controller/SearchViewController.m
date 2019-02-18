//
//  searchViewController.m
//  MixedDemo
//
//  Created by simple on 2019/1/25.
//  Copyright © 2019年 MixedDemoTest. All rights reserved.
//

#import "SearchViewController.h"
#import "NewsViewController.h"

@interface SearchViewController ()<UISearchResultsUpdating,UISearchBarDelegate,UISearchControllerDelegate>

@property(nonatomic,strong)UISearchController *topSearch;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
}

-(UISearchController *)topSearch{
    if (!_topSearch) {
        _topSearch = [[UISearchController alloc]initWithSearchResultsController:nil];
        _topSearch.searchResultsUpdater = self;
        _topSearch.delegate = self;
        _topSearch.searchBar.delegate = self;
        _topSearch.dimsBackgroundDuringPresentation = NO;
        _topSearch.hidesNavigationBarDuringPresentation = NO;
        [_topSearch.searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
    }
    return _topSearch;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
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
