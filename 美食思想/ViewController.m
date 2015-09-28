//
//  ViewController.m
//  美食思想
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ViewController.h"
#import "ContentView.h"
#import "Subject.h"
@interface ViewController ()
@property (nonatomic,strong)NSArray *subjectArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ContentView *contentView=[ContentView contentView];
    contentView.subjectArray=[self subjectArray];
    [self.view addSubview:contentView];
}

-(NSArray *)plist
{
    NSString *path=[[NSBundle mainBundle]pathForResource:@"quanquan.plist" ofType:nil];
    NSArray *array=[NSArray arrayWithContentsOfFile:path];
    self.subjectArray=array;
    return _subjectArray;
}

-(NSArray *)subjectArray
{
    if (_subjectArray==nil) {
        
        //读取plist中的数组
        NSArray * array=self.plist[1];
        
        NSMutableArray *objs=[[NSMutableArray alloc]init];
        
        //读取数组中的字典
        for (NSDictionary * dict in array) {
            Subject * subject=[Subject subjectWithDict:dict];
            [objs addObject:subject];
        }
        _subjectArray=objs;
    }
    return _subjectArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
