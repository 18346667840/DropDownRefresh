//
//  SuperView.h
//  美食思想
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SuperView;
enum GPRefreshViewStatus
{
    GPRefreshViewStatusBeginDrag, //拖拽读取更多
    GPRefreshViewStatusDragging,  //松开读取更多
    GPRefreshViewStatusLoading,   //正在读取
    
};
typedef enum GPRefreshViewStatus GPRefreshViewStatus;

@protocol GPRefreshViewDelegate <NSObject>

-(void)footViewStatus:(SuperView *)footView status:(GPRefreshViewStatus)status;
-(void)headerViewStatus:(SuperView *)footView status:(GPRefreshViewStatus)status;

@end

@interface SuperView : UIView
{
    GPRefreshViewStatus _status;
    UIScrollView *_scrollView;
    NSString * _beginDragText;
    NSString * _draggingText;
    NSString * _loadingText;
    //UIButton *_alertButtonView;
    
}
@property(nonatomic,weak)id<GPRefreshViewDelegate> delegate;

@property(nonatomic,strong)UIScrollView * scrollView;

@property(nonatomic,assign)GPRefreshViewStatus status;

@property(nonatomic,weak)UIButton * alertButtonView;

@property(nonatomic,weak)UIView * loadingView;

+ (id)initView;

-(void)stopAnimation;

- (NSString *)titleWithStatus:(GPRefreshViewStatus)status;

-(void)setTitle:(NSString *)title forState:(GPRefreshViewStatus)state;

- (UIButton *)alertButtonView;

- (UIView *)loadingView;
@end
