//
//  newsTableViewCell.m
//  MixedDemo
//
//  Created by simple on 2019/1/22.
//  Copyright © 2019年 MixedDemoTest. All rights reserved.
//

#import "newsTableViewCell.h"
#import "Masonry.h"
#import "HttpTool.h"
#import "newsModel.h"
#import "UIImageView+WebCache.h"

@interface newsTableViewCell()

@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *author;
@property(nonatomic,strong)UIImageView *smallImage;

@end

@implementation newsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubView];
    }
    return self;
}

-(void)initSubView{
    [self addSubview:self.author];
    [self addSubview:self.title];
    [self addSubview:self.smallImage];
    
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(11);
        make.left.equalTo(self).with.offset(11);
        make.width.equalTo(@((kScreenWidth/3*2)-20));
        make.height.equalTo(@50);
    }];
    [self.author mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).with.offset(8);
        make.left.equalTo(self.title);
        make.width.equalTo(self.title);
        make.bottom.equalTo(self.mas_bottom).with.offset(-11);
    }];
    [self.smallImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title);
        make.left.equalTo(self.title.mas_right).with.offset(11);
        make.right.equalTo(self.mas_right).with.offset(-11);
        make.bottom.equalTo(self.author);
    }];
}
-(void)setCellData:(newsModel *)model{
    _title.text = model.title;
    _author.text = model.source;
    for (NSDictionary *item in model.picInfo) {
        [self.smallImage sd_setImageWithURL:[NSURL URLWithString:item[@"url"]]];
    }
}


-(UILabel *)title{
    if (!_title) {
        _title = [UILabel new];
        _title.font = [UIFont systemFontOfSize:18];
        _title.numberOfLines = 0;
        
    }
    return _title;
}
-(UILabel *)author{
    if (!_author) {
        _author = [UILabel new];
        _author.font = [UIFont systemFontOfSize:13];
        _author.textColor = [UIColor grayColor];
    }
    return _author;
}
-(UIImageView *)smallImage{
    if (!_smallImage) {
        _smallImage = [UIImageView new];
    }
    return _smallImage;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
