//
//  LGVideoLineLoadView.h
//  LGTestProject
//
//  Created by liugang on 2020/10/13.
//  Copyright © 2020 liugang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGVideoLineLoadView : UIView
+ (void)showLoadingInView:(UIView *)view withLineHeight:(CGFloat)lineHeight;

+ (void)hideLoadingInView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
