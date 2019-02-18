//
//  LikeCircleTableViewCell.h
//  HighCopyWeChat
//
//  Created by simple on 2018/10/16.
//  Copyright © 2018年 TestWeChat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LikeCircleTableViewCellDelegate <NSObject>

- (void)didSelectPeople:(NSDictionary *)dic;

@end

@class CircleModel;

@interface LikeCircleTableViewCell : UITableViewCell

@property(nonatomic,weak)id<LikeCircleTableViewCellDelegate> delegate;

-(void)getLikerString:(CircleModel *)item;

@end
