//
//  LGBallLoadView.h
//  LGTestProject
//
//  Created by liugang on 2020/10/13.
//  Copyright © 2020 liugang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGBallLoadView : UIView

+ (instancetype)loadingViewInView:(UIView *)view;

- (void)startLoadingWithProgress:(CGFloat)progress;

- (void)startLoading;
- (void)stopAndDismissLoading;

@end

NS_ASSUME_NONNULL_END
