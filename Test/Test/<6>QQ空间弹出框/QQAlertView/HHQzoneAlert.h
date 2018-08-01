//
//  HHQzoneAlert.h
//  Flower
//
//  Created by 花花 on 2016/12/15.
//  Copyright © 2016年 花花. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger,HHQzoneAlertCellType){
      HHQzoneAlertCellTypeList,
     HHQzoneAlertCellTypeShare
};
typedef void(^shareCellOperationOnClick)(NSInteger index);
typedef void(^listCellOPerationOnclick)(NSInteger row);
@interface HHQzoneAlert : NSObject



+ (instancetype)shareQzoneAlert;


/**
   显示在指定的位置 指定的y值
  例如:中心位置
 CGFloat  self_height= self.view.frame.size.height;
 CGFloat  self_center= self_height/2;
 
 */

-(void)show:(CGFloat )yy;

/**
 *  显示在指定位置   指定的y值
 *  @param array 字典数组（指定key的字典）
 */
-(void)show:(CGFloat)yy array:(NSArray<NSDictionary *>*)array;


//-(void)showAround:(UIView *)view;


/*
 *  根据弹窗的高度自适应弹窗的显示位置，在view的上面还是下面
 *  @param view 指定的view
 *  @param array  字典数组（指定key的字典）
 
 */
-(void)showAround:(UIView *)view array:(NSArray<NSDictionary *>*)array;

//消失弹窗
-(void)dismiss;


-(void)setshareCellOperationOnClick:(shareCellOperationOnClick)shareCellOnClick;
-(void)setlistCellOPerationOnclick:(listCellOPerationOnclick)listCellOnClick;

@end
