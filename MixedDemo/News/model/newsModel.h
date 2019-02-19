//
//  newsModel.h
//  MixedDemo
//
//  Created by simple on 2019/1/20.
//  Copyright © 2019年 MixedDemoTest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WCDB.h"

@interface newsModel : NSObject<WCTTableCoding>

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSArray *picInfo;
@property(nonatomic,copy)NSString *link;
@property(nonatomic,copy)NSString *source;

WCDB_PROPERTY(title)
WCDB_PROPERTY(picInfo)
WCDB_PROPERTY(link)
WCDB_PROPERTY(source)

-(instancetype)initWithItem:(id)item;

@end
