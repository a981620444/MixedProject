//
//  CommentsTableViewCell.h
//  HighCopyWeChat
//
//  Created by simple on 2018/10/24.
//  Copyright © 2018年 TestWeChat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentsTableViewCellDelegate <NSObject>

- (void)didSelectPeople:(NSDictionary *)dic;

@end

@class CircleModel;

@interface CommentsTableViewCell : UITableViewCell

-(void)getCommntsString:(CircleModel *)item :(NSDictionary *)commentsDic;

@property(nonatomic,weak)id <CommentsTableViewCellDelegate> delegate;

@end
