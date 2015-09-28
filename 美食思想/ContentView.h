//
//  ContentView.h
//  美食思想
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentView : UIView

@property (strong, nonatomic) IBOutlet UITableView *contentTableView;

@property (strong,nonatomic)NSArray *subjectArray;

+(id)contentView;


@end
