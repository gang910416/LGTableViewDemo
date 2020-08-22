//
//  AppDelegate.m
//  LGTestProject
//
//  Created by liugang on 2020/8/20.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabbarViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
      self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
      self.window.backgroundColor = [UIColor whiteColor];
      
      BaseTabbarViewController *root = [[BaseTabbarViewController alloc]init];
      self.window.rootViewController = root;
      
      [self.window makeKeyAndVisible];
    return YES;
}


@end
