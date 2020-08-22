//
//  LGHomeViewController.m
//  TestForUITableView
//
//  Created by liugang on 2020/8/20.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "LGHomeViewController.h"


@interface LGHomeViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIColor *navgatationColor;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *classNames;



@end

@implementation LGHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationItem.title = @"tableView 常见的案例";
//    [self createNavgationBarWith:@"white_search" isLeftBarButton:YES];
//    [self createNavgationBarWith:@"ewm" isLeftBarButton:NO];
    self.dataSource = @[@"键盘事件监听",@"导航栏随tableView的滑动改变透明效果",@"table与collection的联动效果",@""];
    self.classNames = @[@"KeyBroardViewController",@"ChangeNAvBarViewController",@"LGGuanlianViewController"];
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
//    LQWkWebViewController *wkWebVc = [[LQWkWebViewController alloc]init];
//    wkWebVc.urlStr = @"https://nba.sina.cn/?vt=4&pos=108";
//    [self.navigationController pushViewController:wkWebVc animated:YES];
    
    NSString *className = self.classNames[indexPath.row]; //classNames 字符串数组集
       Class class = NSClassFromString(className);
       if (class) {
           BaseViewController *ctrl = class.new;
           ctrl.title = self.dataSource[indexPath.row];
           [self.navigationController pushViewController:ctrl animated:YES];
       }
    
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
