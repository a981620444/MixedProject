//
//  CommentsMenuView.m
//  HighCopyWeChat
//
//  Created by simple on 2018/11/1.
//  Copyright © 2018年 TestWeChat. All rights reserved.
//

#import "CommentsMenuView.h"
#import "Masonry.h"

@implementation CommentsMenuView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

-(void)initLayout{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5;
    self.backgroundColor = [UIColor colorWithRed:69/255.0 green:74/255.0 blue:76/255.0 alpha:1];
    
    _likeBut = [self creatButtonWithTitle:@"赞" image:[UIImage imageNamed:@"AlbumLike"]target:self selector:@selector(likeButtonClicked)];
    _commentsBut = [self creatButtonWithTitle:@"评论" image:[UIImage imageNamed:@"AlbumComment"] target:self selector:@selector(commentButtonClicked)];
    
    UIView *centerLine = [UIView new];
    centerLine.backgroundColor = [UIColor grayColor];
    
    [self addSubview:_likeBut];
    [self addSubview:_commentsBut];
    [self addSubview:centerLine];
    [_likeBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self);
        make.width.equalTo(@80);
    }];
    [centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.width.equalTo(@1);
        make.left.equalTo(self.likeBut.mas_right);
    }];
    [_commentsBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.width.equalTo(self.likeBut);
        make.left.equalTo(centerLine.mas_right);
    }];
}

- (UIButton *)creatButtonWithTitle:(NSString *)title image:(UIImage *)image target:(id)target selector:(SEL)sel {
    UIButton *btn = [UIButton new];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    return btn;
}
- (void)likeButtonClicked{
    NSLog(@"123");
}

- (void)commentButtonClicked{
    NSLog(@"1234");
}

@end
