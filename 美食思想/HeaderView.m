
//
//  HeaderView.m
//  美食思想
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView ()

//@property(nonatomic,weak)UIButton * alertButtonView;
//@property(nonatomic,weak)UIView * loadingView;

@end

@implementation HeaderView
//{
//    NSString * _beginDragText;
//    NSString * _draggingText;
//    NSString * _loadingText;
//}
+ (id)initView
{
    return [super initView];
}
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    //1.添加到那里?
    UITableView * tableView = (UITableView *)newSuperview;
    
    //2.添加到什么位置?
    CGFloat selfX = 0;
    //CGFloat selfY = 0;
    CGFloat selfW = tableView.frame.size.width;
    CGFloat selfH = 60;
    
    self.frame = CGRectMake(selfX,-selfH, selfW, selfH);
    self.backgroundColor = [UIColor colorWithRed:1.000 green:0.629 blue:0.793 alpha:1.000];
}
- (void)didMoveToSuperview
{
    self.scrollView = self.superview;
    NSLog(@"=====didMoveToSuperview=======");
}
-(void)stopAnimation
{
    [self clear];
}
-(void)clear
{
    NSLog(@"=====clear=======");
    [self.alertButtonView removeFromSuperview];
    [self.loadingView removeFromSuperview];
    self.status=GPRefreshViewStatusDragging;
}

-(void)setScrollView:(UIScrollView *)scrollView
{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    //保存
    _scrollView=scrollView;
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(self.status == GPRefreshViewStatusLoading) return;
    if (self.scrollView.isDragging) {
        CGFloat footerViewHeight = self.frame.size.height;
        
        if (_scrollView.contentOffset.y <0&&_scrollView.contentOffset.y>-footerViewHeight)
        {
            [self setStatus:GPRefreshViewStatusBeginDrag];
        }
        else if(_scrollView.contentOffset.y <-footerViewHeight)
        {
            [self setStatus:GPRefreshViewStatusDragging];
        }
    }
    else
    {
        if (self.status == GPRefreshViewStatusDragging)
        {
            [self setStatus:GPRefreshViewStatusLoading];
            _scrollView.contentInset = UIEdgeInsetsMake( 100, 0,0, 0);
            [self.delegate headerViewStatus:self status:GPRefreshViewStatusLoading];
        }
    }
}
- (void)setStatus:(GPRefreshViewStatus)status
{
    _status = status;
    
    switch (status) {
            
        case GPRefreshViewStatusBeginDrag:
            [self.alertButtonView setTitle:[super titleWithStatus:status] forState:UIControlStateNormal];
            break;
        case GPRefreshViewStatusDragging:
            [self.alertButtonView setTitle:[self titleWithStatus:status] forState:UIControlStateNormal];
            break;
        case GPRefreshViewStatusLoading:
            self.alertButtonView.hidden = YES;
            self.loadingView;
            break;
        default:
            break;
    }
}
-(void)setTitle:(NSString *)title forState:(GPRefreshViewStatus)state
{
//    switch (state) {
//        case GPRefreshViewStatusBeginDrag:
//            _beginDragText = title;
//            break;
//        case GPRefreshViewStatusDragging:
//            _draggingText = title;
//            break;
//        case GPRefreshViewStatusLoading:
//            _loadingText = title;
//            break;
//        default:
//            break;
//    }
    [super setTitle:title forState:state];
}

//- (NSString *)titleWithStatus:(GPRefreshViewStatus)status
//{
//    NSString * title =nil;
//    
//    switch (status) {
//            
//        case GPRefreshViewStatusBeginDrag:
//            title = _beginDragText?_beginDragText:@"拖拽";
//            break;
//        case GPRefreshViewStatusDragging:
//            title = _draggingText?_draggingText:@"松开";
//            break;
//        case GPRefreshViewStatusLoading:
//            title = _loadingText?_loadingText:@"加载";
//            break;
//            
//        default:
//            break;
//    }
//    
//    return title;
//}
//- (UIButton *)alertButtonView
//{
//    if (_alertButtonView == nil)
//    {
//        //1.创建对象
//        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        //2.建立父子关系
//        [self addSubview:btn];
//        //3.Frame
//        btn.frame = self.bounds;
//        //4.保存成员变量值
//        _alertButtonView = btn;
//        //5.其他属性设置
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
//    }
//    return _alertButtonView;
//}
//- (UIView *)loadingView
//{
//    if (_loadingView == nil)
//    {
//        //1.
//        UIView * loadingView = [UIView new];//[[UIView alloc] init];
//        //2.
//        [self addSubview:loadingView];
//        _loadingView = loadingView;
//        loadingView.frame = self.bounds;
//        
//        //创建子控件
//        UILabel * labelTitle = [UILabel new];
//        [loadingView addSubview:labelTitle];
//        labelTitle.text = [self titleWithStatus:GPRefreshViewStatusLoading];
//        labelTitle.frame = loadingView.bounds;
//        labelTitle.textColor = [UIColor blackColor];
//        labelTitle.textAlignment = NSTextAlignmentCenter;
//        
//        UIActivityIndicatorView * activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        [loadingView addSubview:activity];
//        activity.frame = CGRectMake(50, 20, 40, 40);
//        [activity startAnimating];
//    }
//    return _loadingView;
//}

@end
