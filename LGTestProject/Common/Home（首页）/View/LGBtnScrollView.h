//
//  LGBtnScrollView.h
//  LGTestProject
//
//  Created by liugang on 2020/8/22.
//  Copyright © 2020 liugang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LGBtnScrollView;

NS_ASSUME_NONNULL_BEGIN

@protocol LGBtnScrollViewDelegate <NSObject>
//  点击按钮
- (void)seletedBtnOnClick:(LGBtnScrollView *)btnView index:(NSInteger)index;

@end

@interface LGBtnScrollView : UIScrollView
@property (nonatomic, strong) id<LGBtnScrollViewDelegate> delegate;
@property(nonatomic,strong)UIButton *seletcedBtn;


-(void)setIndexSelected:(NSInteger )selectedIndex;
-(instancetype) initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;

@end

NS_ASSUME_NONNULL_END
