//
//  SuperView.m
//  美食思想
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SuperView.h"

@interface SuperView ()


@end

@implementation SuperView

+ (id)initView
{
    return [[[self class] alloc] init];
}
//-(void)stopAnimation
//{
//    [self clear];
//}
//-(void)clear
//{
//    NSLog(@"=====clear=======");
//    [self.alertButtonView removeFromSuperview];
//    [self.loadingView removeFromSuperview];
//    self.status=GPRefreshViewStatusDragging;
//}
-(void)setTitle:(NSString *)title forState:(GPRefreshViewStatus)state
{
    switch (state) {
        case GPRefreshViewStatusBeginDrag:
            _beginDragText = title;
            break;
        case GPRefreshViewStatusDragging:
            _draggingText = title;
            break;
        case GPRefreshViewStatusLoading:
            _loadingText = title;
            break;
        default:
            break;
    }
}
- (NSString *)titleWithStatus:(GPRefreshViewStatus)status
{
    NSString * title =nil;
    
    switch (status) {
            
        case GPRefreshViewStatusBeginDrag:
            title = _beginDragText?_beginDragText:@"拖拽";
            break;
        case GPRefreshViewStatusDragging:
            title = _draggingText?_draggingText:@"松开";
            break;
        case GPRefreshViewStatusLoading:
            title = _loadingText?_loadingText:@"加载";
            break;
            
        default:
            break;
    }
    
    return title;
}
- (UIButton *)alertButtonView
{
    if (_alertButtonView == nil)
    {
        //1.创建对象
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //2.建立父子关系
        [self addSubview:btn];
        //3.Frame
        btn.frame = self.bounds;
        //4.保存成员变量值
        _alertButtonView = btn;
        //5.其他属性设置
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    }
    return _alertButtonView;
}
- (UIView *)loadingView
{
    if (_loadingView == nil)
    {
        //1.
        UIView * loadingView = [UIView new];//[[UIView alloc] init];
        //2.
        [self addSubview:loadingView];
        _loadingView = loadingView;
        loadingView.frame = self.bounds;
        
        //创建子控件
        UILabel * labelTitle = [UILabel new];
        [loadingView addSubview:labelTitle];
        labelTitle.text = [self titleWithStatus:GPRefreshViewStatusLoading];
        labelTitle.frame = loadingView.bounds;
        labelTitle.textColor = [UIColor blackColor];
        labelTitle.textAlignment = NSTextAlignmentCenter;
        
        UIActivityIndicatorView * activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView addSubview:activity];
        activity.frame = CGRectMake(50, 20, 40, 40);
        [activity startAnimating];
    }
    return _loadingView;
}

@end
