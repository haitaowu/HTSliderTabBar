//
//  HTSliderTabBar.m
//  HTSliderTabBar
//
//  Created by taotao on 15/7/11.
//  Copyright (c) 2015年 taotao. All rights reserved.
//

#import "HTSliderTabBar.h"
#import "HTSliderBarItem.h"

#define kSliderBarItemPercent                       0.9
#define kSliderSpriteWidthPercent                   0.6

@interface HTSliderTabBar()
@property (nonatomic,strong)NSMutableArray *items;
@property (nonatomic,weak)UIView  *sliderSprite;
@property (nonatomic,weak)HTSliderBarItem  *selectedItem;

@end



@implementation HTSliderTabBar
#pragma mark -  LazyInit  Methods
-(NSMutableArray *)items
{
    if(_items== nil)
    {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}
#pragma mark - override methods
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self != nil)
    {
        CGRect sliderFrame = CGRectMake(0, 0, kScreenSize.width, kSliderTabBarHeight);
        self.frame = sliderFrame;
        self.backgroundColor = [UIColor lightGrayColor];
        //slider sprite
        UIView *sliderSprite = [[UIView alloc] init];
        sliderSprite.width = kScreenSize.width;
        sliderSprite.height = self.height * (1 - kSliderBarItemPercent);
        sliderSprite.y = self.height * kSliderBarItemPercent;
        sliderSprite.backgroundColor = [UIColor blueColor];
        [self addSubview:sliderSprite];
        self.sliderSprite = sliderSprite;
    }
    return self;
}
- (void)addOneSliderBarItem:(HTSliderBarItem*)item
{
    [self.items addObject:item];
    [self addSubview:item];
}
- (void)layoutSubviews
{
    if (self.items.count == 0) {
        return;
    }
    CGFloat itemWidth = kScreenSize.width / self.items.count;
    //2. set sliderSprite position
    self.sliderSprite.width = itemWidth * kSliderSpriteWidthPercent;
    CGFloat spriteY = self.height * kSliderBarItemPercent + self.sliderSprite.height * 0.5;
    if (self.selectedItem == nil) {
        HTSliderBarItem *defaultItem = self.items[0];
        CGPoint center = CGPointMake(defaultItem.center.x, spriteY);
        self.sliderSprite.center = center;
        self.selectedItem = defaultItem;
        defaultItem.selected = YES;
    }else{
        CGPoint center = CGPointMake(self.selectedItem.center.x, spriteY);
        self.sliderSprite.center = center;
    }
    
    [self.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[HTSliderBarItem class]]) {
            HTSliderBarItem *item = (HTSliderBarItem*)obj;
            item.tag = idx;
            CGFloat x = idx * itemWidth;
            item.frame = CGRectMake(x, 0, itemWidth, self.height * kSliderBarItemPercent);
            [item addTarget:self action:@selector(clickOneItem:) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }];
}

- (void)setItemSelectedAtIndex:(int)index
{
    self.selectedItem.selected = NO;
    HTSliderBarItem *targetItem = self.items[index];
    targetItem.selected = YES;
    self.selectedItem = targetItem;
    [self moveSliderSpriteTo:targetItem];
}
#pragma mark -  private methods
- (void)clickOneItem:(HTSliderBarItem*)sender
{
    
    //防止用户快速点击button
    if (!self.userInteractionEnabled) {
        return;
    }
    self.userInteractionEnabled = NO;
    if([self.delegate respondsToSelector:@selector(didSelectedItemAt:)])
    {
        [self.delegate didSelectedItemAt:sender.tag];
    }
    
    // selected state switch
    self.selectedItem.selected = NO;
    sender.selected = YES;
    self.selectedItem = sender;
    
    [self moveSliderSpriteTo:sender];
    
}
//移动sliderTabBar下面的小滑块
- (void)moveSliderSpriteTo:(HTSliderBarItem*)sender
{
    [UIView animateWithDuration:0.6 animations:^{
        CGFloat y = self.height * kSliderBarItemPercent + self.sliderSprite.height * 0.5;
        CGPoint center = CGPointMake(sender.center.x,y);
        self.sliderSprite.center = center;
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
}








@end
