//
//  topSearchView.m
//  MixedDemo
//
//  Created by simple on 2019/1/23.
//  Copyright © 2019年 MixedDemoTest. All rights reserved.
//

#import "topSearchView.h"
#import <Masonry.h>
#import "SearchViewController.h"
#import "baseViewController.h"

@interface topSearchView()

@property(nonatomic,strong)UIButton *logo;

@property(nonatomic,strong)UIButton *live;


@end


@implementation topSearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubView];
        
    }
    return self;
}

-(void)configSubView{
    self.backgroundColor = [UIColor colorWithRed:225.0/255.0 green:39.0/255.0 blue:41.0/255.0 alpha:1];
    
    [self addSubview:self.logo];
    [self addSubview:self.searchImg];
    [self addSubview:self.live];
    
    [self.logo mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(8);
        make.top.equalTo(self).with.offset(kHeight_StatusBar);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    [self.searchImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logo.mas_right);
        make.top.equalTo(self).with.offset(kHeight_StatusBar);
        make.size.mas_equalTo(CGSizeMake(284, 44));
    }];
    [self.live mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchImg.mas_right);
        make.top.equalTo(self).with.offset(kHeight_StatusBar);
        make.size.mas_equalTo(CGSizeMake(32, 44));
    }];
}

-(UIButton *)logo{
    if (!_logo) {
        _logo = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *logoImage = [UIImage imageNamed:@"logo"];
        [_logo setImage:logoImage forState:UIControlStateNormal];
    }
    return _logo;
}
-(UIButton *)searchImg{
    if (!_searchImg) {
        _searchImg = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *searchImage = [UIImage imageNamed:@"search+"];
        [_searchImg setImage:searchImage forState:UIControlStateNormal];
    }
    return _searchImg;
}
-(UIButton *)live{
    if (!_live) {
        _live = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *liveImage = [UIImage imageNamed:@"live"];
        [_live setImage:liveImage forState:UIControlStateNormal];
    }
    return _live;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
