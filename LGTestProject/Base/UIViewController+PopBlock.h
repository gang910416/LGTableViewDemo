//
//  UIViewController+PopBlock.h
//  TestForUITableView
//
//  Created by liugang on 2020/8/20.
//  Copyright © 2020 liugang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PopBlock) (UIBarButtonItem *backItem);

@interface UIViewController (PopBlock)
@property (nonatomic, copy) PopBlock popBlock;
@end

NS_ASSUME_NONNULL_END
