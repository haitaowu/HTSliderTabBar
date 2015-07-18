//
//  HTSliderTabBar.h
//  HTSliderTabBar
//
//  Created by taotao on 15/7/11.
//  Copyright (c) 2015年 taotao. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HTSliderBarItem;



@protocol HTSliderTabBarDelegate <NSObject>
- (void)didSelectedItemAt:(NSInteger)index;

@end


#define kSliderTabBarHeight                         50
#define kScreenSize                                 [UIScreen mainScreen].bounds.size


@interface HTSliderTabBar : UIView
@property (nonatomic,weak)id<HTSliderTabBarDelegate>  delegate;
- (void)setItemSelectedAtIndex:(int)index;
- (void)addOneSliderBarItem:(HTSliderBarItem*)item;
@end
