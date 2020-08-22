//
//  BaseTabbarViewController.m
//  TestForUITableView
//
//  Created by liugang on 2020/8/20.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "BaseTabbarViewController.h"
#import "BaseNavigationViewController.h"
#import "BaseViewController.h"
@interface BaseTabbarViewController ()

@end

@implementation BaseTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTabBar];
}


-(void)createTabBar
{
    NSURL *plistUrl = [[NSBundle mainBundle] URLForResource:@"MainUI" withExtension:@"plist"];
    NSArray *sourceArray = [NSArray arrayWithContentsOfURL:plistUrl];
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (NSDictionary *dic in sourceArray) {
        BaseViewController  *aVC = (BaseViewController *) [[NSClassFromString(dic[@"vcName"]) alloc]init];
        BaseNavigationViewController *nav=[[BaseNavigationViewController alloc]initWithRootViewController:aVC];
        UITabBarItem *tabItem=[[UITabBarItem alloc]initWithTitle:dic[@"title"] image:[[UIImage imageNamed:dic[@"icon"] ] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:dic[@"selectIcon"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        aVC.title = dic[@"title"];
        nav.tabBarItem = tabItem;
        [viewControllers addObject:nav];
    }
    self.viewControllers = viewControllers;
    self.tabBar.tintColor = UIColor.brownColor;
}

- (BOOL)shouldAutorotate
{
    BaseNavigationViewController *nav = (BaseNavigationViewController *)self.selectedViewController;
    if ([nav.visibleViewController isKindOfClass:[NSClassFromString(@"MessageViewController") class]])
    {
        return YES;
    }
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    BaseNavigationViewController *nav = (BaseNavigationViewController *)self.selectedViewController;
    //    topViewController = nav.lastObj
    if ([nav.visibleViewController isKindOfClass:[NSClassFromString(@"MessageViewController") class]])
    {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    BaseNavigationViewController *nav = (BaseNavigationViewController *)self.selectedViewController;
    if ([nav.visibleViewController isKindOfClass:[NSClassFromString(@"MessageViewController") class]])
    {
        return UIInterfaceOrientationLandscapeLeft;
    }
    return UIInterfaceOrientationPortrait;
}


@end
