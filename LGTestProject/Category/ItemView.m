//
//  ItemView.m
//  TestForUITableView
//
//  Created by liugang on 2020/8/20.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "ItemView.h"
#import "UIView+Extension.h"
@implementation ItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    UINavigationBar *navBar = nil;
    UIView *aView = self.superview;
    while (aView) {
        if ([aView isKindOfClass:[UINavigationBar class]]) {
            navBar = (UINavigationBar *)aView;
            break;
        }
        aView = aView.superview;
    }
    UINavigationItem * navItem =   (UINavigationItem *)navBar.items.lastObject;
    UIBarButtonItem *leftItem = navItem.leftBarButtonItem;
    UIBarButtonItem *rightItem = navItem.rightBarButtonItem;

    ///左边按钮中的btn一般不需要重新布局
    if (leftItem) {//左边按钮
        ItemView *leftItemView = leftItem.customView;
        if ([leftItemView isKindOfClass:self.class]) {
            //如果开发者需要修改左边的item布局，可以在此添加代码，修复btn的frame
        }
    }
    ///针对右边的item，在此重新布局一次，
    if (rightItem) {//右边按钮
        ItemView *rightItemView = rightItem.customView;
        if ([rightItemView isKindOfClass:self.class]) {
            rightItemView.btn.x = rightItemView.width -rightItemView.btn.width-0;
        }
    }
   
}



@end
