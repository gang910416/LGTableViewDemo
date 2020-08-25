//
//  LGIndexesViewController.m
//  LGTestProject
//
//  Created by liugang on 2020/8/24.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "LGIndexesViewController.h"
#import "SearchResultViewController.h"

@interface LGIndexesViewController ()<UISearchResultsUpdating,UISearchControllerDelegate,UISearchBarDelegate>
{
    NSArray *sectionTitles; // 每个分区的标题
    NSArray *contentsArray; // 每行的内容
    
}


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;
@property (strong,nonatomic) NSMutableArray  *searchResults;  //搜索结果
@property (strong,nonatomic) NSMutableArray  *allContancts;  //所有联系人
@property (strong,nonatomic) SearchResultViewController *resultVC; //搜索结果展示控制器

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
    //创建显示搜索结果控制器
    _resultVC = [[SearchResultViewController alloc] init];
    WS(weakSelf);
    _resultVC.resultsBlock = ^(NSString *contentName) {
        [weakSelf openContentClick];
    };
    _searchController = [[UISearchController alloc] initWithSearchResultsController:_resultVC];
    _searchController.searchResultsUpdater = self;
    _searchController.delegate = self;
    //_searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = YES;//搜索时隐藏导航栏  默认的是YES
    
    _searchController.searchBar.placeholder = @"placeholder";
    _searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    //_searchController.searchBar.prompt = @"prompt"; //提示语
    _searchController.searchBar.showsCancelButton = YES;
    _searchController.searchBar.showsBookmarkButton = YES;
    //_searchController.searchBar.showsSearchResultsButton = YES;
    
    //ScopeBar
    //_searchController.searchBar.showsScopeBar = YES;
    //_searchController.searchBar.scopeButtonTitles = @[@"BookmarkButton" ,@"ScopeButton",@"ResultsListButton",@"CancelButton",@"SearchButton"];
    _searchController.searchBar.delegate = self;
    _searchController.searchBar.frame = CGRectMake(0, 0, SCREEN_W,60);
    self.tableView.tableHeaderView = _searchController.searchBar;
    
    //解决：退出时搜索框依然存在的问题
    self.definesPresentationContext = YES;
}

/** @brief 准备数据源 在viewDidLoad方法中调用*/
- (void)readySource
{
    
    sectionTitles  = [[NSArray alloc] initWithObjects:
                      @"A",@"C",@"F",@"G",@"H",@"M",@"S",@"T",@"X",@"Z", nil];
    contentsArray   = [[NSArray alloc] initWithObjects:
                       @[@"阿伟",@"阿姨",@"阿三",@"apple",@"alen-Iverson"],
                       @[@"蔡芯",@"成龙",@"陈鑫",@"陈丹",@"成名",@"cai",@"chen"],
                       @[@"芳仔",@"房祖名",@"方大同",@"芳芳",@"范伟",@"fanay",@"fun"],
                       @[@"郭靖",@"郭美美",@"过儿",@"过山车",@"guo",@"gougouying"],
                       @[@"何仙姑",@"和珅",@"郝歌",@"好人"],
                       @[@"妈妈",@"毛主席"],
                       @[@"孙中山",@"沈冰",@"婶婶"],
                       @[@"涛涛",@"淘宝",@"套娃"],
                       @[@"小二",@"夏紫薇",@"许巍",@"许晴"],
                       @[@"周恩来",@"周杰伦",@"张柏芝",@"张大仙"],nil];
    
    self.allContancts = [NSMutableArray array];
    for (NSArray *a in contentsArray) {
        for (int j = 0; j < a.count; j++) {
            [self.allContancts addObject:a[j]];
        }
    }
    NSLog(@"");
}


- (void)openContentClick{
    // 停止搜索
    self.searchController.active = NO;
    LQWkWebViewController *wkWebVc = [[LQWkWebViewController alloc]init];
    wkWebVc.urlStr = @"https://nba.sina.cn/?vt=4&pos=108";
    [self presentViewController:wkWebVc animated:YES completion:nil];
}

#pragma  mark --------------------------- 按钮点击事件 --------------------------

-(void)onHideKeyboard{
    [self.view endEditing:NO];
}

#pragma  mark --------------------------- searchViewController delegate--------------------------
// 每次更新搜索框里的文字，就会调用这个方法
// Called when the search bar's text or scope has changed or when the search bar becomes first responder.
// 根据输入的关键词及时响应：里面可以实现筛选逻辑  也显示可以联想词

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"%s",__func__);
    //获取搜索框里地字符串
    NSString *searchString = searchController.searchBar.text;
    // 创建谓词
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS [CD] %@", searchString];
    if (_searchResults != nil && searchString.length > 0) {
        // 清楚搜索结果
        [_searchResults removeAllObjects];
        _searchResults  = [NSMutableArray arrayWithArray:[self.allContancts filteredArrayUsingPredicate:predicate]];
        NSLog(@"");
    }else if (searchString.length == 0 ){
        _searchResults = [NSMutableArray arrayWithArray:self.allContancts];
    }
    self.resultVC.results = _searchResults;
    
}


#pragma  mark --------------------------- tableViewDelegate --------------------------

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:NO];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.searchController.active) {
        
    }else{
        LQWkWebViewController *wkWebVc = [[LQWkWebViewController alloc]init];
        wkWebVc.urlStr = @"https://nba.sina.cn/?vt=4&pos=108";
        [self.navigationController pushViewController:wkWebVc animated:YES];
    }
    // 停止搜索
    self.searchController.active = NO;
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


- (NSMutableArray *) searchResults {
    if (_searchResults == nil) {
        _searchResults = [NSMutableArray array];
    }
    return _searchResults;
}



@end
