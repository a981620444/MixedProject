//
//  newsModel.m
//  MixedDemo
//
//  Created by simple on 2019/1/20.
//  Copyright © 2019年 MixedDemoTest. All rights reserved.
//

#import "newsModel.h"
#import "MJExtension.h"
#import "AFNetworking.h"

@implementation newsModel

WCDB_IMPLEMENTATION(newsModel)
WCDB_SYNTHESIZE(newsModel, title)
WCDB_SYNTHESIZE(newsModel, picInfo)
WCDB_SYNTHESIZE(newsModel, link)
WCDB_SYNTHESIZE(newsModel, source)

-(instancetype)initWithItem:(id)item{
    
    return  [[self class] mj_objectWithKeyValues:item];
    
}
@end
