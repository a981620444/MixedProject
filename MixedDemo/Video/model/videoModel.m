//
//  videoModel.m
//  MixedDemo
//
//  Created by simple on 2019/2/18.
//  Copyright © 2019年 MixedDemoTest. All rights reserved.
//

#import "videoModel.h"
#import "MJExtension.h"

@implementation videoModel

-(instancetype)videoInitWithItem:(id)item{
    
    return  [[self class] mj_objectWithKeyValues:item];
    
}

@end
