//
//  SearchResultViewController.m
//  LGTestProject
//
//  Created by liugang on 2020/8/25.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "SearchResultViewController.h"

@interface SearchResultViewController ()

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索结果";
    self.view.backgroundColor = RGBColor(210, 212, 224);
}

-(void)setResults:(NSArray *)results {
    NSLog(@"%s",__FUNCTION__);
    _results = results;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.results count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *flag=@"cellFlag";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
    }
    [cell.textLabel setText:self.results[indexPath.row]];
    cell.backgroundColor = RGBColor(224, 224, 224);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"searchText = %@",_results[indexPath.row]);
    
    self.resultsBlock(_results[indexPath.row]);
}

@end
