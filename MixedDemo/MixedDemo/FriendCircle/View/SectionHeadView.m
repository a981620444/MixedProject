//
//  SectionHeadView.m
//  HighCopyWeChat
//
//  Created by simple on 2018/10/14.
//  Copyright © 2018年 TestWeChat. All rights reserved.
//

#import "SectionHeadView.h"
#import "Masonry.h"
#import "CircleModel.h"
#import "UIImageView+WebCache.h"
#import "TTTAttributedLabel.h"
#import "CircleModel.h"
#import "CommentsMenuView.h"

const CGFloat SectionHeaderVerticalInterval = 8;
const CGFloat SectionHeaderHorizontalInterval = 8;


@interface SectionHeadView ()
{
    BOOL likeAndCommentsShow;
}
@property(nonatomic,strong)TTTAttributedLabel *contentLab;
@property(nonatomic,strong)CircleModel *item;
@property(nonatomic,assign)NSInteger section;

@end

@implementation SectionHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayout];
    }
    return self;
}
-(void)initLayout{
    _LikeAndComments = [[UIView alloc]init];
    
    UIView *backgroudView = [[UIView alloc]init];
    backgroudView.backgroundColor = [UIColor whiteColor];
    self.backgroundView = backgroudView;
    
    self.headImg = [[UIImageView alloc]init];
    self.name = [[UILabel alloc]init];
    self.contentLab = [[TTTAttributedLabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.time = [[UILabel alloc]init];
    self.foldingContent = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.picImagV = [[UIImageView alloc]init];
    
    [self.foldingContent setTitleColor:[UIColor colorWithRed:65/255.0 green:105/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    [self.foldingContent addTarget:self action:@selector(clickFoldingButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.commentsBtn setImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
    [self.commentsBtn addTarget:self action:@selector(clickCommentButton) forControlEvents:UIControlEventTouchUpInside];

    self.contentLab.font = [UIFont systemFontOfSize:16];
    self.contentLab.numberOfLines = 0;
    self.contentLab.lineSpacing = 2;
    self.contentLab.lineBreakMode = NSLineBreakByTruncatingTail;
    self.contentLab.preferredMaxLayoutWidth = 315;
    
    self.time.font = [UIFont systemFontOfSize:13];
    self.time.textColor = [UIColor colorWithRed:135/255.0 green:135/255.0 blue:135/255.0 alpha:1];
    
    [self addSubview:_headImg];
    [self addSubview:_name];
    [self addSubview:_contentLab];
    [self addSubview:_time];
    [self addSubview:_commentsBtn];
    [self addSubview:_foldingContent];
    [self addSubview:_picImagV];
    [self addSubview:_LikeAndComments];
    
    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.top.equalTo(@8);
        make.width.height.equalTo(@36);
    }];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImg.mas_right).offset(8);
        make.right.equalTo(@-8);
        make.top.equalTo(self.headImg);
        make.height.equalTo(@20);
    }];
}
-(void)setSectionMessage:(CircleModel *)item :(NSInteger)section{
    self.item = item;
    self.section = section;
    [_headImg sd_setImageWithURL:[NSURL URLWithString:item.photo]];
    _name.text = item.user_name;
    _time.text = item.time_str;
    self.contentLab.text = item.message;
    
    [self setContentConstraint];
    [self setPictureImageViewConstraint];
    [self setTimeAndCommentConstraint];
    [self setLikerAndCommentsMenuView];
    [self addPicture];
}

-(void)setContentConstraint{
    
    if (self.item.contentLabelHeight <= 0) {
        [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            
        }];
        [self.foldingContent mas_remakeConstraints:^(MASConstraintMaker *make) {
            
        }];
        self.foldingContent.hidden = YES;
        self.contentLab.hidden = YES;
    }else if (self.item.contentLabelHeight <= 104){
        [self.foldingContent mas_remakeConstraints:^(MASConstraintMaker *make) {
            
        }];
        self.foldingContent.hidden = YES;
        self.contentLab.hidden = NO;
        [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.name);
            make.top.equalTo(self.name.mas_bottom).with.equalTo(@10);
            make.height.mas_equalTo(self.item.contentLabelHeight);
            make.right.equalTo(@-8);
        }];

    }else{
        self.foldingContent.hidden = NO;
        if (self.item.folding) {
            [self.foldingContent setTitle:@"收起" forState:UIControlStateNormal];
            [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.name);
                make.top.equalTo(self.name.mas_bottom).with.equalTo(@10);
                make.height.mas_equalTo(self.item.contentLabelHeight);
                make.right.equalTo(@-8);
            }];
            
        }else{
            [self.foldingContent setTitle:@"全文" forState:UIControlStateNormal];
            [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.name);
                make.top.equalTo(self.name.mas_bottom).with.equalTo(@10);
                make.height.mas_equalTo(104);
                make.right.equalTo(@-8);
            }];
        }

        [self.foldingContent mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLab.mas_bottom).with.offset(8);
            make.left.equalTo(self.name);
            make.size.mas_equalTo(CGSizeMake(40, 25));
        }];
        
    }
    
}
-(void)setPictureImageViewConstraint{
    [self.picImagV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (self.item.imageViewHeight <= 0) {
        self.picImagV.hidden = YES;
    }else{
        self.picImagV.hidden = NO;
        if (self.foldingContent.hidden == YES) {
            if (self.contentLab.hidden == YES) {
                [self.picImagV mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.name.mas_bottom).with.offset(8);
                    make.left.equalTo(self.name);
                    make.right.equalTo(@-8);
                    make.height.mas_equalTo(self.item.imageViewHeight);
                }];
            }else{
                [self.picImagV mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentLab.mas_bottom).with.offset(8);
                    make.left.equalTo(self.name);
                    make.right.equalTo(@-8);
                    make.height.mas_equalTo(self.item.imageViewHeight);
                }];
            }
        }else{
            [self.picImagV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.foldingContent.mas_bottom).with.offset(8);
                make.left.equalTo(self.name);
                make.right.equalTo(@-8);
                make.height.mas_equalTo(self.item.imageViewHeight);
            }];
            
        }
    }
}
-(void)setTimeAndCommentConstraint{
    if (self.picImagV.hidden == YES) {
        if (self.foldingContent.hidden == YES) {
            [self.time mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.name);
                make.top.equalTo(self.contentLab.mas_bottom).with.offset(8);
                make.size.mas_equalTo(CGSizeMake(80, 20));
            }];
        }else{
            [self.time mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.name);
                make.top.equalTo(self.foldingContent.mas_bottom).with.offset(8);
                make.size.mas_equalTo(CGSizeMake(80, 20));
            }];
        }
    }else{
        [self.time mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.name);
            make.top.equalTo(self.picImagV.mas_bottom).with.offset(8);
            make.size.mas_equalTo(CGSizeMake(80, 20));
        }];
    }
    [self.commentsBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 24));
        make.right.equalTo(@-8);
        make.top.equalTo(self.time).with.offset(-2);
    }];
    [self.LikeAndComments mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.commentsBtn).with.offset(-4);
                make.right.equalTo(self.commentsBtn.mas_left);
                make.height.equalTo(@31);
                make.width.mas_equalTo(0);
    }];
    
}
-(void)addPicture{

    if (self.item.small_pics.count == 1) {
        UIImageView *imgV = [[UIImageView alloc]init];
        [self.picImagV addSubview:imgV];
        [imgV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(140, 100));
        }];
        NSString *picURL = self.item.small_pics[0];
        [imgV sd_setImageWithURL:[NSURL URLWithString:picURL]];
        
    }else{
        for (int i = 0; i < self.item.small_pics.count; i++) {
            if (i == 3) {
                break;
            }
            UIImageView *imgV = [self createSmallPictureImageView:self.item.small_pics[i]];
            [self.picImagV addSubview:imgV];
            [imgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.left.mas_equalTo(70 * i + i * 5);
                make.size.mas_equalTo(CGSizeMake(70, 70));
            }];
        }
        if (self.item.small_pics.count > 3) {
            for (int i = 3; i < self.item.small_pics.count; i++) {
                if (i == 6) {
                    break;
                }
                UIImageView *imgV = [self createSmallPictureImageView:self.item.small_pics[i]];
                [self.picImagV addSubview:imgV];
                [imgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(@75);
                    make.left.mas_equalTo(70 * (i-3) + (i-3) * 5);
                    make.size.mas_equalTo(CGSizeMake(70, 70));
                }];
            }
        }
        if (self.item.small_pics.count > 6) {
            for (int i = 6; i < self.item.small_pics.count; i++) {
                if (i == 9) {
                    break;
                }
                UIImageView *imgV = [self createSmallPictureImageView:self.item.small_pics[i]];
                [self.picImagV addSubview:imgV];
                [imgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(@150);
                    make.left.mas_equalTo(70 * (i-6) + (i-6) * 5);
                    make.size.mas_equalTo(CGSizeMake(70, 70));
                }];
            }
        }
    }
}
-(UIImageView *)createSmallPictureImageView:(NSString *)picUrl{
    UIImageView *imgV = [[UIImageView alloc]init];
    imgV.contentMode = UIViewContentModeScaleAspectFill;
    imgV.clipsToBounds = YES;
    [imgV sd_setImageWithURL:[NSURL URLWithString:picUrl]];
    return imgV;
}
-(void)clickCommentButton{
    BOOL isContain = NO;
    for (NSDictionary *dic in self.item.like_users) {
        if ([[dic valueForKey:@"userId"] integerValue] == 0) {
            isContain = YES;
            break;
        }
    }
    if (isContain) {
        [self.likeBut setTitle:@"取消" forState:UIControlStateNormal];
    } else {
        [self.likeBut setTitle:@"赞" forState:UIControlStateNormal];
    }
    
    if (!likeAndCommentsShow) {
        [self.LikeAndComments mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@161);
        }];
        likeAndCommentsShow = YES;
    }else{
        [self.LikeAndComments mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@0);
        }];
        likeAndCommentsShow = NO;
    }
    [UIView animateWithDuration:0.2 animations:^{
        
        [self.superview layoutIfNeeded];
    }];

 
}
//点击评论，设置弹出的  ，赞/评论 view
-(void)setLikerAndCommentsMenuView{
    self.LikeAndComments.clipsToBounds = YES;
    self.LikeAndComments.layer.cornerRadius = 5;
    self.LikeAndComments.backgroundColor = [UIColor colorWithRed:69/255.0 green:74/255.0 blue:76/255.0 alpha:1];
    
    _likeBut = [self creatButtonWithTitle:@"赞" image:[UIImage imageNamed:@"AlbumLike"]target:self selector:@selector(likeButtonClicked)];
    _commentsBut = [self creatButtonWithTitle:@"评论" image:[UIImage imageNamed:@"AlbumComment"] target:self selector:@selector(commentButtonClicked)];
    
    UIView *centerLine = [UIView new];
    centerLine.backgroundColor = [UIColor grayColor];
    
    [self.LikeAndComments addSubview:_likeBut];
    [self.LikeAndComments addSubview:_commentsBut];
    [self.LikeAndComments addSubview:centerLine];
    [_likeBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.LikeAndComments);
        make.width.equalTo(@80);
    }];
    [centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.LikeAndComments);
        make.width.equalTo(@1);
        make.left.equalTo(self.likeBut.mas_right);
    }];
    [_commentsBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.LikeAndComments);
        make.width.equalTo(self.likeBut);
        make.left.equalTo(centerLine.mas_right);
    }];
}
//创建按钮快捷方法
- (UIButton *)creatButtonWithTitle:(NSString *)title image:(UIImage *)image target:(id)target selector:(SEL)sel {
    UIButton *btn = [UIButton new];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    return btn;
}
//点击（赞）按钮，调用代理方法
- (void)likeButtonClicked{
    if ([self.delegate respondsToSelector:@selector(didClickLikeButton :)]) {
        [self.delegate didClickLikeButton:self.section];
    };
}
//点击评论按钮
- (void)commentButtonClicked{
    [self.LikeAndComments mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        
        [self.superview layoutIfNeeded];
    }];
    likeAndCommentsShow = NO;
    [self.delegate didClickCommentButton:self.section];
}


-(void)clickFoldingButton{
    if (self.item.folding) {
        [self.foldingContent setTitle:@"收起" forState:UIControlStateNormal];
        [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.name);
            make.top.equalTo(self.name.mas_bottom).with.equalTo(@10);
            make.height.mas_equalTo(self.item.contentLabelHeight);
            make.right.equalTo(@-8);
        }];
    }else{
        [self.foldingContent setTitle:@"全文" forState:UIControlStateNormal];
        [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.name);
            make.top.equalTo(self.name.mas_bottom).with.equalTo(@10);
            make.height.mas_equalTo(104);
            make.right.equalTo(@-8);
        }];
    }
    if ([self.delegate respondsToSelector:@selector(foldingContent::)]) {
        [self.delegate foldingContent:!self.item.folding :self.section];
    };
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.LikeAndComments mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0);
    }];
    [UIView animateWithDuration:0.2 animations:^{

        [self.superview layoutIfNeeded];
    }];
    likeAndCommentsShow = NO;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
