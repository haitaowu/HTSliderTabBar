//
//  HTSliderTabBarController.m
//  HTSliderTabBar
//
//  Created by taotao on 15/7/11.
//  Copyright (c) 2015年 taotao. All rights reserved.
//

#import "HTSliderTabBarController.h"
#import "UIView+PositionExt.h"
#import "HTSliderBarItem.h"




#define kScrollViewSubCount                     3


@interface HTSliderTabBarController ()
@property (nonatomic,strong)NSMutableArray *subControllers;
@property (nonatomic,weak)UIScrollView  *scrollView;
@property (nonatomic,weak)UIViewController  *currentViewController;
@property (nonatomic,assign) CGFloat lastContentOffsetX;
@property (nonatomic,assign) int currentSliderIndex;

@end

@implementation HTSliderTabBarController
-(HTSliderTabBar *)sliderTabBar
{
    if(_sliderTabBar== nil)
    {
        HTSliderTabBar *oneSliderTabBar = [[HTSliderTabBar alloc] init];
        oneSliderTabBar.y = kScreenSize.height - kSliderTabBarHeight;
        [oneSliderTabBar setDelegate:self];
        [self.view addSubview:oneSliderTabBar];
        _sliderTabBar = oneSliderTabBar;
    }
    return _sliderTabBar;
}
-(NSMutableArray *)subControllers
{
    if(_subControllers== nil)
    {
        _subControllers = [[NSMutableArray alloc] init];
    }
    return _subControllers;
}
#pragma mark - life methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupScrollView];
//    HTLog(@"viewDidLoad");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillLayoutSubviews
{
    if (self.subControllers.count <= 0) {
        return;
    }
    // remove all the subviews of scrollView
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // reset view position of scrollView.subviews
    
    
    if (self.subControllers.count < 3) {
        self.scrollView.contentSize = CGSizeMake(kScreenSize.width * self.subControllers.count,0);
        for (int i = 0 ; i < self.subControllers.count; i ++) {
            UIViewController *controller = self.subControllers[i];
            CGFloat x = kScreenSize.width * i;
            controller.view.x = x;
            [self.scrollView addSubview:controller.view];
        }
    }else{
        self.scrollView.contentSize = CGSizeMake(kScreenSize.width * 3,0);
        for (int i = 0 ; i < 3; i ++) {
            UIViewController *controller = self.subControllers[i];
            CGFloat x = kScreenSize.width * i;
            controller.view.x = x;
            [self.scrollView addSubview:controller.view];
        }
    }
}


#pragma mark -  private methods
- (void)setupScrollView
{
    // initial scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    CGRect frame = {{0,0},kScreenSize};
    scrollView.frame = frame;
    scrollView.height = scrollView.height - kSliderTabBarHeight;
    scrollView.backgroundColor = [UIColor orangeColor];
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(kScreenSize.width * 3,0);
    
    [scrollView setDelegate:self];
    
    [self.view insertSubview:scrollView belowSubview:self.sliderTabBar];
    self.scrollView = scrollView;
}

