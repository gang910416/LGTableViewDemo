//
//  UIViewController+PopBlock.m
//  TestForUITableView
//
//  Created by liugang on 2020/8/20.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "UIViewController+PopBlock.h"
#import <objc/runTime.h>

@implementation UIViewController (PopBlock)

-(void)setPopBlock:(PopBlock)popBlock{
    objc_setAssociatedObject(self, @selector(popBlock), popBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(PopBlock)popBlock{
    return objc_getAssociatedObject(self, _cmd);
}

@end
