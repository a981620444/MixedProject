//
//  CircleModel.h
//  HighCopyWeChat
//
//  Created by simple on 2018/10/14.
//  Copyright © 2018年 TestWeChat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CircleModel : NSObject

-(instancetype)initWithItem:(id)item;

@property (nonatomic, copy) NSString *message_id;
@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, copy) NSString *user_name;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *time_str;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSArray *small_pics;
@property (nonatomic, copy) NSArray *big_pics;
@property (nonatomic, copy) NSArray *like_users;
@property (nonatomic, copy) NSArray *comments;


@property(nonatomic,assign)CGFloat contentLabelHeight;
@property(nonatomic,assign)CGFloat headerHeight;
@property(nonatomic,assign)CGFloat imageViewHeight;
@property(nonatomic,assign)CGFloat likerRowHeight;
@property (nonatomic, assign) NSInteger cellCount;
@property (nonatomic, strong) NSMutableArray *commentHeightArr;
@property(nonatomic,assign)BOOL folding;

@end
