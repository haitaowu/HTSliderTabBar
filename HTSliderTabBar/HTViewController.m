//
//  ViewController.m
//  HTSliderTabBar
//
//  Created by taotao on 15/7/11.
//  Copyright (c) 2015年 taotao. All rights reserved.
//

#import "HTViewController.h"
#import "HTSliderTabBar.h"
#import "HTSliderBarItem.h"





@interface HTViewController ()
@property (nonatomic,weak)CAShapeLayer  *shapeLayer;
@end

@implementation HTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    ///1.uiView
    CGRect frame = CGRectMake(100, 40, 30, 400);
    UIView *showView = [[UIView alloc] initWithFrame:frame];
    showView.backgroundColor = [UIColor redColor];
    [self.view addSubview:showView];
    
    CAShapeLayer *barShape = [CAShapeLayer layer];
    CGRect layerFrame = CGRectMake(0, 0, 30, 400);
//    barShape.backgroundColor = [UIColor orangeColor].CGColor;
    barShape.frame = layerFrame;
    barShape.lineCap      = kCALineCapButt;
//    barShape.strokeEnd    = 0.0;
    barShape.fillColor = [UIColor greenColor].CGColor;
    barShape.strokeColor = [UIColor blueColor].CGColor;
    barShape.lineWidth = 30;
    
    self.shapeLayer = barShape;
//    [self.view.layer addSublayer:barShape];
    
    [showView.layer addSublayer:barShape];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    HTLog(@"hello baby did you click on me ?");
    [self drawBarChart];
}

- (void)drawBarChart
{
    
    //2. initial UIBezierPath
    UIBezierPath *barBezierPath = [UIBezierPath bezierPath];
    barBezierPath.lineWidth = 1.0f;
    barBezierPath.lineCapStyle = kCGLineCapSquare;
    
    [barBezierPath moveToPoint:CGPointMake(15, 50)];
    [barBezierPath addLineToPoint:CGPointMake(15, 200)];
    
//    self.shapeLayer.path = barBezierPath.CGPath;
    
//    //3.animation
    CABasicAnimation *pathcAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathcAnimation.fromValue = @0.0f;
    pathcAnimation.toValue = @1.0f;
    
    pathcAnimation.duration = 2.5f;
    pathcAnimation.autoreverses = NO;
    pathcAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.shapeLayer addAnimation:pathcAnimation forKey:@"strokeEndAnimation"];
    
    self.shapeLayer.path = barBezierPath.CGPath;
}

- (void)test3
{
    CGFloat startPosY = (1 - 0.2) * self.view.frame.size.height;
    
    UIBezierPath *progressline = [UIBezierPath bezierPath];
    
    [progressline moveToPoint:CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height* 0.5)];
    [progressline addLineToPoint:CGPointMake(self.view.frame.size.width / 2.0, startPosY)];
    
    [progressline setLineWidth:1.0];
    [progressline setLineCapStyle:kCGLineCapSquare];
    
    
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = @0.0f;
    pathAnimation.toValue = @1.0f;
    [self.shapeLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
    self.shapeLayer.strokeEnd = 1.0;
    
    self.shapeLayer.path = progressline.CGPath;
}

- (void)testColor
{
    UIBezierPath * circle = [UIBezierPath bezierPathWithOvalInRect:self.view.bounds];
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = circle.CGPath;
    shapeLayer.strokeColor =[UIColor blueColor].CGColor;
    [shapeLayer setLineWidth:15.0];
    
    [self.view.layer addSublayer:shapeLayer];
    
    CABasicAnimation *strokeAnim = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
    strokeAnim.fromValue         = (id) [UIColor redColor].CGColor;
    strokeAnim.toValue           = (id) [UIColor greenColor].CGColor;
    strokeAnim.duration          = 3.0;
    strokeAnim.repeatCount       = 0;
    strokeAnim.autoreverses      = YES;
    [shapeLayer addAnimation:strokeAnim forKey:@"animateStrokeColor"];

}











@end
