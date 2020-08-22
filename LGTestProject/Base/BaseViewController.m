//
//  BaseViewController.m
//  ConvenientStore
//
//  Created by LHJ on 2017/12/15.
//  Copyright © 2017年 LHJ. All rights reserved.
//

#import "BaseViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "JXTAlertView.h"
#import "JXTAlertController.h"


@interface BaseViewController ()

@property(nonatomic, assign) int moveValueForKeyboard;

@property(nonatomic, assign) int keyboardHeight;

@end

@implementation BaseViewController

///右滑返回功能，默认开启（YES）
- (BOOL)gestureRecognizerShouldBegin{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:RGBColor(246, 246, 246)];
    // Do any additional setup after loading the view.
    if(_isNeedHandleKeyboard == YES){
        [self addDoneKeyboardViewToInputView:self.view];
    }
    
    if (@available(ios 11.0,*)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }else{
        if([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)])
        {
            self.automaticallyAdjustsScrollViewInsets=NO;
        }
    }
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(_isNeedHandleKeyboard == YES){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
}
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if(_isNeedHandleKeyboard == YES){
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil]; // 监听键盘尺寸的变化
    }
}

-(void) leftNavBarBtnClick:(UIBarButtonItem *)sender{
    
}
-(void) rightNavBarBtnClick:(UIBarButtonItem *)sender{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ---------------------- 创建导航栏按钮 -------------------
- (void) createNavgationBarWith:(NSString *)imageName isLeftBarButton:(BOOL)isLeftBarButton{
    if (isLeftBarButton) {
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imageName] style:UIBarButtonItemStylePlain target:self action:@selector(leftNavBarBtnClick:)];
        self.navigationItem.leftBarButtonItem = leftItem;
        
    }else{
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imageName] style:UIBarButtonItemStylePlain target:self action:@selector(rightNavBarBtnClick:)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}
#pragma mark ==============================================
#pragma mark --------------------------- 键盘处理 -----------------------------
- (void) handleKeyboardShow:(NSNotification*) notification
{
    if(_moveValueForKeyboard > 0){ // 键盘已经处理过，避免在键盘输入的时候再点击了其他的输入框
        return;
    }
    
    CGRect keyboardFrame = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    const float duration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    const UIViewAnimationOptions options = [[[notification userInfo] valueForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    UIView *viewFirst = [[self class] getFirstResponder:self.view];
    if(viewFirst != nil){
        
        CGPoint pointView = [viewFirst convertPoint:self.view.bounds.origin toView:self.view];
        pointView.y += CGRectGetHeight(viewFirst.frame);
        _keyboardHeight = CGRectGetHeight(keyboardFrame);
        int originYForKeyboard = CGRectGetMaxY(self.view.frame) - _keyboardHeight;
        
        if(pointView.y >= originYForKeyboard){
            // 输入框被键盘遮挡
            _moveValueForKeyboard = pointView.y - originYForKeyboard;
            __block CGRect frame = self.view.frame;
            frame.origin.y -= _moveValueForKeyboard;
            
            [UIView animateWithDuration:duration delay:0 options:options animations:^{
                self.view.frame = frame;
            } completion:nil];
        } else {
            _moveValueForKeyboard = 0;
        }
    }
}
- (void) handleKeyboardHide:(NSNotification*)notification
{
    if(_moveValueForKeyboard > 0){
        const float duration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
        const UIViewAnimationOptions options = [[[notification userInfo] valueForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
        
        __block CGRect frame = self.view.frame;
        frame.origin.y += _moveValueForKeyboard;
        _moveValueForKeyboard = 0;
        
        [UIView animateWithDuration:duration delay:0 options:options animations:^{
            self.view.frame = frame;
        } completion:nil];
    }
}
- (void) handleKeyboardFrameChange:(NSNotification*)notification
{
    /* 在这里处理中文键盘的高度变化问题，在第一次弹出键盘之后，键盘上随后会展现中文的智能检测栏，导致键盘的高度会变高，而在UIKeyboardWillShowNotification得到的高度缺不包含这个监测栏的高度，从而输入框位置会被键盘遮挡。所以需要在这里监听键盘尺寸的变化，然后再计算尺寸变化值并修改输入框的位置。*/
    CGRect keyboardFrame = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if(_moveValueForKeyboard > 0){ // 需要处理中文键盘的尺寸变化问题
        int valueChange = CGRectGetHeight(keyboardFrame) - _keyboardHeight;
        if(valueChange != 0){
            const float duration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
            const UIViewAnimationOptions options = [[[notification userInfo] valueForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
            __block CGRect frame = self.view.frame;
            frame.origin.y -= valueChange;
            _moveValueForKeyboard += valueChange;
            _keyboardHeight = CGRectGetHeight(keyboardFrame);
            [UIView animateWithDuration:duration delay:0 options:options animations:^{
                self.view.frame = frame;
            } completion:nil];
        }
        
    }
}
+ (UIView*) getFirstResponder:(UIView*)superView
{
    if(superView.isFirstResponder == YES){
        return superView;
    }
    
    for(UIView *viewChild in superView.subviews){
        if([viewChild isFirstResponder] == YES){
            return viewChild;
        }
    }
    // 再搜索下一层Subview
    for(UIView *viewChild in superView.subviews){
        UIView *viewResult = [[self class] getFirstResponder:viewChild];
        if(viewResult != nil){
            return viewResult;
        }
    }
    return nil;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
    [self closeKeyboard];
}

/** 创建键盘关闭的View */
+ (UIView*) getKeyboardHideViewWithTarget:(id)target withSelector:(SEL)selector
{
    UIView *viewResult = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen.bounds), 40)];
    [viewResult setBackgroundColor:RGBColor(250, 250, 250)];
    
    int height = CGRectGetHeight(viewResult.frame);
    int width = 80;
    int x = CGRectGetMaxX(viewResult.frame) - width;
    int y = 0;
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnDone setTitle:@"完成" forState:UIControlStateNormal];
    [btnDone.titleLabel setFont:Font_Bold(16.0f)];
    [btnDone setFrame:CGRectMake(x, y, width, height)];
    [btnDone addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [viewResult addSubview:btnDone];
    
    return viewResult;
}
/** 给所有输入框的键盘都添加关闭 */
- (void) addDoneKeyboardViewToInputView:(UIView*) superView
{
    //这个方法可能是有效率问题，因为需要遍历整个ViewController的view，暂时还找不到更好的方法
    for(UIView *viewChlid in [superView subviews]){
        if([viewChlid isKindOfClass:[UITextField class]] == YES){
            if([viewChlid inputAccessoryView] == nil){
                UIView *viewDone = [[self class] getKeyboardHideViewWithTarget:self withSelector:@selector(closeKeyboard)];
                [((UITextField*)viewChlid) setInputAccessoryView:viewDone];
            }
            
        } else if([viewChlid isKindOfClass:[UITextView class]] == YES){
            if([viewChlid inputAccessoryView] == nil){
                UIView *viewDone = [[self class] getKeyboardHideViewWithTarget:self withSelector:@selector(closeKeyboard)];
                [((UITextView*)viewChlid) setInputAccessoryView:viewDone];
            }
        } else {
            [self addDoneKeyboardViewToInputView:viewChlid];
        }
    }
}
/** 关闭键盘 */
- (void) closeKeyboard
{
    [self.view endEditing:YES];
}

#pragma mark ==============================================
#pragma mark --------------------------- 提示框 弹窗 相关处理 -----------------

- (void)showHUDToViewMessage:(NSString *)msg{
    if (!self.hud) {
        self.hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.mode = MBProgressHUDModeText;
        if (msg==nil||[msg isEqualToString:@""]) {
            
        }else{
            self.hud.label.text= msg;
        }
    }
}
- (void)showHUDToWindowMessage:(NSString *)msg{
    if (!self.hud) {
        
        self.hud=[MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        if (msg==nil||[msg isEqualToString:@""]) {
            
        }else{
            self.hud.label.text = msg;
        }
    }
}

- (void)removeHUD{
    if (self.hud) {
        [self.hud removeFromSuperview];
        self.hud=nil;
    }
}

// 常规 两个按钮的弹窗
- (void)showAlertWithBtn:(NSString *)title message:(NSString *)message cancelBtnStr:(NSString *)cancelBtnStr otherBtnStr:(NSString *)otherBtnStr alertBtnBlock:(AlertClickBlock)alertBtnBlock{
    
    jxt_showAlertTwoButton(title, message, cancelBtnStr, ^(NSInteger buttonIndex) {
        alertBtnBlock(buttonIndex);
    }, otherBtnStr, ^(NSInteger buttonIndex) {
        alertBtnBlock(buttonIndex);
    });
}

- (void)showAlertWithTitle:(NSString *)title{
    jxt_showAlertTitle(@"简易调试使用alert，单按钮，标题默认为“确定”");
}

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle btnTitleArray:(NSArray *)btnTitlearr alertBtnBlock:(AlertClickBlock)alertBtnBlock{
    [JXTAlertView showAlertViewWithTitle:title message:message cancelButtonTitle:cancelButtonTitle buttonIndexBlock:^(NSInteger buttonIndex) {
        alertBtnBlock(buttonIndex);
    } otherButtonTitles:btnTitlearr];
}

- (void)showAlertWithTitleNoBtn:(NSString *)title message:(NSString *)message duration:(NSTimeInterval)duration{
    [JXTAlertView showToastViewWithTitle:title message:message duration:duration dismissCompletion:^(NSInteger buttonIndex) {
        NSLog(@"关闭");
    }];
}

- (void)showAlertWithLoadingWithTitle:(NSString *)title message:(NSString *)message{
    jxt_showLoadingHUDTitleMessage(title, message);
}

- (void)showProgressHUDTitle:(NSString *)title message:(NSString *)message{
    
    jxt_showProgressHUDTitleMessage(title,message);
    __block float count = 0;
    [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        count += 0.05;
        jxt_setHUDProgress(count);
        if (count > 1) {
            [timer invalidate];
            jxt_setHUDSuccessTitle(@"加载成功！");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                jxt_dismissHUD();
            });
        }
    }];
}


-(void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle btnTitleArray:(NSArray *)btnTitleArray alertBtnTitleBlock:(AlertBtnTitleClickBlock)alertBtnTitleBlock {
    
    [self jxt_showActionSheetWithTitle:title message:message appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        
        alertMaker.addActionCancelTitle(cancelTitle);
        for (NSString *title in btnTitleArray) {
            alertMaker.addActionDefaultTitle(title);
            //addActionDestructiveTitle 添加特殊颜色的按钮
        }
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        
        alertBtnTitleBlock(action.title);
    }];
}

-(void)showAlertInputViewWithTitle:(NSString *)title message:(NSString *)message inputViewPavarTitleArray:(NSArray *)inputTitleArray alertBtnBlock:(AlertClickBlock)alertBtnBlock alertBtnTitleBlock:(AlertBtnTitleClickBlock)alertBtnTitleBlock{
    [self jxt_showAlertWithTitle:title message:message appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        
        for ( NSString *titleStr in inputTitleArray) {
            alertMaker.addActionDestructiveTitle(titleStr);
            [alertMaker addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = titleStr;
            }];
        }
        
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        alertBtnBlock(buttonIndex);
        alertBtnTitleBlock(action.title);
    }];
}

-(void)closeAlertView{
    jxt_dismissHUD();
}
@end
