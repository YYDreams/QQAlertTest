//
//  HHQzoneAlertView.h
//  Flower
//
//  Created by 花花 on 2016/12/15.
//  Copyright © 2016年 花花. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HHQzoneAlertView;
@protocol HHQzoneAlertViewDetegate <NSObject>


/**
  点击分享按钮的响应事件

 @param index btn.tag
 @param alertView <#alertView description#>
 */
- (void)shareButtonOnClick:(NSInteger)index alertView:(HHQzoneAlertView *)alertView;


/**
 点击cell的响应事件

 @param row 点击的row
 @param alertView <#alertView description#>
 */
- (void)listCellHandler:(NSInteger)row alertView:(HHQzoneAlertView *)alertView;
@end

@interface HHQzoneAlertView : UIView

@property(nonatomic, weak) id<HHQzoneAlertViewDetegate>delegate;

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSMutableArray *listArr;

@end
