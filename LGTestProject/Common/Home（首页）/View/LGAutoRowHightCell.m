//
//  LGAutoRowHightCell.m
//  LGTestProject
//
//  Created by liugang on 2020/8/22.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "LGAutoRowHightCell.h"

@implementation LGAutoRowHightCell


-(void)setInfoDic:(NSDictionary *)infoDic{
    _infoDic = infoDic;
    self.titleLabel.text = infoDic[@"title"];
    self.descLabel.text = infoDic[@"desc"];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
