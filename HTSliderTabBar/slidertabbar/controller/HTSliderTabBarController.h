//
//  HTSliderTabBarController.h
//  HTSliderTabBar
//
//  Created by taotao on 15/7/11.
//  Copyright (c) 2015年 taotao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTSliderTabBar.h"
#import <objc/runtime.h>
@class HTSliderBarItem;





@interface HTSliderTabBarController : UIViewController<UIScrollViewDelegate,HTSliderTabBarDelegate>
@property (nonatomic,weak)HTSliderTabBar  *sliderTabBar;
- (void)addSLiderTabBarSubController:(UIViewController*)childController;
@end



@interface UIViewController (HTSliderBarItem)
@property (nonatomic,strong)HTSliderBarItem *sliderBarItem;

@end