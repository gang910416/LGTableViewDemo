//
//  ChangeNAvBarViewController.m
//  LGTestProject
//
//  Created by liugang on 2020/8/22.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "ChangeNAvBarViewController.h"

@interface ChangeNAvBarViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;//轮播图
@property (nonatomic, strong) UIColor *navgatationColor;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ChangeNAvBarViewController


//-(void)loadView{
//
//    self.isNeedHandleKeyboard = YES;
//
//    UIView *viewMain = [UIView new];
//    [viewMain setFrame:[UIScreen mainScreen].bounds];
//    [viewMain setBackgroundColor:RGBColor(255, 255, 255)];
//    [viewMain setUserInteractionEnabled:YES];
//    [self setView:viewMain];
//
//    int width = 200;
//    int height = 40;
//    int x = (CGRectGetWidth(viewMain.bounds) - width)/2;
//    int y = 190;
//    _textView = [UITextView new];
//    [_textView setFrame:CGRectMake(x, y, width, height)];
//    [_textView setBackgroundColor:RGBColor(244, 30, 30)];
//    [viewMain addSubview:_textView];
//
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
//    [self createNavgationBarWith:@"white_search" isLeftBarButton:YES];
    [self createNavgationBarWith:@"ewm" isLeftBarButton:NO];
    self.dataSource = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16"];
    
    [self.view addSubview:self.tableView];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar wm_reset];
    if (self.navgatationColor) {
        [self.navigationController.navigationBar wm_setBackgroundColor:self.navgatationColor];
    }else{
        
        [self.navigationController.navigationBar wm_setBackgroundColor:[UIColor clearColor]];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navgatationColor = [self.navigationController.navigationBar wm_getBackgroundColor];
    [self.navigationController.navigationBar wm_reset];
}


#pragma  mark --------------------- 按钮点击事件 ------------------------------

-(void) leftNavBarBtnClick:(UIBarButtonItem *)sender{
    NSLog(@"leftNavBarBtnClick");
}
-(void) rightNavBarBtnClick:(UIBarButtonItem *)sender{
    NSLog(@"rightNavBarBtnClick");
}


-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    NSLog(@"index = %ld",index);
}


#pragma  mark --------------------- UITableViewDelegate ---------------------

///监听scrollView的滚动事件
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.tableView) {
        CGFloat offsetY = scrollView.contentOffset.y;
        //        NSLog(@"offsetY = %f",offsetY);
        if (offsetY > 0) {
            CGFloat alpha = (offsetY -64) / 64 ;
            alpha = MIN(alpha, 0.99);
            //            NSLog(@"alpha =%f",alpha);
            [self.navigationController.navigationBar wm_setBackgroundColor:[LGThemeColor colorWithAlphaComponent:alpha]];
                
            if (alpha>=0.99) {
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
                self.navigationItem.title = @"首页";
            }
        } else {

            [self.navigationController.navigationBar wm_setBackgroundColor:[UIColor clearColor]];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
            self.navigationItem.title = @"首页";

            CGPoint offset = scrollView.contentOffset;
            //判断是否改变

            CGRect rect = self.tableView.tableHeaderView.frame;
            //我们只需要改变图片的y值和高度即可
            rect.origin.y = 0;
            rect.origin.x = 0;
            rect.size.height = 200 - offset.y;
            self.tableView.tableHeaderView.frame = rect;

        }
    }
  
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0f;;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *aView = [UIView new];
    aView.frame = CGRectMake(0, 0, tableView.frame.size.width, 0.0001);
    return aView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    LQWkWebViewController *wkWebVc = [[LQWkWebViewController alloc]init];
    wkWebVc.urlStr = @"https://nba.sina.cn/?vt=4&pos=108";
    [self.navigationController pushViewController:wkWebVc animated:YES];
    
}


#pragma  mark --------------------- 懒加载 ---------------------
/**
 懒加载轮播图
 
 @return _cycleScrollView
 */
-(SDCycleScrollView *)cycleScrollView{
    if (_cycleScrollView==nil) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_W, 192.f) delegate:self  placeholderImage:nil];
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeCenter;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        //    cycleScrollView2.titlesGroup = titles;
        _cycleScrollView.imageURLStringsGroup = @[@"banner2",@"banner1"];
        _cycleScrollView.currentPageDotColor = LGTintColor; // 自定义分页控件小圆标颜色
        _cycleScrollView.pageDotColor = [UIColor whiteColor];
    }
    return _cycleScrollView;
}
/**
 懒加tableView
 
 @return _table
 */

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H - kTabBarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.tableFooterView = [UIView new];
        _tableView.tableHeaderView = self.cycleScrollView;
        
    }
    return _tableView;
    
}

-(BOOL)shouldAutorotate{
    return NO;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}


@end
