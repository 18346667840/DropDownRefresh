//
//  Subject.h
//  美食思想
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Subject : NSObject

@property(nonatomic,copy) NSString * title;
@property(nonatomic,copy) NSString * cardNumber;
@property(nonatomic,copy) NSString * note;
@property(nonatomic,copy) NSString * icon;

+(id)subjectWithDict:(NSDictionary *)dict;
@end
