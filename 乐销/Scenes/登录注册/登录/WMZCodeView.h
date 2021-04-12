//
//  WMZCodeView.h
//  WMZCode
//
//  Created by wmz on 2018/12/14.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^callBack) (BOOL success);

NS_ASSUME_NONNULL_BEGIN

@interface WMZCodeView : UIView

/*
 * 初始化
 */
+ (instancetype)shareInstance;

/*
 * 调用方法
 *
 * @param  CodeType  类型
 * @param  name      背景图
 * @param  rect      frame
 * @param  block     回调
 *
 */
- (WMZCodeView*)addCodeViewWithType:(int)type
                      withImageName:(NSString*)name
                          witgFrame:(CGRect)rect
                          withBlock:(callBack)block;

@end



@interface WMZSlider : UISlider

@property(nonatomic,strong)UILabel *label;

@end


@interface UIImage (Expand)

///截取当前image对象rect区域内的图像
-(UIImage *)dw_SubImageWithRect:(CGRect)rect;

///压缩图片至指定尺寸
-(UIImage *)dw_RescaleImageToSize:(CGSize)size;

///按给定path剪裁图片
/**
 path:路径，剪裁区域。
 mode:填充模式
 */
-(UIImage *)dw_ClipImageWithPath:(UIBezierPath *)path;

//裁剪图片
- (UIImage*)imageScaleToSize:(CGSize)size;

@end


NS_ASSUME_NONNULL_END
