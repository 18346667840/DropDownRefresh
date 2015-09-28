//
//  Subject.m
//  美食思想
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "Subject.h"

@implementation Subject

+(id)subjectWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [self init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
