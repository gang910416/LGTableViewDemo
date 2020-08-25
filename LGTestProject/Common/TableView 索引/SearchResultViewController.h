//
//  SearchResultViewController.h
//  LGTestProject
//
//  Created by liugang on 2020/8/25.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ResultsVCBlock)(NSString *contentName);
NS_ASSUME_NONNULL_BEGIN

@interface SearchResultViewController : UITableViewController

@property (nonatomic, copy) NSArray *results;
@property (nonatomic, copy) ResultsVCBlock resultsBlock;
@end

NS_ASSUME_NONNULL_END
