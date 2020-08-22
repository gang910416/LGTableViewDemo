//
//  ShareMenuView.h
//  SmartMall
//
//  Created by liugang on 2020/8/18.
//  Copyright © 2020 DeveLoper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareMenuView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)NSMutableArray * imageNameList; //分享菜单图片名字
@property (nonatomic, strong)NSMutableArray * titleNameList; //分享菜单title
@property (nonatomic, copy) void (^menuViewDidSelectedBlock)(NSInteger index);

- (void)shareMenuViewShow;
- (void)shareMenuViewHidden;

@end
