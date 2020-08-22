//
//  PersonCenterViewController.m
//  TestForUITableView
//
//  Created by liugang on 2020/8/20.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "PersonCenterViewController.h"

@interface PersonCenterViewController ()<UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *sectionArray;

@end

@implementation PersonCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    [self.view addSubview:self.tableView];
    self.sectionArray = @[@[@"意见反馈",@"关于我们",@"版本信息",@"清除缓存"],@[@"修改密码"],@[@"退出登录"]].mutableCopy;
    
}
#pragma  mark ------------------- TableViewDelegate ------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.sectionArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.sectionArray[indexPath.section][indexPath.row] ;
    cell.textLabel.font = [UIFont systemFontOfSize:16.f];
    cell.textLabel.textColor = [MSUtil colorWithHexString:@"444444"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0 && indexPath.row == 3) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        // 计算缓存
        cell.detailTextLabel.text = @"3M";
        // 设置字体及颜色
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }else if (indexPath.section == self.sectionArray.count - 1){
        UITableViewCell *logouCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"logout"];
        logouCell.textLabel.text = self.sectionArray[indexPath.section][indexPath.row];
        logouCell.accessoryType = UITableViewCellAccessoryNone;
        logouCell.textLabel.textColor = [MSUtil colorWithHexString:@"FF9393"];
        logouCell.textLabel.textAlignment = NSTextAlignmentCenter;
        return logouCell;
    }
    
    return cell;
}

/// 取消系统cell的separatorView
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == self.sectionArray.count -1) {
        [self performSelector:@selector(setSeparatorLineColor:) withObject:cell afterDelay:0.1];
    }
}
- (void)setSeparatorLineColor:(UITableViewCell *)cell
{
    // 获取系统cell的separatorView
    UIView * view = [cell valueForKey:@"separatorView"];
    view.backgroundColor = [UIColor whiteColor];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section != 0) {
        return 10.f;
    }else{
        return 0;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == self.sectionArray.count -1) {
        LGLoginViewController *loginVC =[LGLoginViewController new];
        BaseNavigationViewController *baseNav = [[BaseNavigationViewController alloc]initWithRootViewController:loginVC];
        [self presentViewController:baseNav animated:YES completion:nil];
    }else{
        LQWkWebViewController *webView = [LQWkWebViewController new];
        webView.urlStr = @"https://www.baidu.com";
        [self.navigationController pushViewController:webView animated:YES];
    }
}

#pragma  mark ------------------- 懒加载 ------------------------

- (UITableView *) tableView{
    if (_tableView == nil) {
        _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - kNavigationHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.tableHeaderView = [UIView new];
        _tableView.rowHeight = 45.f;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
    }
    return  _tableView;
}

@end
