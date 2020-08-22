//
//  LGGuanlianViewController.m
//  LGTestProject
//
//  Created by liugang on 2020/8/22.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "LGGuanlianViewController.h"
#import "LGBtnScrollView.h"
#import "LGAutoRowHightCell.h"
@interface LGGuanlianViewController ()<UITableViewDelegate,UITableViewDataSource,LGBtnScrollViewDelegate>
@property (nonatomic,strong)  LGBtnScrollView *titleSV;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation LGGuanlianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置数据
    [self creatDataArray];
    //创建UI
    [self createUI];
    
    // Do any additional setup after loading the view.
}

- (void)creatDataArray{
    self.titleArray  = @[@{@"title":@"家庭医生",@"sImage":@"index0_s",@"uImage":@"index0_u",@"indexId":@"0"},@{@"title":@"专家问诊",@"sImage":@"index1_s",@"uImage":@"index1_u",@"indexId":@"1"},@{@"title":@"健康档案",@"sImage":@"index2_s",@"uImage":@"index2_u",@"indexId":@"2"},@{@"title":@"健康直播",@"sImage":@"index3_s",@"uImage":@"index3_u",@"indexId":@"3"},@{@"title":@"报告解读",@"sImage":@"index4_s",@"uImage":@"index4_u",@"indexId":@"4"},@{@"title":@"医院转诊",@"sImage":@"index5_s",@"uImage":@"index5_u",@"indexId":@"5"},@{@"title":@"海外就医",@"sImage":@"index6_s",@"uImage":@"index6_u",@"indexId":@"6"},@{@"title":@"住院手术",@"sImage":@"index7_s",@"uImage":@"index7_u",@"indexId":@"7"}];
    
    self.dataSource = @[
                  @{@"title":@"家庭医生",@"desc":@"拥有家庭医生，您可以随时就全家的健康问题进行在线咨询。",@"index":@"0"}
    ,@{@"title":@"专家问诊",@"desc":@"您可以免费或以折扣价格向爱心医疗专家进行在线问诊。您可以免费或以折扣价格向爱心医疗专家进行在线问诊。您可以免费或以折扣价格向爱心医疗专家进行在线问诊。您可以免费或以折扣价格向爱心医疗专家进行在线问诊。您可以免费或以折扣价格向爱心医疗专家进行在线问诊。您可以免费或以折扣价格向爱心医疗专家进行在线问诊。",@"index":@"1"}
    ,@{@"title":@"健康档案",@"desc":@"免费为全家人创建健康档案，爱心云健康帮您记录医疗信息。",@"index":@"2"}
    ,@{@"title":@"健康直播",@"desc":@"各路知名医疗大神手把手传授您健康诀窍。",@"index":@"3"}
    ,@{@"title":@"报告解读",@"desc":@"免费或以折扣价格为您解读检验报告单并提供专业医疗建议。免费或以折扣价格为您解读检验报告单并提供专业医疗建议。",@"index":@"4"}
    ,@{@"title":@"医院转诊",@"desc":@"您可以免费或以折扣价格向爱心医疗专家进行在线问诊。您可以免费或以折扣价格向爱心医疗专家进行在线问诊。您可以免费或以折扣价格向爱心医疗专家进行在线问诊。",@"index":@"5"}
    ,@{@"title":@"海外就医",@"desc":@"联合全球顶级优质医疗机构，为您提供最专业医学意见。",@"index":@"6"}
    ,@{@"title":@"住院手术",@"desc":@"当确定手术需求时，为您安排顶级医院的手术治疗方案。当确定手术需求时，为您安排顶级医院的手术治疗方案。当确定手术需求时，为您安排顶级医院的手术治疗方案。当确定手术需求时，为您安排顶级医院的手术治疗方案。当确定手术需求时，为您安排顶级医院的手术治疗方案。",@"index":@"7"}];
}

- (void)createUI{
    
    self.titleSV = [[LGBtnScrollView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, SCREEN_W, 85) titleArray:self.titleArray];
    self.titleSV.delegate = self;
    [self.view addSubview:self.titleSV];
    
    self.myTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight + self.titleSV.frame.size.height, SCREEN_W, SCREEN_H - kNavigationHeight - self.titleSV.frame.size.height) style:UITableViewStylePlain];
     self.myTableView.delegate = self;
     self.myTableView.dataSource = self;
     [self.myTableView registerNib:[UINib nibWithNibName:@"LGAutoRowHightCell" bundle:nil] forCellReuseIdentifier:@"LGAutoRowHightCell"];
     self.myTableView.estimatedRowHeight = 50;
     self.myTableView.rowHeight = UITableViewAutomaticDimension;
     self.myTableView.tableFooterView = [UIView new];
     self.myTableView.tableHeaderView = [UIView new];
     self.myTableView.rowHeight = 45.f;
     self.myTableView.contentInset = UIEdgeInsetsMake(0, 0, SCREEN_H - self.titleSV.frame.size.height-kNavigationHeight-kbottomViewHeight-kNavigationHeight + 30, 0);
    [self.view addSubview:self.myTableView];
}

#pragma  mark --------------------------- LGBtnScrollViewDelegate --------------------------

- (void)seletedBtnOnClick:(LGBtnScrollView *)btnView index:(NSInteger)index{
    
    [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma  mark --------------------------- tableViewDelegate --------------------------

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
     if (scrollView==self.myTableView) {
         
           CGPoint gjPoint  = CGPointMake(100, kNavigationHeight+self.titleSV.frame.size.height+1);//+1很重要，+1确保关键的点在需要的位置
         // 将像素point由point所在视图转换到目标视图view中，返回在目标视图view中的像素值
           CGPoint p_intable =   [self.view convertPoint:gjPoint toView:self.myTableView];
           NSIndexPath *indexPath =  [self.myTableView indexPathForRowAtPoint:p_intable];
           NSDictionary *dic = self.dataSource[indexPath.row];
           NSInteger bottomIndex = [dic[@"index"] integerValue];
           if (bottomIndex != self.titleSV.seletcedBtn.tag-100) {
               [self.titleSV setContentOffset:CGPointMake(85*bottomIndex, 0) animated:YES];
               [self.titleSV setIndexSelected:bottomIndex];
           }
       }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LGAutoRowHightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGAutoRowHightCell"];
    cell.infoDic = self.dataSource[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}



@end
