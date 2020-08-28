//
//  GoodsHeaderCell.m
//  LGTestProject
//
//  Created by liugang on 2020/8/28.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "GoodsHeaderCell.h"

@implementation GoodsHeaderCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc]init];
              self.imageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
              self.imageView.layer.cornerRadius = 3;
              self.imageView.layer.masksToBounds = YES;
              [self addSubview:self.imageView];
    }
    return self;
}
@end