- (void)resetScrollViewCurrentOrderBySliderIndex:(int)sliderIndex
{
//    int lastPageNumber = self.lastContentOffsetX / kScreenSize.width;
    
    self.currentSliderIndex = sliderIndex;
    if(self.subControllers.count < kScrollViewSubCount)
    {
        self.lastContentOffsetX = self.scrollView.contentOffset.x;
        return;
    }
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (sliderIndex == 0) {
        //first page
        [self.subControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (idx == kScrollViewSubCount) {
                return;
            }
            CGFloat x = idx * kScreenSize.width;
            UIViewController *control = (UIViewController*)obj;
            control.view.x = x;
            [self.scrollView addSubview:control.view];
        }];
        [self.scrollView setContentOffset:CGPointMake(0, 0)];
        HTLog(@"in first  ");
       
    }else if(sliderIndex == (self.subControllers.count - 1)){
        //last page
        if (self.subControllers.count >= kScrollViewSubCount) {
            NSInteger loc = self.subControllers.count - kScrollViewSubCount;
            NSRange range = NSMakeRange(loc, kScrollViewSubCount);
            NSArray *controlSubArray = [self.subControllers subarrayWithRange:range];
            [controlSubArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                CGFloat x = idx * kScreenSize.width;
                UIViewController *control = (UIViewController*)obj;
                control.view.x = x;
                [self.scrollView addSubview:control.view];
            }];
            [self.scrollView setContentOffset:CGPointMake(kScreenSize.width * (kScrollViewSubCount -1 ), 0)];
            HTLog(@"in last  ");
        }else{
            return;
        }
        
    }else{
        // current page in the middle
        if (self.subControllers.count >= kScrollViewSubCount) {
            NSInteger loc = sliderIndex - 1;
            NSRange range = NSMakeRange(loc, kScrollViewSubCount);
            NSArray *controlSubArray = [self.subControllers subarrayWithRange:range];
            [controlSubArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                CGFloat x = idx * kScreenSize.width;
                UIViewController *control = (UIViewController*)obj;
                control.view.x = x;
                [self.scrollView addSubview:control.view];
            }];
            [self.scrollView setContentOffset:CGPointMake(kScreenSize.width, 0)];
            HTLog(@"in middle  ");
            
        }else{
            return;
        }
        
    }
    self.lastContentOffsetX = self.scrollView.contentOffset.x;
    self.currentViewController = self.subControllers [sliderIndex];
}
#pragma mark - HTSliderTabBarDelegate methods
- (void)didSelectedItemAt:(NSInteger)index
{
    int result = (int)index -  self.currentSliderIndex ;
    if (result == 0) {
        return ;
    }
    
    
    if (!self.scrollView.userInteractionEnabled) {
        return;
    }
    
    self.scrollView.userInteractionEnabled = NO;
     HTLog(@"didSelectedItemAt  ");
    
    if (result > 0) {
        //left
        CGFloat leftViewX = self.currentViewController.view.x + kScreenSize.width;
        UIView *forwardView =[self.subControllers[index] view];
        forwardView.x = leftViewX;
        [self.scrollView addSubview:forwardView];
        
        [self.scrollView setContentOffset:CGPointMake(leftViewX, 0) animated:YES];
//        [self.scrollView scrollRectToVisible:forwardView.frame animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self resetScrollViewCurrentOrderBySliderIndex:(int)index];
            self.scrollView.userInteractionEnabled = YES;
        });
    }else{
        //right
        CGFloat rightViewX = self.currentViewController.view.x - kScreenSize.width;
        UIView *forwardView =[self.subControllers[index] view];
        forwardView.x = rightViewX;
        [self.scrollView insertSubview:forwardView aboveSubview:[self.scrollView.subviews firstObject]];
        [self.scrollView setContentOffset:CGPointMake(rightViewX, 0) animated:YES];
//        [self.scrollView scrollRectToVisible:forwardView.frame animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self resetScrollViewCurrentOrderBySliderIndex:(int)index];
            self.scrollView.userInteractionEnabled = YES;
        });
    }
}



#pragma mark - UIScrollViewDelegate methods
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.sliderTabBar.userInteractionEnabled = NO;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (!self.scrollView.userInteractionEnabled) {
        return;
    }
    
    HTLog(@"scrollViewDidEndDecelerating  ");
    
    CGFloat currentContentOffsetX = scrollView.contentOffset.x;
    CGFloat result = currentContentOffsetX - self.lastContentOffsetX;
    //1.count current slider index
    int sliderIndex2 = self.currentSliderIndex + result/kScreenSize.width;
    
    if ((result > 0 ) && (result > kScreenSize.width * 0.5)) {
        HTLog(@"scroll direction is right %f ---%f",result,currentContentOffsetX);
        [self resetScrollViewCurrentOrderBySliderIndex:sliderIndex2];
    }else if((result < 0)&& (result < - kScreenSize.width * 0.5)){
        [self resetScrollViewCurrentOrderBySliderIndex:sliderIndex2];
        HTLog(@"scroll direction is left %f ---,%f",result,currentContentOffsetX);
    }else{
        [self resetScrollViewCurrentOrderBySliderIndex:sliderIndex2];
        HTLog(@"scrollView did not scroll in fact");
    }
    [self.sliderTabBar setItemSelectedAtIndex:sliderIndex2];
}

#pragma mark - override methods
- (void)addSLiderTabBarSubController:(UIViewController*)childController
{
    [self.subControllers addObject:childController];
    //1.
    if (childController.sliderBarItem != nil) {
        [self.sliderTabBar addOneSliderBarItem:childController.sliderBarItem];
    }
    //2.
    if (self.currentViewController == nil) {
        self.currentViewController = childController;
    }
}
















@end


@implementation UIViewController (HTSliderBarItem)

static char *sliderBarItem;
- (void)setSliderBarItem:(HTSliderBarItem *)item
{
    objc_setAssociatedObject(self, sliderBarItem, item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (HTSliderBarItem *)sliderBarItem
{
    return objc_getAssociatedObject(self, sliderBarItem);
}
@end








