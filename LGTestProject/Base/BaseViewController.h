//
//  BaseViewController.h
//  ConvenientStore
//
//  Created by LHJ on 2017/12/15.
//  Copyright © 2017年 LHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Color_Transparent           [UIColor clearColor]
#define GetImg(str)                 [UIImage imageNamed:str]
#define Font(s)                     [UIFont systemFontOfSize:s]
#define Font_Bold(s)                [UIFont boldSystemFontOfSize:s]

// ---- LHJ ----
#define RGBAColor(r,g,b,a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGBColor(r,g,b)     RGBAColor(r,g,b,1.0)
#define RGBColorC(c)        RGBColor((((int)c) >> 16),((((int)c) >> 8) & 0xff),(((int)c) & 0xff))

/**
 alert按钮执行回调
 
 @param buttonIndex 按钮index
 */
typedef void (^AlertClickBlock)(NSInteger buttonIndex);
typedef void (^AlertBtnTitleClickBlock)(NSString *buttonTitle);

/** 所有ViewController的基类 */
@interface BaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

/** 是否需要处理键盘弹出/收起的事件，默认NO   在ViewDidLoad前设置*/
@property(nonatomic, assign) BOOL isNeedHandleKeyboard;

@property (nonatomic, assign) BOOL isHideBackItem;
@property (nonatomic,strong) MBProgressHUD* hud;


/** 返回键盘上方的完成一栏 */
+ (UIView*) getKeyboardHideViewWithTarget:(id)target withSelector:(SEL)selector;


/*
 * 创建导航栏按钮
 */
- (void) createNavgationBarWithTitle:(NSString *)title isLeftBarButton:(BOOL)isLeftBarButton;
- (void) createNavgationBarWith:(NSString *)imageName isLeftBarButton:(BOOL)isLeftBarButton;
-(void) leftNavBarBtnClick:(UIBarButtonItem *)sender;
-(void) rightNavBarBtnClick:(UIBarButtonItem *)sender;
/**
 在VC的view上加HUD，
 @param msg 显示的文本，nil为不显示任何文本
 */
- (void)showHUDToViewMessage:(NSString *)msg;

- (void)showHUDToWindowMessage:(NSString *)msg;

- (void)removeHUD;

/*
* 常规 两个按钮的弹窗
* title 标题
* message 消息内容
* cancelBtnStr 取消按钮
* otherBtnStr 确定按钮title
*/
- (void)showAlertWithBtn:(NSString *)title message:(NSString *)message cancelBtnStr:(NSString *)cancelBtnStr otherBtnStr:(NSString *)otherBtnStr alertBtnBlock:(AlertClickBlock)alertBtnBlock ;

/*
* 简单的提示 只有一个确定按钮
* title 标题
*/
- (void)showAlertWithTitle:(NSString *)title;

/*
* 多个按钮的提示框
* title 标题
* message 消息内容
* cancelButtonTitle 取消按钮文字
* btnTitleArray 其他按钮title数组
* alertBtnBlock 点击按钮回调返回按钮的tag
*/


- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle btnTitleArray:(NSArray *)btnTitlearr alertBtnBlock:(AlertClickBlock)alertBtnBlock;
/*
 * 简单的提示 不带按钮
 * title 标题
 * message 消息内容
 * duration 显示时间
 */
- (void)showAlertWithTitleNoBtn:(NSString *)title message:(NSString *)message duration:(NSTimeInterval)duration;

/*
* 带加载转圈圈的提示
* title 标题
* message 消息内容
*/
-(void)showAlertWithLoadingWithTitle:(NSString *)title message:(NSString *)message;

/*
* 带进度条的提示
* title 标题
* message 消息内容
*/
- (void)showProgressHUDTitle:(NSString *)title message:(NSString *)message;
/*
* 多个按钮的ActionSheet弹窗
* title 标题
* message 消息内容
*/
-(void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle btnTitleArray:(NSArray *)btnTitleArray alertBtnTitleBlock:(AlertBtnTitleClickBlock)alertBtnTitleBlock;
/*
* 带输入框的 弹框
* title 标题
* message 消息内容
* inputViewPavarTitleArray 输入框展位文字的数组
* alertBtnBlock 返回点击按钮的index
* alertBtnTitleBlock 返回输入框文字
*/
-(void)showAlertInputViewWithTitle:(NSString *)title message:(NSString *)message inputViewPavarTitleArray:(NSArray *)inputTitleArray alertBtnBlock:(AlertClickBlock)alertBtnBlock alertBtnTitleBlock:(AlertBtnTitleClickBlock)alertBtnTitleBlock;
// 关闭提示框
-(void)closeAlertView;

///右滑返回功能，默认开启（YES）
- (BOOL)gestureRecognizerShouldBegin;



@end
