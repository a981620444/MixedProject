//
//  SynopsisTableViewCell.m
//  MixedDemo
//
//  Created by simple on 2019/2/16.
//  Copyright © 2019年 MixedDemoTest. All rights reserved.
//

#import "SynopsisTableViewCell.h"
#import "Masonry.h"
#import "videoModel.h"
#import "UIImageView+WebCache.h"

@interface SynopsisTableViewCell()

@property(nonatomic,strong)UIImageView *image;
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *name;

@end

@implementation SynopsisTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubView];
    }
    return self;
}

-(void)initSubView{

    [self.contentView addSubview:self.image];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.name];
    
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.contentView).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(90, 60));
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.image.mas_right).with.offset(10);
        make.top.equalTo(self.contentView).with.offset(10);
        make.right.equalTo(self.contentView).with.offset(-10);
    }];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.image.mas_right).with.offset(10);
        make.bottom.equalTo(self.contentView).with.offset(-10);
        make.height.equalTo(@15);
        make.width.equalTo(self.title);
    }];
}

-(void)setCellDataVideoModel:(videoModel *)item{
    [_image sd_setImageWithURL:item.cover[@"feed"]];
    _title.text = item.title;
    _name.text = item.category;
}

-(UIImageView *)image{
    if (!_image) {
        _image = [UIImageView new];
    }
    return _image;
}
-(UILabel *)title{
    if (!_title) {
        _title = [UILabel new];
        _title.font = [UIFont systemFontOfSize:15];
        _title.numberOfLines = 2;
    }
    return _title;
}
-(UILabel *)name{
    if (!_name) {
        _name = [UILabel new];
        _name.font = [UIFont systemFontOfSize:12];
        _name.numberOfLines = 1;
        _name.textColor = [UIColor grayColor];
    }
    return _name;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
