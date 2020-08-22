//
//  ShareItemCollectionViewCell.h
//  SmartMall
//
//  Created by liugang on 2020/8/18.
//  Copyright © 2020 DeveLoper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareItemCollectionViewCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)setCellRelationDataTitle:(NSString *)title imageTitle:(NSString *)imageName;

@end
