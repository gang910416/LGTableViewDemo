//
//  Macro.h
//  TestForUITableView
//
//  Created by liugang on 2020/8/20.
//  Copyright © 2020 liugang. All rights reserved.
//

#ifndef Macro_h
#define Macro_h


typedef enum {
    VerticalType,   //垂直 : 固定列数，高度不固定，高度随着图片宽度决定。
    HorizontalType  //水平 : 高度固定，宽度不固定，宽度随着图片高度决定。
} DirectionType; //瀑布流类型


#define LGThemeColor ([UIColor colorWithRed:252.0/255.0 green:132.0/255.0 blue:46.0/255.0 alpha:1.0])

#define LGTintColor [UIColor whiteColor]


#define SCREEN_W  [UIScreen mainScreen].bounds.size.width
#define SCREEN_H  [UIScreen mainScreen].bounds.size.height


//16进制颜色
#define UICOLOR_RGB_Alpha(_color,_alpha) [UIColor colorWithRed:((_color>>16)&0xff)/255.0f green:((_color>>8)&0xff)/255.0f blue:(_color&0xff)/255.0f alpha:_alpha]
#define Crm_Com_MaskColor  RGBA_COLOR(135, 135, 135, 0.4)
#define CRM_CHOOSEVIEW_BGCOLOR RGBA_COLOR(235, 235, 241, 1)
#define Color_BackGround UICOLOR_RGB_Alpha(0xeeeeee,1)
#define RGBA_COLOR(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define Color_NavBackGround  RGBA_COLOR(61, 103, 242, 1)      //UICOLOR_RGB_Alpha(0xFFFFFF,1)
#define Color_blue_Select UICOLOR_RGB_Alpha(0x4E80F5,1)
//所有的蓝色按钮颜色
#define BlueButtonColor  RGBA_COLOR(78, 128, 245, 1)
//随机色
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define ColorRandomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define DATE_YMDHMS @"yyyy-MM-dd HH:mm:ss"
#define DATE_YMD  @"yyyy-MM-dd"
#define DATE_Y   @"yyyy"

#define CACHESPATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
// 导航栏高度
#define kNavigationHeight (isIPhoneXSeries()?88:64)
#define kSafeAreaBottomHeigth (isIPhoneXSeries()?34:0)
#define kTabBarHeight  (isIPhoneXSeries() ? (49.f+34.f) : 49.f)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_WINDOW_HEIGHT (SCREEN_HEIGHT-(STATUS_HEIGHT+44))
#define STATUS_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height//状态栏高度
#define kbottomViewHeight  (isIPhoneXSeries() ? (60.f+34.f) : 60.f)
#define LimitCount  100


#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;




#endif /* Macro_h */
