//
//  MeTableViewCell.m
//  MixedDemo
//
//  Created by simple on 2019/2/19.
//  Copyright © 2019年 MixedDemoTest. All rights reserved.
//

#import "MeTableViewCell.h"
#import "Masonry.h"

@implementation MeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayout];
    }
    return self;
}
-(void)initLayout{
    self.headImg = [[UIImageView alloc]init];
    self.name = [[UILabel alloc]init];
    self.number = [[UILabel alloc]init];
    
    [self.contentView addSubview:_headImg];
    [self.contentView addSubview:_name];
    [self.contentView addSubview:_number];
    
    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.leading.equalTo(self.contentView).with.offset(12);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImg);
        make.left.equalTo(self.headImg.mas_right).with.offset(12);
        make.height.equalTo(@35);
        make.trailing.equalTo(self.contentView).offset(-55);
    }];
    [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name.mas_bottom);
        make.bottom.equalTo(self.headImg);
        make.left.equalTo(self.headImg.mas_right).with.offset(12);
        make.trailing.equalTo(self.contentView).offset(-55);
    }];
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
