//
//  CarDetailView.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/12/3.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarDetailStatusView : UIView

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelCar *)model auditRecord:(ModelAuditRecord *)modelAudit;
@end



@interface CarDetailImageView : UIView
@property (nonatomic, strong) NSArray *aryImages;

#pragma mark 刷新view
- (void)resetViewWithAryModels:(NSArray *)aryImages;
@end
