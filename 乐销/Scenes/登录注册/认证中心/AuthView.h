//
//  AuthView.h
//  Driver
//
//  Created by 隋林栋 on 2020/12/15.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthView : UIView

#pragma mark 刷新view
- (void)resetViewWithModel:(int)index;

@end

@interface AuthTitleView : UIView

#pragma mark 刷新view
- (void)resetViewWithModel:(NSString *)title;

@end

@interface AuthBtnView : UIView
@property (nonatomic, strong) void (^blockConfirmClick)(void);
@property (nonatomic, strong) void (^blockDismissClick)(void);
- (void)resetViewWithModel:(BOOL)isFirst;

@end
