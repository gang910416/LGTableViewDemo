//
//  NomalCollectionViewCell.m
//  LGTestProject
//
//  Created by liugang on 2020/8/26.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "NomalCollectionViewCell.h"

@implementation NomalCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        int x = arc4random() % 5;// [0, 10)的随机数
        NSLog(@"%d", x);

        // 图片
        self.image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, frame.size.width - 20, frame.size.height - 10)];
        self.image.image = x >= 5 ? [UIImage imageNamed:@"boy.jpg"] : [UIImage imageNamed:@"girl.jpg"];
        [self.contentView addSubview:self.image];

        // 文字
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, frame.size.height - 25, frame.size.width - 20, 20)];
        self.label.text = x >= 5 ? @"鬼助" : @"百姬";
        self.label.textColor = [UIColor whiteColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.label];

    }
    return self;
}


@end
