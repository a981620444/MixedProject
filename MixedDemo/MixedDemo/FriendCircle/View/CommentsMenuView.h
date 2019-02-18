//
//  CommentsMenuView.h
//  HighCopyWeChat
//
//  Created by simple on 2018/11/1.
//  Copyright © 2018年 TestWeChat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentsMenuViewDelegate <NSObject>

@end

@interface CommentsMenuView : UIView

@property (nonatomic, copy) void (^likeButtonClickedBlock)(void);
@property (nonatomic, copy) void (^commentButtonClickedBlock)(void);


@property(nonatomic,assign)BOOL show;
@property(nonatomic,strong)UIButton *likeBut;
@property(nonatomic,strong)UIButton *commentsBut;

@property(nonatomic,weak)id <CommentsMenuViewDelegate> delegate;

@end
