//
//  LGWaterfallViewController.m
//  LGTestProject
//
//  Created by liugang on 2020/8/26.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "LGWaterfallViewController.h"
#import <SDWebImage/SDWebImageManager.h>
#import <MJRefresh/MJRefresh.h>
#import "WaterFlowCollectionViewCell.h"
#import "GoodsHeaderCell.h"
#import "LGWaterflowLayout.h"

@interface LGWaterfallViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *imageUrls;
@property (nonatomic, strong) NSMutableArray *allImageUrls;
@property (nonatomic, strong) LGWaterflowLayout *waterflowLayout;
@property (nonatomic,copy)   NSString *firstImageURL;
@property (nonatomic, strong) NSMutableArray *widths;
@property (nonatomic, strong) NSMutableArray *heights;
@property (nonatomic, strong) NSMutableArray *picImageArr;

@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,strong) NSMutableArray *productDataSource;

@end

static NSString *identyfy = @"WaterFlowCollectionViewCell";
static NSString *identyfy1 = @"GoodsHeaderCell";


@implementation LGWaterfallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.currentPage = 0;
    self.view.backgroundColor = RGBColor(161, 173, 175);
    // 设置布局
    LGWaterflowLayout *layout = [[LGWaterflowLayout alloc]init];
    layout.type = _type;
    // 设置相关属性(不设置的话也行，都有相关默认配置)
    layout.numberOfColumns = 2;
    layout.columnGap = 10;
    layout.rowGap = 10;
    layout.insets = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.rowHeight = 100;
    self.waterflowLayout = layout;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) collectionViewLayout:self.waterflowLayout];
    //    self.collectionView.collectionViewLayout = self.waterflowLayout = layout;
    self.collectionView.backgroundColor = UIColor.lightGrayColor;
    // 集成刷新控件
    MJWeakSelf
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
        [weakSelf.collectionView.mj_header endRefreshing];
    }];
    [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //        [weakSelf loadMoreData];
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[WaterFlowCollectionViewCell class] forCellWithReuseIdentifier:identyfy];
    [self.collectionView registerClass:[GoodsHeaderCell class] forCellWithReuseIdentifier:identyfy1];
    [self.view addSubview:self.collectionView];
}

// 加载新数据(下拉刷新)
- (void)loadData {
    
    [self showHUDToWindowMessage:@"加载中..."];
    [[LGAFNetWorkManager shareManager] LGNetWorkingRequest:@"http://v.lehe.com/goods_category/get_goods" page:self.currentPage parameters:@{} succeed:^(NSError * _Nonnull error, id  _Nullable obj) {
        [self removeHUD];
        self.currentPage ++;
        HigoList *list = (HigoList *)obj;
        self.productDataSource = list.goods_list;
        self.firstImageURL = list.banner.banner_pic.image_original;
        [self.imageUrls removeAllObjects];
        if (self.firstImageURL != nil ) {
            [self.imageUrls addObject:self.firstImageURL];
        }
        for ( int i = 0 ;i < self.productDataSource.count ; i ++) {
            GoodsModel *model = self.productDataSource[i];
            [self.imageUrls addObject:model.main_image.image_original];
        }
        [self.allImageUrls removeAllObjects];
        [self.allImageUrls addObjectsFromArray:self.imageUrls];
        [self refresh:NO];
        
    } failure:^(NSError * _Nonnull error, id  _Nullable obj) {
         [self removeHUD];
    }];
    //    // 重置所有图片urls数组
    //    [self.allImageUrls removeAllObjects];
    //    [self.allImageUrls addObjectsFromArray:self.imageUrls];
    //    [self refresh:NO];
    
}

// 上拉加载更多
- (void)loadMoreData
{
    __weak typeof(self)weakSelf = self;
    [[LGAFNetWorkManager shareManager] LGNetWorkingRequest:@"http://v.lehe.com/goods_category/get_goods" page:self.currentPage parameters:@{} succeed:^(NSError * _Nonnull error, id  _Nullable obj) {
        [weakSelf.collectionView.mj_footer endRefreshing];
        HigoList *list = (HigoList *)obj;
        NSMutableArray *indexpaths = [[NSMutableArray alloc] init];
        NSInteger index = [weakSelf.collectionView numberOfItemsInSection:0];
        self.currentPage ++;
        for (GoodsModel *model in list.goods_list) {
            [weakSelf.productDataSource addObject:model];
            NSIndexPath *indexpath = [NSIndexPath indexPathForItem:index inSection:0];
            index++;
            [indexpaths addObject:indexpath];
        }
        [weakSelf.collectionView insertItemsAtIndexPaths:indexpaths];
        
        
        
    } failure:^(NSError *err, id obj) {
        
        // error
    }];
    
}

