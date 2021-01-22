//
//  RequestApi+Plan.h
//  Driver
//
//  Created by 隋林栋 on 2021/1/21.
//  Copyright © 2021 ping. All rights reserved.
//

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestApi (Plan)

+(void)requestAutoOrderListWithMode:(NSString *)mode
                startAreaId:(NSString *)startAreaId
                endAreaId:(NSString *)endAreaId
                createStartTime:(double)createStartTime
                createEndTime:(double)createEndTime
                page:(double)page
                count:(double)count
                lat:(NSString *)lat
                lng:(NSString *)lng
                sort:(double)sort
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure;

/**
最新货源
*/
+(void)requestNewOrderListWithStartareaid:(double)startAreaId
                endAreaId:(double)endAreaId
                page:(double)page
                count:(double)count
                vehicleTypeId:(double)vehicleTypeId
                mode:(double)mode
                lat:(NSString *)lat
                lng:(NSString *)lng
                sort:(double)sort
                          vehicleTypeCode:(NSString *)vehicleTypeCode
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestOrderListWithPage:(double)page
                count:(double)count
                orderNumber:(NSString *)orderNumber
                shipperName:(NSString *)shipperName
                plateNumber:(NSString *)plateNumber
                driverName:(NSString *)driverName
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                        failure:(void (^)(NSString * errorStr, id mark))failure;


/**
计划单详情(司机)
*/
+(void)requestPlanDetailWithNumber:(NSString *)number
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;

/**
扫码(抢单)
*/
+(void)requestPlanRobWithPlannumber:(NSString *)planNumber
                vehicleId:(double)vehicleId
                qty:(double)qty
                price:(double)price
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure;

/**
扫码(报价)
*/
+(void)requestPlanPriceWithPlannumber:(NSString *)planNumber
                vehicleId:(double)vehicleId
                qty:(double)qty
                price:(double)price
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure;
@end

NS_ASSUME_NONNULL_END
