//
//  BaseNavigationViewController.m
//  TestForUITableView
//
//  Created by liugang on 2020/8/20.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "BaseNavigationViewController.h"
#import "BaseViewController.h"
#import "UINavigationBar+alpha.h"
#import "UIBarButtonItem+addition.h"
@interface BaseNavigationViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,strong) UIPanGestureRecognizer *panGesture;
@end

@implementation BaseNavigationViewController


- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        NSDictionary *attributeDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17.0],NSFontAttributeName,LGTintColor,NSForegroundColorAttributeName,nil];
            self.navigationBar.titleTextAttributes = attributeDic;
            self.navigationBar.translucent = NO;
            [UINavigationBar appearance].barTintColor = LGThemeColor;
        [self.navigationBar setTintColor:LGTintColor];
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    WMLog(@"------>%@",otherGestureRecognizer.delegate);
       if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"UITableViewCellContentView")]){
            return YES;
        }else if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"UITableViewWrapperView")]){
            return YES;
        }
    return NO;
}
//  防止导航控制器只有一个rootViewcontroller时触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
   
    //解决与左滑手势冲突
    CGPoint translation = [self.panGesture translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    if (self.viewControllers.count > 1) {
        BOOL shouldBeginGesture = NO;
        
        if ([self.topViewController isKindOfClass:[BaseViewController class]]) {
            BaseViewController *currentVC = (BaseViewController *)self.topViewController;
            
            if (currentVC.isHideBackItem == YES) {
                return NO;
            }else {
                if ([self.topViewController respondsToSelector:@selector(gestureRecognizerShouldBegin)]) {
                    shouldBeginGesture = [currentVC gestureRecognizerShouldBegin];
                    return shouldBeginGesture;
                }
            }
        }else{
            return YES;
        }
        
        
    }
    return self.childViewControllers.count == 1 ? NO : YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //处理全屏返回
       UIGestureRecognizer *systemGes = self.interactivePopGestureRecognizer;
       id target =  systemGes.delegate;
       self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")];
       [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.panGesture];
       self.panGesture.delegate = self;

       systemGes.enabled = NO;
    // Do any additional setup after loading the view.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;//处理隐藏tabbar
        if ([viewController isKindOfClass:[BaseViewController class]]) {
            BaseViewController *vc = (BaseViewController *)viewController;
            if (vc.isHideBackItem == YES) {
                vc.navigationItem.hidesBackButton = YES;
            }else{
                //给push的每个VC加返回按钮
                vc.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigator_btn_back" highIcon:@"" target:self action:@selector(back:)];
                
            }
        }else{
            viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigator_btn_back" highIcon:@"" target:self action:@selector(back:)];
        }
        
    }else{
        
    }
    [super pushViewController:viewController animated:animated];

    
    // 修正push控制器tabbar上移问题
    if (@available(iOS 11.0, *)){
        // 修改tabBra的frame
        CGRect frame = self.tabBarController.tabBar.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        self.tabBarController.tabBar.frame = frame;
    }
}
-(void)back:(UIBarButtonItem *)sender{
    [self.view endEditing:YES];
    UIViewController * currentVC = self.topViewController;
    if (currentVC.popBlock) {
        currentVC.popBlock(sender);
    }else{
        [self popViewControllerAnimated:YES];
    }
}


// 是否支持自动转屏
- (BOOL)shouldAutorotate
{
    return [self.visibleViewController shouldAutorotate];
}
// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.visibleViewController supportedInterfaceOrientations];
}

// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.visibleViewController preferredInterfaceOrientationForPresentation];
}


@end
