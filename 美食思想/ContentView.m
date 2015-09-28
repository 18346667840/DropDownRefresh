//
//  ContentView.m
//  美食思想
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//
/*
 重构代码的原则：
 1、要确定，哪一部分逻辑是不会发生变化的，对其进行封装
 2、重构代码，要小步进行操作，尽可能一步一测，不要因为代码的迁移 引入新的bug
 3、找出代码中，不合理的地方进行逐步的修正，也要保证一个功能一个功能的测试修改
 4、作为组建封装的视图，要站在使用者的角度进行思考，不要把复杂的实现逻辑抛给使用者
 */
#import "ContentView.h"
#import "Subject.h"
#import "SubjectCell.h"
#import "Refrsh.h"
#import "SuperView.h"
@interface ContentView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)FootView * footerView;
@property(nonatomic,weak)HeaderView * headerView;
@end

@implementation ContentView

+(id)contentView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    CGFloat selfX=0;
    CGFloat selfY=0;
    CGFloat selfW=newSuperview.bounds.size.width;
    CGFloat selfH=newSuperview.bounds.size.height;
    self.frame=CGRectMake(selfX, selfY, selfW, selfH);
    self.contentTableView.frame=self.bounds;
}
//当self对象是从xib文件加载而来的时候，会调用这个这个方法，
-(void)awakeFromNib
{
    
    //添加子控件
    FootView * footerView = [FootView initView];
    _footerView = footerView;
    [self.contentTableView addSubview:footerView];
    footerView.delegate=self;
    
    [footerView setTitle:@"拖拽加载更多" forState:GPRefreshViewStatusLoading];
    [footerView setTitle:@"松开加载更多" forState:GPRefreshViewStatusDragging];
    [footerView setTitle:@"正在加载中" forState:GPRefreshViewStatusLoading];
    
    HeaderView * headerView=[HeaderView initView];
    _headerView=headerView;
    [self.contentTableView addSubview:footerView];
    [self.contentTableView addSubview:headerView];
    headerView.delegate=self;
    
    [headerView setTitle:@"下拉刷新" forState:GPRefreshViewStatusLoading];
    [headerView setTitle:@"松开刷新" forState:GPRefreshViewStatusDragging];
    [headerView setTitle:@"正在刷新中" forState:GPRefreshViewStatusLoading];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubjectCell *cell;
    [tableView registerNib:[UINib nibWithNibName:@"SubjectCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    Subject * subject=_subjectArray[indexPath.row];
    cell.titleLabel.text=subject.title;

    UIImageView *view=[[UIImageView alloc]initWithFrame:CGRectMake(205, 30, 80, 80)];
    [cell.contentView addSubview:view];
    view.image=[UIImage imageNamed:subject.icon];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.contentTableView.scrollEnabled=YES;
    return _subjectArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self.footerView stopAnimation];
//    [self.headerView stopAnimation];
}
-(void)footViewStatus:(FootView *)footView status:(GPRefreshViewStatus)status
{
    NSLog(@"开始加载");
    [self performSelector:@selector(sendRequst) withObject:nil afterDelay:5];
}
-(void)headerViewStatus:(HeaderView *)footView status:(GPRefreshViewStatus)status
{
    NSLog(@"开始刷新");
    [self performSelector:@selector(sendRequst2) withObject:nil afterDelay:3];
}

-(void)sendRequst2
{
    NSLog(@"网络结束");
    self.contentTableView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    [_headerView stopAnimation];
}
-(void)sendRequst
{
    NSLog(@"网络结束");
    self.contentTableView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    [_footerView stopAnimation];
}
@end
