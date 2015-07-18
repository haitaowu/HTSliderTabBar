//
//  HTSliderBarItem.m
//  HTSliderTabBar
//
//  Created by taotao on 15/7/11.
//  Copyright (c) 2015年 taotao. All rights reserved.
//

#import "HTSliderBarItem.h"


#define kImagePercent                               0.7



@implementation HTSliderBarItem

#pragma mark - lifecycle Methods 
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        // normal state set
        [self setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    }
    return self;
}
#pragma mark - override Methods
+ (instancetype)sliderBarItemWithTitle:(NSString*)title imageName:(NSString*)imageName
{
    HTSliderBarItem *item = [[self alloc] init];
    // normal state set
    item.imageName = imageName;
    [item setTitle:title forState:UIControlStateNormal];
    //  selected state set
    [item setTitle:title forState:UIControlStateSelected];
    
    return item;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat height = contentRect.size.height * kImagePercent;
    CGFloat width = contentRect.size.width;
    return CGRectMake(0, 0, width, height);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat y = contentRect.size.height * kImagePercent;
    CGFloat width = contentRect.size.width;
    CGFloat height = contentRect.size.height * (1 - kImagePercent);
    return CGRectMake(0, y, width, height);
}
#pragma mark - setter methods 
- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    UIImage *image = [UIImage imageNamed:imageName];
    [self setImage:image forState:UIControlStateNormal];
}
- (void)setSelectedImageName:(NSString *)selectedImageName
{
    _selectedImageName = selectedImageName;
    UIImage *image = [UIImage imageNamed:selectedImageName];
    [self setImage:image forState:UIControlStateSelected];
}

@end
