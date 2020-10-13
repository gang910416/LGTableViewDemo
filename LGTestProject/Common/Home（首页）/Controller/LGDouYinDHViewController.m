//
//  LGDouYinDHViewController.m
//  LGTestProject
//
//  Created by liugang on 2020/10/13.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "LGDouYinDHViewController.h"
#import "LGBallLoadView.h"
#import "LGVideoLineLoadView.h"
@interface LGDouYinDHViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIColor *navgatationColor;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *classNames;
@property (nonatomic, strong) UIView                *loadingBgView;
@property (nonatomic, strong) LGBallLoadView     *refreshLoadingView;
@property (nonatomic, strong) LGVideoLineLoadView     *videoLoadingView;
@end


@implementation LGDouYinDHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationItem.title = @"tableView 常见的案例";
    
    //    [self createNavgationBarWith:@"white_search" isLeftBarButton:YES];
    //    [self createNavgationBarWith:@"ewm" isLeftBarButton:NO];
    self.dataSource = @[@"三个球旋转动画加载",@"点赞动画",@"视频加载动画",@"长按屏幕点赞动画"];
    
    [self.view addSubview:self.tableView];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma  mark --------------------- UITableViewDelegate ---------------------



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
    
    
    switch (indexPath.row) {
        case 0:
            [self showBallLoadingView];
            break;
        case 1:
            [self showLineBallLoadingView];
            break;
            case 2:
            [self showLineBallLoadingView];
            break;
            case 3:
            [self showBallLoadingView];
            break;
        default:
            break;
    }
    
}

-(void) showBallLoadingView{
    self.refreshLoadingView = [LGBallLoadView loadingViewInView:self.view];
       [self.refreshLoadingView startLoading];
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           [self.refreshLoadingView stopAndDismissLoading];
       });
}

-(void) showLineBallLoadingView{
   [LGVideoLineLoadView showLoadingInView:self.view withLineHeight:1];
}

#pragma  mark --------------------- 懒加载 ---------------------
/**
 懒加tableView
 
 @return _table
 */

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0,kNavigationHeight, SCREEN_W, SCREEN_H - kTabBarHeight - kNavigationHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
    
}


@end
