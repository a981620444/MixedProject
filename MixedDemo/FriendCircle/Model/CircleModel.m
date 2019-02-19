//
//  CircleModel.m
//  HighCopyWeChat
//
//  Created by simple on 2018/10/14.
//  Copyright © 2018年 TestWeChat. All rights reserved.
//

#import "CircleModel.h"
#import "MJExtension.h"

@implementation CircleModel

-(instancetype)initWithItem:(id)item
{
    return [[self class] mj_objectWithKeyValues:item];
}


@end
