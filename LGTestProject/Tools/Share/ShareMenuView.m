//
//  ShareMenuView.m
//  SmartMall
//
//  Created by liugang on 2020/8/18.
//  Copyright © 2020 DeveLoper. All rights reserved.
//

#import "ShareMenuView.h"
#import "ShareItemCollectionViewCell.h"

#define kScreenHeight         [UIScreen mainScreen].bounds.size.height                          //屏幕高度
#define kScreenWidth          [UIScreen mainScreen].bounds.size.width                           //屏幕宽度

@interface ShareMenuView ()

@property (weak, nonatomic) IBOutlet UIView *dimView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showViewBottomConstraint;
@property (weak, nonatomic) IBOutlet UIView *showView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuRightConstraint;
@property (weak, nonatomic) IBOutlet UICollectionView *menuCollectionView;



@end

@implementation ShareMenuView

- (void)awakeFromNib
{
    [super awakeFromNib];
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(70, 90);
//    layout.minimumLineSpacing = SCREEN_WIDTH - (4* 58);
    CGFloat margin = (SCREEN_WIDTH - 70 *4)/5;
    layout.minimumLineSpacing = margin;
    layout.sectionInset = UIEdgeInsetsMake(5, margin, 5, margin);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [_menuCollectionView setCollectionViewLayout:layout];
    _menuCollectionView.delegate = self;
    _menuCollectionView.dataSource = self;
    _menuCollectionView.showsHorizontalScrollIndicator = YES;
    [_menuCollectionView registerNib:[UINib nibWithNibName:@"ShareItemCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShareItemCollectionViewCell"];
    //给遮罩添加手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [_dimView addGestureRecognizer:tap];
    
}


#pragma mark - UICollectionViewDelegate && UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageNameList.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShareItemCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShareItemCollectionViewCell" forIndexPath:indexPath];
    [cell setCellRelationDataTitle:_titleNameList[indexPath.row] imageTitle:_imageNameList[indexPath.row]];
//    cell.backgroundColor = UIColor.redColor;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了cell");
    [self shareMenuViewHidden];
    self.menuViewDidSelectedBlock(indexPath.row);
  
}

- (void)shareMenuViewShow
{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:.28 animations:^{
        self.showViewBottomConstraint.constant = 0;
        [self.showView updateConstraints];
        [self layoutIfNeeded];

    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.28 animations:^{
            self.dimView.alpha = .4;
        }completion:^(BOOL finished) {
            
        }];
    }];
}

- (void)shareMenuViewHidden
{
    [UIView animateWithDuration:.28 animations:^{
        self.dimView.alpha = 0;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:.28 animations:^{
            self.showViewBottomConstraint.constant = -375;
            [self.showView updateConstraints];
            [self layoutIfNeeded];

        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];

    }];
}

- (IBAction)cancelClick:(UIButton *)sender {
    [self shareMenuViewHidden];
}

- (void)tapClick:(UIGestureRecognizer *)tap
{
    [self shareMenuViewHidden];
}

@end
