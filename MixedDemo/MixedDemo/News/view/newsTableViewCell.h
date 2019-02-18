//
//  newsTableViewCell.h
//  MixedDemo
//
//  Created by simple on 2019/1/22.
//  Copyright © 2019年 MixedDemoTest. All rights reserved.
//

#import <UIKit/UIKit.h>
@class newsModel;

@interface newsTableViewCell : UITableViewCell

-(void)setCellData:(newsModel *)model;

@end
