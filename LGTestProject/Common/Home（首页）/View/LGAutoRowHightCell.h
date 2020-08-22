//
//  LGAutoRowHightCell.h
//  LGTestProject
//
//  Created by liugang on 2020/8/22.
//  Copyright © 2020 liugang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGAutoRowHightCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property(nonatomic,strong)NSDictionary *infoDic;
@end

NS_ASSUME_NONNULL_END
