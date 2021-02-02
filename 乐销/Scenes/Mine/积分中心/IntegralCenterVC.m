//
//  IntegralCenterVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/22.
//Copyright © 2020 ping. All rights reserved.
//

#import "IntegralCenterVC.h"
#import "IntegralCenterView.h"
#import "IntegralCollectionCell.h"
#import "UICollectionWaterLayout.h"
#import "IntegralProductDetailVC.h"
#import "ExchangeIntegraOrderListVC.h"
//request
#import "RequestDriver2.h"
@interface IntegralCenterVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) NSMutableArray *aryDatas;
@property (nonatomic, strong) IntegralCenterTopView *topView;

@end

@implementation IntegralCenterVC


#pragma mark lazy init
- (IntegralCenterTopView *)topView{
    if (!_topView) {
        _topView = [IntegralCenterTopView new];
        WEAKSELF
        _topView.blockSign = ^{
            [weakSelf requestSign];
        };
    }
    return _topView;
}

#pragma mark-----  设置collectionview
- (UICollectionView *)myCollectionView {
    if (!_myCollectionView) {
        // 1.流水布局
        // 6.创建UICollectionView
        UICollectionWaterLayout *layout = [UICollectionWaterLayout layoutWithColoumn:2 data:self.aryDatas verticleMin:W(15) horizonMin:W(15) leftMargin:W(15) rightMargin:W(15)];

        _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT- NAVIGATIONBAR_HEIGHT) collectionViewLayout:layout];
        // 7.设置collectionView的背景色
        _myCollectionView.backgroundColor = COLOR_BACKGROUND;
        // 8.设置代理
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.scrollEnabled = YES;
        _myCollectionView.showsVerticalScrollIndicator = false;
        // 9.注册cell(告诉collectionView将来创建怎样的cell)
        [_myCollectionView registerClass:[IntegralCollectionCell class] forCellWithReuseIdentifier:@"IntegralCollectionCell"];
        [_myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];
        [_myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
        
    }
    return _myCollectionView;
}

#pragma mark view dited load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.view addSubview:self.myCollectionView];
    [self.myCollectionView addSubview:self.topView];
    //request
    [self requestList];
    [self reqeustSignNum];
}

#pragma mark 添加导航栏



#pragma mark - UICollectionView数据源方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.aryDatas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 1.获得cell
    IntegralCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IntegralCollectionCell" forIndexPath:indexPath];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}

#pragma mark - 代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    IntegralProductDetailVC * vc =[IntegralProductDetailVC new];
    [GB_Nav pushViewController:vc animated:true];
}


#pragma mark request
- (void)requestList{
//   RequestApi requestin 
    UICollectionWaterLayout *layout = [UICollectionWaterLayout layoutWithColoumn:2 data:self.aryDatas verticleMin:W(15) horizonMin:W(15) leftMargin:W(15) rightMargin:W(15)];
    self.myCollectionView.collectionViewLayout = layout;

    [self.myCollectionView reloadData];
   
}


#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"积分商城" rightTitle:@"订单" rightBlock:^{
        ExchangeIntegraOrderListVC * vc = [ExchangeIntegraOrderListVC new];
        [GB_Nav pushViewController:vc animated:true];
    }];
    [nav configBackBlueStyle];
    [self.view addSubview:nav];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)requestSign{
    [RequestApi requestSignWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"签到成功"];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
}
- (void)reqeustSignNum{
    [RequestApi requestIntegralNumWithDelegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.topView.point = [response doubleValueForKey:@"point"];
        [RequestApi requestSignListDelegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            
            NSArray * aryResponse = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelSignItem"];
            NSDictionary * dicResponse = [aryResponse exchangeDicWithKeyPath:@"strWeekShow"];
            NSMutableArray * aryReturn = [NSMutableArray array];
            NSArray * aryTitle = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
            BOOL isAfter = false;
            for (NSString * str in aryTitle) {
                ModelBaseData * item = [ModelBaseData new];
                item.string = str;
                if (isAfter) {
                    item.enumType = -1;
                }else if ([dicResponse valueForKey:str]) {
                    item.enumType = 1;
                }else {
                    item.enumType = 0;
                }
                [aryReturn addObject:item];
                if ([str isEqualToString:[NSDate date].weekdayStr_sld]) {
                    isAfter = true;
                }
            }
            [self.topView resetViewWithModel:aryReturn];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    
}
@end
