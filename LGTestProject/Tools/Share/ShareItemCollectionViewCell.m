//
//  ShareItemCollectionViewCell.m
//  SmartMall
//
//  Created by liugang on 2020/8/18.
//  Copyright © 2020 DeveLoper. All rights reserved.
//

#import "ShareItemCollectionViewCell.h"

@implementation ShareItemCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.iconImageView.layer.cornerRadius = 25;
//    self.iconImageView.layer.masksToBounds = YES;
}

- (void)setCellRelationDataTitle:(NSString *)title imageTitle:(NSString *)imageName
{
    self.iconImageView.image = [UIImage imageNamed:imageName];
    self.titleLabel.text = title;
}

@end
