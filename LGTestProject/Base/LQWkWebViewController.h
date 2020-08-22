//
//  LQWkWebViewController.h
//  LongQuan
//
//  Created by liugang on 2020/8/18.
//  Copyright © 2020 DeveLoper. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LQWkWebViewController : BaseViewController

//网页链接
@property(nonatomic,copy)NSString *urlStr;
//html内容
@property(nonatomic,copy)NSString *content;

@end

NS_ASSUME_NONNULL_END
