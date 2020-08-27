//
//  WaterFlowCollectionViewCell.m
//  LGTestProject
//
//  Created by liugang on 2020/8/27.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "WaterFlowCollectionViewCell.h"

@implementation WaterFlowCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
         self.layer.cornerRadius = 3;
         self.layer.masksToBounds = YES;
        self.imageView = [[UIImageView alloc]init];
        self.imageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 50);
        self.imageView.layer.cornerRadius = 3;
        self.imageView.layer.masksToBounds = YES;
        [self addSubview:self.imageView];
        
        self.proTitle = [[UILabel alloc]initWithFrame:CGRectMake(5, self.bounds.size.height - 45, self.bounds.size.width - 10, 21)];
        self.proTitle.textColor = UIColor.grayColor;
        self.proTitle.font = [UIFont systemFontOfSize:13];
        [self addSubview: self.proTitle];
    }
    return self;
}

@end
