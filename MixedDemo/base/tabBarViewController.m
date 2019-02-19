//
//  tabBarViewController.m
//  MixedDemo
//
//  Created by simple on 2019/1/20.
//  Copyright © 2019年 MixedDemoTest. All rights reserved.
//

#import "tabBarViewController.h"
#import "NewsViewController.h"
#import "baseViewController.h"
#import "VideoDetailViewController.h"
#import "FriendCircleViewController.h"
#import "meViewController.h"

@interface tabBarViewController ()

@end

@implementation tabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initItem];
}

-(void)initItem{

    baseViewController *news = [baseViewController new];
    UINavigationController *newsNav = [[UINavigationController alloc]initWithRootViewController:news];
    newsNav.tabBarItem.title = @"新闻";
    newsNav.tabBarItem.image = [UIImage imageNamed:@"home2"];
    newsNav.tabBarItem.selectedImage = [UIImage imageNamed:@"home1"];
    
    VideoDetailViewController *video = [VideoDetailViewController new];
    UINavigationController *videoNav = [[UINavigationController alloc]initWithRootViewController:video];
    videoNav.tabBarItem.title = @"视频";
    videoNav.tabBarItem.image = [UIImage imageNamed:@"video2"];
    videoNav.tabBarItem.selectedImage = [UIImage imageNamed:@"video1"];

    FriendCircleViewController *circle = [FriendCircleViewController new];
    UINavigationController *circleNav = [[UINavigationController alloc]initWithRootViewController:circle];
    circleNav.tabBarItem.title = @"朋友圈";
    circleNav.tabBarItem.image = [UIImage imageNamed:@"circle2"];
    circleNav.tabBarItem.selectedImage = [UIImage imageNamed:@"circle1"];

    meViewController *me = [meViewController new];
    UINavigationController *meNav = [[UINavigationController alloc]initWithRootViewController:me];
    meNav.tabBarItem.title = @"个人";
    meNav.tabBarItem.image = [UIImage imageNamed:@"people2"];
    meNav.tabBarItem.selectedImage = [UIImage imageNamed:@"people1"];

    [self addChildViewController:newsNav];
    [self addChildViewController:videoNav];
    [self addChildViewController:circleNav];
    [self addChildViewController:meNav];
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
