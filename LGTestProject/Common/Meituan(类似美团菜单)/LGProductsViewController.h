//
//  LGProductsViewController.h
//  LGTestProject
//
//  Created by liugang on 2020/8/24.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ProductsDelegate <NSObject>

- (void)willDisplayHeaderView:(NSInteger)section;
- (void)didEndDisplayingHeaderView:(NSInteger)section;

@end

@interface LGProductsViewController : BaseViewController

@property (nonatomic, weak) id<ProductsDelegate> delegate;


/**
*  当CategoryTableView滚动时,ProductsTableView跟随滚动至指定section
 */
- (void)scrollToSelectedIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
