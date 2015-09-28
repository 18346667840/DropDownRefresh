//
//  HeaderView.h
//  美食思想
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperView.h"


@interface HeaderView : SuperView

-(void)setTitle:(NSString *)title forState:(GPRefreshViewStatus)state;

-(void)stopAnimation;

@end
