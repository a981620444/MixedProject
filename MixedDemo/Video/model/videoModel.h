//
//  videoModel.h
//  MixedDemo
//
//  Created by simple on 2019/2/18.
//  Copyright © 2019年 MixedDemoTest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface videoModel : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *playUrl;
@property(nonatomic,copy)NSString *category;
@property(nonatomic,strong)NSDictionary *cover;

-(instancetype)videoInitWithItem:(id)item;

@end
