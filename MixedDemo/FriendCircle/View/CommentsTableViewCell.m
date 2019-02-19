//
//  CommentTableViewCell.m
//  HighCopyWeChat
//
//  Created by simple on 2018/10/24.
//  Copyright © 2018年 TestWeChat. All rights reserved.
//

#import "CommentsTableViewCell.h"
#import "TTTAttributedLabel.h"
#import "CircleModel.h"
#import "Masonry.h"

@interface CommentsTableViewCell ()<TTTAttributedLabelDelegate>
{
    CircleModel *rowItem;
}

@property(nonatomic,strong)TTTAttributedLabel *commentLab;
@property(nonatomic,strong)UIView *bgView;

@end

@implementation CommentsTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayout];
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

-(void)initLayout{
    _bgView = [[UIView alloc]init];
    _bgView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    _commentLab = [TTTAttributedLabel new];

    _commentLab.lineSpacing = 2;
    _commentLab.numberOfLines = 0;
    _commentLab.font = [UIFont systemFontOfSize:15];
    _commentLab.delegate = self;
    [self linkStyles];
    [self.contentView addSubview:_bgView];
    [_bgView addSubview:_commentLab];
    
}

-(void)getCommntsString:(CircleModel *)item :(NSDictionary *)commentsDic{
    rowItem = item;
    NSString *commentsText = [NSString string];
    if (commentsDic[@"comment_to_user_name"] == nil || [commentsDic[@"comment_to_user_name"] isEqualToString:item.user_name]) {
        commentsText = [NSString stringWithFormat:@"%@: %@",commentsDic[@"comment_user_name"],commentsDic[@"comment_text"]];
    }else{
        commentsText = [NSString stringWithFormat:@"%@回复%@: %@",commentsDic[@"comment_user_name"],commentsDic[@"comment_to_user_name"], commentsDic[@"comment_text"]];
    }
    _commentLab.text = commentsText;
    
    NSRange boldRange0 = NSMakeRange(0, [[commentsDic valueForKey:@"comment_user_name"] length]);
    NSRange boldRange1 = NSMakeRange([[commentsDic valueForKey:@"comment_user_name"] length] + 2, [[commentsDic valueForKey:@"comment_to_user_name"] length]);
    [self.commentLab addLinkToTransitInformation:@{@"user_name":[commentsDic valueForKey:@"comment_user_name"]} withRange:boldRange0];
    if ([commentsDic valueForKey:@"comment_to_user_name"] == nil || [[commentsDic valueForKey:@"comment_to_user_name"] length] <= 0 || [[commentsDic valueForKey:@"comment_to_user_id"] integerValue] == item.user_id) {
        
    } else {
        [self.commentLab addLinkToTransitInformation:@{@"user_name":[commentsDic valueForKey:@"comment_to_user_name"]} withRange:boldRange1];
    }
    [self calculateCommentsHeight:commentsText];
}
-(void)calculateCommentsHeight:(NSString *)comments{
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:comments];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.lineSpacing = 2;
    [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, comments.length)];
    [attString addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, comments.length)];
    
    CGFloat commentsHeight = [attString boundingRectWithSize:CGSizeMake(kScreenWidth - 70, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size.height;
    [self setConstraint:ceil(commentsHeight)];
}

-(void)setConstraint:(CGFloat)commentsHeight{
    [_bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(52);
        make.right.equalTo(@-8);
        make.height.mas_equalTo(commentsHeight+10);
    }];
    [_commentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).with.offset(5);
        make.left.equalTo(self.bgView).with.offset(5);
        make.right.equalTo(self.bgView).with.offset(-5);
        make.height.mas_equalTo(commentsHeight);
    }];
    
}

- (void)linkStyles {
    UIColor *linkColor = [UIColor colorWithRed:54/255.0 green:71/255.0 blue:121/255.0 alpha:1];//名字颜色
    CTUnderlineStyle linkUnderLineStyle = kCTUnderlineStyleNone;
    UIColor *activeLinkColor = [UIColor colorWithRed:54/255.0 green:71/255.0 blue:121/255.0 alpha:1];
    CTUnderlineStyle activelinkUnderLineStyle  = kCTUnderlineStyleNone;
    
    // 没有点击时候的样式
    self.commentLab.linkAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],
                                         (NSString *)kCTForegroundColorAttributeName: linkColor,
                                         (NSString *)kCTUnderlineStyleAttributeName: [NSNumber numberWithInt:linkUnderLineStyle]};
    // 点击时候的样式
    self.commentLab.activeLinkAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],
                                               (NSString *)kCTForegroundColorAttributeName: activeLinkColor,
                                               (NSString *)kTTTBackgroundFillColorAttributeName:[UIColor lightGrayColor],
                                               (NSString *)kCTUnderlineStyleAttributeName: [NSNumber numberWithInt:activelinkUnderLineStyle]};
}
#pragma mark - TTTAttributedLabelDelegate

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTransitInformation:(NSDictionary *)components {
    if ([_delegate respondsToSelector:@selector(didSelectPeople:)]) {
        [_delegate didSelectPeople:components];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
