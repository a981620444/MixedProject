//
//  FindTableViewCell.m
//  HighCopyWeChat
//
//  Created by simple on 2018/10/12.
//  Copyright © 2018年 TestWeChat. All rights reserved.
//

#import "FindTableViewCell.h"
#import "Masonry.h"

@implementation FindTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayout];
    }
    return self;
}

-(void)initLayout
{
    self.headImg = [[UIImageView alloc]init];
    self.title = [[UILabel alloc]init];

    [self.contentView addSubview:_headImg];
    [self.contentView addSubview:self.title];
    
    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.leading.equalTo(self.contentView).with.offset(12);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImg);
        make.bottom.equalTo(self.headImg);
        make.left.equalTo(self.headImg.mas_right).with.offset(12);
        make.trailing.equalTo(self.contentView).with.offset(-55);
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
