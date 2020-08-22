//
//  LGBtnScrollView.m
//  LGTestProject
//
//  Created by liugang on 2020/8/22.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "LGBtnScrollView.h"

@interface LGBtnScrollView ()<UIScrollViewDelegate>

@end

@implementation LGBtnScrollView

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray{
    
    if (self = [super initWithFrame:frame]) {
        for (NSDictionary *dic in titleArray) {
            NSInteger index = [titleArray indexOfObject:dic];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(20+index*85, 0, 85, 85);
            btn.tag = 100+index;
            btn.titleLabel.font = [UIFont systemFontOfSize:9];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -78, -60, 0)];
            [btn setTitle:dic[@"title"] forState:UIControlStateNormal];
            [btn setTitle:dic[@"title"] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
            [btn setImage:[UIImage imageNamed:dic[@"uImage"]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:dic[@"sImage"]] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(didSeletcedBtnIndex:) forControlEvents:UIControlEventTouchUpInside];
            if (index == 0) {
                btn.selected = YES;
                self.seletcedBtn = btn;
            }
            self.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:btn];
        }
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.contentSize = CGSizeMake(85*(titleArray.count), frame.size.height);
    }
    return self;
}


-(void)didSeletcedBtnIndex:(UIButton *)sender{
    if (self.seletcedBtn == sender) {
        return;
    }else{
        self.seletcedBtn.selected = NO;
        sender.selected = YES;
        self.seletcedBtn = sender;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(seletedBtnOnClick:index:)]) {
        [self.delegate seletedBtnOnClick:self index:(self.seletcedBtn.tag - 100)];
    }
}

- (void)setIndexSelected:(NSInteger)selectedIndex{
    UIButton *selectedBtn = (UIButton *)[self viewWithTag:selectedIndex + 100];
    if (self.seletcedBtn == selectedBtn) {
        return;
    }else{
        self.seletcedBtn.selected = NO;
        selectedBtn.selected = YES;
        self.seletcedBtn = selectedBtn;
    }
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
