//
//  LGIndexesViewController.m
//  LGTestProject
//
//  Created by liugang on 2020/8/24.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "LGIndexesViewController.h"

@interface LGIndexesViewController ()
{
    NSArray *sectionTitles; // 每个分区的标题
       NSArray *contentsArray; // 每行的内容
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LGIndexesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self readySource];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kNavigationHeight);
        make.left.right.bottom.equalTo(self.view);
    }];
    // Do any additional setup after loading the view.
}

/** @brief 准备数据源 在viewDidLoad方法中调用*/
- (void)readySource
{
    
    sectionTitles       = [[NSArray alloc] initWithObjects:
                           @"A",@"C",@"F",@"G",@"H",@"M",@"S",@"T",@"X",@"Z", nil];
    contentsArray       = [[NSArray alloc] initWithObjects:
                            @[@"阿伟",@"阿姨",@"阿三"],
                            @[@"蔡芯",@"成龙",@"陈鑫",@"陈丹",@"成名"],
                            @[@"芳仔",@"房祖名",@"方大同",@"芳芳",@"范伟"],
                            @[@"郭靖",@"郭美美",@"过儿",@"过山车"],
                            @[@"何仙姑",@"和珅",@"郝歌",@"好人"],
                            @[@"妈妈",@"毛主席"],
                            @[@"孙中山",@"沈冰",@"婶婶"],
                            @[@"涛涛",@"淘宝",@"套娃"],
                            @[@"小二",@"夏紫薇",@"许巍",@"许晴"],
                            @[@"周恩来",@"周杰伦",@"张柏芝",@"张大仙"],nil];
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [sectionTitles objectAtIndex:section];
}
// 索引目录
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return sectionTitles;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return sectionTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [contentsArray[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = contentsArray[indexPath.section][indexPath.row];
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
