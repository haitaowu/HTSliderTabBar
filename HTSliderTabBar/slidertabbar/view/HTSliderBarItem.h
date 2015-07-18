//
//  HTSliderBarItem.h
//  HTSliderTabBar
//
//  Created by taotao on 15/7/11.
//  Copyright (c) 2015年 taotao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTSliderBarItem : UIButton
+ (instancetype)sliderBarItemWithTitle:(NSString*)title imageName:(NSString*)imageName;
@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,copy) NSString *selectedImageName;
@end
