//
//  baseViewController.m
//  MixedDemo
//
//  Created by simple on 2019/1/22.
//  Copyright © 2019年 MixedDemoTest. All rights reserved.
//

#import "baseViewController.h"
#import "NewsViewController.h"
#import <Masonry.h>
#import "topSearchView.h"
#import "SearchViewController.h"

@interface baseViewController ()

@property (nonatomic,strong)topSearchView *topbar;

@end

@implementation baseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:225.0/255.0 green:39.0/255.0 blue:41.0/255.0 alpha:1];
    self.view.backgroundColor = [UIColor whiteColor];
    self.selectIndex = 1;
    [self.view addSubview:self.topbar];
    [self initChildVC];
    [self setTitleStyle];
}
-(void)initChildVC{
    NewsViewController *news = [NewsViewController new];
    news.title = @"关注";
    news.newsCategory = @"dy";
    NewsViewController *news1 = [NewsViewController new];
    news1.title = @"头条";
    news1.newsCategory = @"dy";
    NewsViewController *news2 = [NewsViewController new];
    news2.title = @"科技";
    news2.newsCategory = @"tech";
    NewsViewController *news3 = [NewsViewController new];
    news3.title = @"汽车";
    news3.newsCategory = @"auto";
    NewsViewController *news4 = [NewsViewController new];
    news4.title = @"财经";
    news4.newsCategory = @"money";
    NewsViewController *news5 = [NewsViewController new];
    news5.title = @"体育";
    news5.newsCategory = @"sports";
    
    [self addChildViewController:news];
    [self addChildViewController:news1];
    [self addChildViewController:news2];
    [self addChildViewController:news3];
    [self addChildViewController:news4];
    [self addChildViewController:news5];

}
-(void)setTitleStyle{
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth) {
        *norColor = [UIColor lightGrayColor];
        *selColor = [UIColor blackColor];
        *titleFont = [UIFont systemFontOfSize:18];
    }];
    [self setUpTitleGradient:^(YZTitleColorGradientStyle *titleColorGradientStyle, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor) {
        *norColor = [UIColor lightGrayColor];
        *selColor = [UIColor colorWithRed:1.0/255.0 green:1.0/255.0 blue:1.0/255.0 alpha:1];
    }];
    [self setUpTitleScale:^(CGFloat *titleScale) {
        *titleScale = 1.1;
    }];
}

-(topSearchView *)topbar{
    if (!_topbar) {
        _topbar = [[topSearchView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_NavBar)];
        [_topbar.searchImg addTarget:self action:@selector(clickSearch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topbar;
}
-(void)clickSearch{
    NSLog(@"11");
    SearchViewController *search = [SearchViewController new];
    [self.navigationController pushViewController:search animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    self.navigationController.navigationBarHidden = YES;
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
