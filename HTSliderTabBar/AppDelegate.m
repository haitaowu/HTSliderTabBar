//
//  AppDelegate.m
//  HTSliderTabBar
//
//  Created by taotao on 15/7/11.
//  Copyright (c) 2015年 taotao. All rights reserved.
//

#import "AppDelegate.h"
#import "HTViewController.h"
#import "HTSliderTabBarController.h"
#import "HTSliderBarItem.h"





@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    HTSliderTabBarController *rootViewController = [[HTSliderTabBarController alloc] init];
    //1 addSubChildController
    HTViewController *controller = [[HTViewController alloc] init];
    controller.view.backgroundColor = [UIColor whiteColor];
    controller.sliderBarItem = [HTSliderBarItem sliderBarItemWithTitle:@"home" imageName:@"tabbar_home"];
    controller.sliderBarItem.selectedImageName = @"tabbar_home_selected";
    //2 addSubChildController
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view.backgroundColor = [UIColor greenColor];
    viewController.sliderBarItem = [HTSliderBarItem sliderBarItemWithTitle:@"msg" imageName:@"tabbar_message_center"];
    viewController.sliderBarItem.selectedImageName = @"tabbar_message_center_selected";
    
    //3 addSubChildController
    UIViewController *viewController3 = [[UIViewController alloc] init];
    viewController3.view.backgroundColor = [UIColor blueColor];
    viewController3.sliderBarItem = [HTSliderBarItem sliderBarItemWithTitle:@"profile" imageName:@"tabbar_profile"];
    viewController3.sliderBarItem.selectedImageName = @"tabbar_profile_selected";
    
    [rootViewController addSLiderTabBarSubController:controller];
    [rootViewController addSLiderTabBarSubController:viewController];
    [rootViewController addSLiderTabBarSubController:viewController3];
    
    self.window.rootViewController = rootViewController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
