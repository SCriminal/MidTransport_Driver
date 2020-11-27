//
//  AutoConfigOrderListVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/11/27.
//Copyright © 2020 ping. All rights reserved.
//

#import "AutoConfigOrderListVC.h"
#import "AutoConfigOrderListCell.h"
//request
#import "RequestApi+Order.h"
//detail
#import "OrderDetailVC.h"
//operate
#import "DriverOperateVC.h"
//bottom view
#import "OrderManagementBottomView.h"

@interface AutoConfigOrderListVC ()
@property (nonatomic, strong) AutoConfigOrderListFilterView *filterView;

@end

@implementation AutoConfigOrderListVC
@synthesize noResultView = _noResultView;
#pragma mark lazy init
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        _noResultView.verticalModify = -HEIGHT_ORDERMANAGEMENTBOTTOMVIEW/2.0;
        [_noResultView resetWithImageName:@"empty_waybill_default" title:@"暂无运单信息"];
    }
    return _noResultView;
}
- (AutoConfigOrderListFilterView *)filterView{
    if (!_filterView) {
        _filterView = [AutoConfigOrderListFilterView new];
        _filterView.top = NAVIGATIONBAR_HEIGHT;
    }
    return _filterView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //table
    BaseNavView * nav = [BaseNavView initNavTitle:@"智能配货" leftImageName:@"nav_auto" leftImageSize:CGSizeMake(W(23), W(23)) leftBlock:^{
        
    } rightTitle:@"我的报价" righBlock:^{
        
    }];
    [nav configBlueStyle];
    [self.view addSubview:nav];
    
    [self.view addSubview:self.filterView];
    [self.tableView registerClass:[AutoConfigOrderListCell class] forCellReuseIdentifier:@"AutoConfigOrderListCell"];
    self.tableView.frame = CGRectMake(0, self.filterView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.filterView.bottom - TABBAR_HEIGHT);

    self.tableView.backgroundColor = COLOR_BACKGROUND;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, W(12), 0);
    [self addRefreshHeader];
    [self addRefreshFooter];
    //request
    [self requestList];
}


#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AutoConfigOrderListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AutoConfigOrderListCell"];
    [cell resetCellWithModel: self.aryDatas[indexPath.row]];
    WEAKSELF
    cell.blockDetail = ^(ModelOrderList *model) {
        [weakSelf jumpToDetail:model];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [AutoConfigOrderListCell fetchHeight:self.aryDatas[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelOrderList * model = self.aryDatas[indexPath.row];
    [self jumpToDetail:model];
}
- (void)jumpToDetail:(ModelOrderList *)model{
    DriverOperateVC * operateVC = [DriverOperateVC new];
    operateVC.modelOrder = model;
    WEAKSELF
    operateVC.blockBack = ^(UIViewController *vc) {
        [weakSelf refreshHeaderAll];
    };
    [GB_Nav pushViewController:operateVC animated:true];
}
#pragma mark request
- (void)requestList{
    NSString * strOrderType = nil;
    int sortCreateTime = 1;
    int sortAcceptTime = 1;
    int sortFinishTime = 1;
    strOrderType = @"610";
              sortFinishTime = 3;
    [RequestApi requestOrderListWithWaybillnumber:nil
                                       categoryId:0
                                            state:strOrderType
                                         blNumber:0
                                 shippingLineName:nil
                                       oceanVesel:nil
                                     voyageNumber:nil
                                     startContact:nil
                                       startPhone:nil
                                       endContact:nil endPhone:nil closingStartTime:0 closingEndTime:0 placeEnvName:nil placeStartTime:0 placeEndTime:0 placeContact:nil createStartTime:0 createEndTime:0 acceptStartTime:0 acceptEndTime:0 finishStartTime:0 finishEndTime:0 stuffStartTime:0 stuffEndTime:0 toFactoryStartTime:0 toFactoryEndTime:0 handleStartTime:0 handleEndTime:0
                                             page:self.pageNum
                                            count:50
                                            entId:0
                                   sortAcceptTime:sortAcceptTime
                                   sortFinishTime:sortFinishTime
                                   sortCreateTime:sortCreateTime
                                         delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelOrderList"];
        
        if (self.isRemoveAll) {
            [self.aryDatas removeAllObjects];
        }
        if (!isAry(aryRequest)) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.aryDatas addObjectsFromArray:aryRequest];
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
