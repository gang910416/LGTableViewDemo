//
//  KeyBroardViewController.m
//  LGTestProject
//
//  Created by liugang on 2020/8/22.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "KeyBroardViewController.h"

@interface KeyBroardViewController ()
@property (nonatomic, strong) UITextView *textView;
@end

@implementation KeyBroardViewController

-(void)loadView{

    self.isNeedHandleKeyboard = YES;

    UIView *viewMain = [UIView new];
    [viewMain setFrame:[UIScreen mainScreen].bounds];
    [viewMain setBackgroundColor:RGBColor(255, 255, 255)];
    [viewMain setUserInteractionEnabled:YES];
    [self setView:viewMain];

    int width = 200;
    int height = 40;
    int x = (CGRectGetWidth(viewMain.bounds) - width)/2;
    int y = 190;
    _textView = [UITextView new];
    [_textView setFrame:CGRectMake(x, y, width, height)];
    [_textView setBackgroundColor:RGBColor(244, 30, 30)];
    [viewMain addSubview:_textView];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