- (void)refresh:(BOOL)isloadNewData {
    MJWeakSelf
    if (isloadNewData) {
        [weakSelf.picImageArr removeAllObjects];
        
        if (self.type == VerticalType) {
            [weakSelf.heights removeAllObjects];
        }else if (self.type == HorizontalType) {
            [weakSelf.widths removeAllObjects];
        }
    }
    NSString *pidUrl;
    for (int i = 0; i < self.allImageUrls.count; i++) {
        pidUrl = self.allImageUrls[i];
        [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:pidUrl] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            
            if (weakSelf.type == VerticalType) {
                if (weakSelf.heights.count == weakSelf.allImageUrls.count) {
                    return;
                }
            }else if (weakSelf.type == HorizontalType) {
                if (weakSelf.widths.count == weakSelf.allImageUrls.count) {
                    return;
                }
            }
            
            if(image){
                if (weakSelf.picImageArr.count < weakSelf.allImageUrls.count) {
                    [weakSelf.picImageArr addObject:image];
                }
                
                if (weakSelf.type == HorizontalType) {
                    if (weakSelf.widths.count < weakSelf.allImageUrls.count) {
                        
                        // 根据图片原始比例 计算 当前图片的宽度(高度固定)
                        CGFloat scale = image.size.width / image.size.height;
                        CGFloat height = weakSelf.waterflowLayout.rowHeight;
                        CGFloat width = height * scale;
                        NSNumber *widthNum = [NSNumber numberWithFloat:width];
                        [weakSelf.widths addObject:widthNum];
                    }
                    if (weakSelf.widths.count == weakSelf.allImageUrls.count) {
                        // 赋值所有cell的宽度数组itemWidths
                        weakSelf.waterflowLayout.itemWidths = weakSelf.widths;
                        [weakSelf.collectionView reloadData];
                    }
                }else if (weakSelf.type == VerticalType) {
                    if (weakSelf.heights.count < weakSelf.allImageUrls.count) {
                        
                        // 根据图片原始比例 计算 当前图片的高度(宽度固定)
                        CGFloat scale = image.size.height / image.size.width;
                        CGFloat width = weakSelf.waterflowLayout.itemWidth;
                        CGFloat height = width * scale + 50;
                        NSNumber *heightNum = [NSNumber numberWithFloat:height];
                        [weakSelf.heights addObject:heightNum];
                    }
                    if (weakSelf.heights.count == weakSelf.allImageUrls.count) {
                        // 赋值所有cell的高度数组itemHeights
                        weakSelf.waterflowLayout.itemHeights = weakSelf.heights;
                        [weakSelf.collectionView reloadData];
                    }
                }
            }
        }];
    }
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.allImageUrls.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ID = nil;
    if (indexPath.item == 0) {
        ID = identyfy1;
    }
    else
    {
        ID = identyfy;
    }
    
    if (indexPath.item == 0) {
        GoodsHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
        for (id subView in cell.contentView.subviews) {
            if (subView){
                [subView removeFromSuperview];
            }
        }
        cell.imageView.image = self.picImageArr[indexPath.item];
        // 注：非常关键的一句，由于cell的复用，imageView的frame可能和cell对不上，需要重新设置。
        cell.imageView.frame = CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height);
        return cell;
    }else{
        
        NSLog(@"indexPath.item = %ld",(long)indexPath.item);
        WaterFlowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
        for (id subView in cell.contentView.subviews) {
            if (subView){
                [subView removeFromSuperview];
            }
        }
        GoodsModel *goods = self.productDataSource[indexPath.item - 1];
        if (self.picImageArr.count > 0) {
            cell.imageView.image = self.picImageArr[indexPath.item];
            cell.proTitle.text = goods.goods_name;
        }
        // 注：非常关键的一句，由于cell的复用，imageView的frame可能和cell对不上，需要重新设置。
        cell.imageView.frame = CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height - 50);
        
        cell.proTitle.frame = CGRectMake(5, cell.bounds.size.height - 45, cell.bounds.size.width - 10, 21);
        return cell;
    }
    
    
}

- (void)configure:(WaterFlowCollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma  mark --------------------------- 懒加载  --------------------------
- (NSMutableArray *)picImageArr {
    
    if (!_picImageArr) {
        _picImageArr = [[NSMutableArray alloc] init];
    }
    return _picImageArr;
}

- (NSMutableArray *)heights {
    
    if (!_heights) {
        _heights = [[NSMutableArray alloc] init];
    }
    return _heights;
}

- (NSMutableArray *)widths {
    
    if (!_widths) {
        _widths = [[NSMutableArray alloc] init];
    }
    return _widths;
}

- (NSMutableArray *)allImageUrls {
    
    if (!_allImageUrls) {
        _allImageUrls = [[NSMutableArray alloc] init];
    }
    return _allImageUrls;
}
- (NSMutableArray *)productDataSource
{
    if (_productDataSource == nil) {
        _productDataSource = [[NSMutableArray alloc] init];
    }
    return _productDataSource;
}

- (NSMutableArray *)imageUrls {
    
    if (!_imageUrls) {
        //        _imageUrls = @[@"https://pic.lehe.com/pic/_o/b2/6c/659cdc1a5641d640e9ce52b91f18_758_758.cz.jpg",@"https://pic.lehe.com/pic/_o/5c/16/405aeb5fc4a61c538fe509363ee5_750_750.cz.jpg",@"https://pic.lehe.com/pic/_o/48/21/1574bf5503229e8d80358cd06397_750_750.cz.jpg",@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=234585439,3333907919&fm=26&gp=0.jpg",@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2925221621,897648468&fm=26&gp=0.jpg",@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2322675046,322562068&fm=26&gp=0.jpg",@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1425896198,3673504788&fm=26&gp=0.jpg",@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1595255292,359939224&fm=26&gp=0.jpg",@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2106581209,668606458&fm=26&gp=0.jpg",@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3641103117,2548708300&fm=26&gp=0.jpg",@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3129475260,3293971430&fm=26&gp=0.jpg"];
        
        _imageUrls =  [[NSMutableArray alloc] init];
    }
    return _imageUrls;
}

- (void)dealloc {
    NSLog(@"dealloc");
}


@end
