//
//  LikeCircleTableViewCell.m
//  HighCopyWeChat
//
//  Created by simple on 2018/10/16.
//  Copyright © 2018年 TestWeChat. All rights reserved.
//

#import "LikeCircleTableViewCell.h"
#import "TTTAttributedLabel.h"
#import "CircleModel.h"
#import "Masonry.h"


@interface LikeCircleTableViewCell ()<TTTAttributedLabelDelegate>
{

}
@property (nonatomic,strong)CircleModel *cellItem;
@property(nonatomic,strong)TTTAttributedLabel *contentLab;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *love;

@end

@implementation LikeCircleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayout];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)initLayout{
    
    self.backgroundColor = [UIColor whiteColor];
    
    _bgView = [[UIView alloc]init];
    [self.contentView addSubview:_bgView];
    
    _love = [[UIImageView alloc]init];
    _contentLab = [TTTAttributedLabel new];
    _contentLab.lineSpacing = 2;
    _contentLab.numberOfLines = 0;
    _contentLab.font = [UIFont systemFontOfSize:15];
    _contentLab.delegate = self;
    
    _bgView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    
    [_bgView addSubview:_love];
    [_bgView addSubview:_contentLab];
    [self setLinkStyle];
    
}

-(void)getLikerString:(CircleModel *)item{
    _cellItem = item;
    NSMutableArray *rangeArr = [NSMutableArray array];
    NSString *space = @"       ";
    NSString *symbol = @", ";
    NSMutableString *liker = [NSMutableString string];
    for (NSDictionary *dic in _cellItem.like_users) {
        NSString *singleLiker = dic[@"userName"];
        NSString *addLiker = [NSString string];
        if ([singleLiker isEqualToString:_cellItem.like_users[0][@"userName"]]) {
            addLiker = [space stringByAppendingString:singleLiker];
            NSDictionary *rangeDic = @{@"frontRange":@(space.length),@"userNameLength":@(singleLiker.length),@"userName":singleLiker};
            [rangeArr addObject:rangeDic];
        }else{
            NSDictionary *rangeDic = @{@"frontRange":@(liker.length + symbol.length),@"userNameLength":@(singleLiker.length),@"userName":singleLiker};
            [rangeArr addObject:rangeDic];
            
            addLiker = [symbol stringByAppendingString:singleLiker];
        }
        [liker appendString:addLiker];
    }
    NSString *likerString = [NSString stringWithString:liker];
    _contentLab.text = likerString;
    
    for (NSDictionary *rangeDic in rangeArr) {
        NSRange range = NSMakeRange([rangeDic[@"frontRange"] integerValue], [rangeDic[@"userNameLength"]integerValue]);
        [_contentLab addLinkToTransitInformation:@{@"user_name":rangeDic[@"userName"]} withRange:range];
    }
    
    [self calculateLikerHeight:likerString];
}
-(void)calculateLikerHeight:(NSString *)likerString{
    
    NSMutableAttributedString *attributeLiker = [[NSMutableAttributedString alloc]initWithString:likerString];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 2;
    [attributeLiker addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, likerString.length)];
    [attributeLiker addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, likerString.length)];
    
    CGFloat heighht = [attributeLiker boundingRectWithSize:CGSizeMake(kScreenWidth - 70, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size.height;
    
    NSInteger likerHeight = ceil(heighht);
    
    [self setConstraint:likerHeight];
    
}
-(void)setConstraint:(NSInteger)likerHeight{
    [_bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(52);
        make.right.equalTo(@-8);
        make.height.mas_equalTo(likerHeight+10);
    }];
    [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).with.offset(5);
        make.left.equalTo(self.bgView).with.offset(5);
        make.right.equalTo(self.bgView).with.offset(-5);
        make.height.mas_equalTo(likerHeight);
    }];
    UIFont *font = [UIFont systemFontOfSize:15];
    _love.image = [UIImage imageNamed:@"Like"];
    [self.love mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).with.offset(5);
        make.left.equalTo(self.bgView).with.offset(8);
        make.width.mas_equalTo(font.lineHeight);
        make.height.mas_equalTo(font.lineHeight);
    }];
}
- (void)setLinkStyle{
    UIFont *font = [UIFont boldSystemFontOfSize:15];
    UIColor *color = [UIColor colorWithRed:54/255.0 green:71/255.0 blue:121/255.0 alpha:1];
    _contentLab.linkAttributes = @{(NSString *)kCTUnderlineStyleAttributeName : @(kCTUnderlineStyleNone),(NSString *)kCTForegroundColorAttributeName : color ,(NSString *)kCTFontAttributeName : font};
    
    _contentLab.activeLinkAttributes = @{(NSString *)kCTUnderlineStyleAttributeName : @(kCTUnderlineStyleNone),(NSString *)kCTForegroundColorAttributeName : color ,(NSString *)kCTFontAttributeName : font};
    
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
