//
//  SectionHeadView.h
//  HighCopyWeChat
//
//  Created by simple on 2018/10/14.
//  Copyright © 2018年 TestWeChat. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const CGFloat SectionHeaderVerticalInterval;
extern const CGFloat SectionHeaderHorizontalInterval;

@protocol SectionHeadViewDelegate <NSObject>

-(void)foldingContent:(BOOL)folding :(NSInteger)section;
- (void)didClickLikeButton:(NSInteger)section;
- (void)didClickCommentButton:(NSInteger)section;

@end

@class CircleModel;

@interface SectionHeadView : UITableViewHeaderFooterView

@property(nonatomic,strong)UIImageView *headImg;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UILabel *time;
@property(nonatomic,strong)UIButton *commentsBtn;
@property(nonatomic,strong)UIButton *foldingContent;
@property(nonatomic,strong)UIImageView *picImagV;
@property(nonatomic,strong)UIView *LikeAndComments;
@property(nonatomic,strong)UIButton *likeBut;
@property(nonatomic,strong)UIButton *commentsBut;

@property(nonatomic,assign)BOOL ContainLiker;

-(void)setSectionMessage:(CircleModel *)item :(NSInteger)section;

@property(nonatomic,weak)id<SectionHeadViewDelegate> delegate;

@end
