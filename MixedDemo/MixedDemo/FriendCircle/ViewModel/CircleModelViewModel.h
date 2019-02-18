//
//  CircleModelViewModel.h
//  HighCopyWeChat
//
//  Created by simple on 2018/10/14.
//  Copyright © 2018年 TestWeChat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CircleModel;

@interface CircleModelViewModel : NSObject

-(NSMutableArray *)lodaData;
-(CGFloat)getHeaderHeight:(id)item;
-(CGFloat)getLikerCellRowHeight:(CircleModel *)item;
-(NSMutableArray *)getCommentsCellRowHeight:(CircleModel *)item;
-(NSInteger)getSectionAllCellCount:(CircleModel *)item;
@end
