//
//  HHQzoneAlert.m
//  Flower
//
//  Created by 花花 on 2016/12/15.
//  Copyright © 2016年 花花. All rights reserved.
//

#import "HHQzoneAlert.h"
#import "HHQzoneAlertView.h"
#define HHcellHeight 44
#define HHdefaultViewHeight  2 * HHcellHeight
@interface HHQzoneAlert()<HHQzoneAlertViewDetegate>{

     shareCellOperationOnClick  _shareCellOnClick;
    
     listCellOPerationOnclick  _listOnClick;

}

@property(nonatomic, weak) UIView *coverView;

@property(nonatomic, strong) HHQzoneAlertView *alertView;


@end
@implementation HHQzoneAlert

+ (instancetype)shareQzoneAlert{

    static HHQzoneAlert *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance =[[self alloc]init];
    });

    return instance;

}

-(void)show:(CGFloat )yy{

    [self show:yy array:nil];
    
}

-(void)show:(CGFloat)yy array:(NSArray<NSDictionary *>*)array{

    //x:screen_width  - 2 * margin 制造出从右边出来有点动画的感觉
    self.alertView = [[HHQzoneAlertView alloc]initWithFrame:CGRectMake(screen_width  - 2 * margin, yy, screen_width - 2 *margin, array?array.count *HHcellHeight:HHdefaultViewHeight)];
    
    self.alertView.delegate = self;
    self.alertView.layer.cornerRadius = 10;
    self.alertView.layer.masksToBounds = YES;
    if (array) {
        for (id obj in array) {
            NSAssert([obj isKindOfClass:[NSDictionary class]], @"请确定数组的元素都是NSDictionary对象？？？");
        }
        for (NSDictionary *dic in array) {
            [self.alertView.listArr addObject:dic];
            
        }
    }else{
        [self.alertView.listArr addObject: @{HHAlertViewLeftImageKey : @"share-1",
                                              HHAlertViewTitleLabelKey:@"分分",
                                              HHAlertViewCellTypeKey:@(HHQzoneAlertCellTypeShare)}];
    
        [self.alertView.listArr  addObject: @{HHAlertViewLeftImageKey:@"share-2",HHAlertViewTitleLabelKey:@"钟钟"}];
    
    }
    
    [self.alertView.tableView reloadData];
[self setupCover:yy array:array];

}

-(void)setupCover:(CGFloat)yy array:(NSArray *)array{

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *coverView =[[UIView alloc]initWithFrame:window.bounds];
    coverView.backgroundColor = [UIColor grayColor];
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickDismss)];
    [coverView addGestureRecognizer:tap];
    [window addSubview:coverView];
    [window addSubview:self.alertView];
    coverView.alpha = 0.0;
    self.alertView.alpha = 0.0;
    [UIView animateWithDuration:0.2 animations:^{
        
        self.alertView.alpha = 0.3;
        coverView.alpha = 0.1;
        [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:1.0 options:0 animations:^{
            self.alertView.alpha = 0.6;
            self.alertView.frame = CGRectMake(margin, yy, screen_width -2 * margin, array? array.count * HHcellHeight :HHdefaultViewHeight);
            coverView.alpha = 0.2;
        } completion:^(BOOL finished) {
            self.alertView.alpha = 1.0;
            coverView.alpha = 0.3;
        }];
        
    } completion:nil];

}
-(void)clickDismss{

    [self dismiss];

}

-(void)showAround:(UIView *)view{

    [self showAround:view array:nil];

}

-(void)showAround:(UIView *)view array:(NSArray<NSDictionary *>*)array{
   
    CGRect rect = [view convertRect:view.frame toView:[UIApplication sharedApplication].keyWindow];
    CGFloat padding = screen_height - rect.origin.y;
    CGFloat y = 0.0;
    /*测试数据
     rect{{758, 94}, {20, 20}   642   1   下
     rect{{758, 174}, {20, 20} 562   2   下
     rect{{680, 444}, {20, 20}} 223   223>220  此时底部会会挡住 故再减去 20 刚刚好的样子
     */
    NSLog(@"rect%@/n-----%f--------",NSStringFromCGRect(rect),padding);
    //// 显示在下面  避免底部被挡住
    if (padding >(array? array.count * HHcellHeight : HHdefaultViewHeight) +40) {
        y = rect.origin.y + view.bounds.size.height -20;
    }else{ //   显示在上面 底部至少有20的间距
        y = rect.origin.y - (array? array.count *HHcellHeight: HHdefaultViewHeight)-20;
    
    }
    
    [self show:y array:array];
}

-(void)dismiss{

    UIWindow *window =[UIApplication sharedApplication].keyWindow;
    for (int i = 0; i< 2; i++) {
        UIView *view =  window.subviews.lastObject;
        [view removeFromSuperview];
    }
}
- (void)shareButtonOnClick:(NSInteger)index alertView:(HHQzoneAlertView *)alertView{

    _shareCellOnClick(index);
    [self dismiss];
}


-(void)setshareCellOperationOnClick:(shareCellOperationOnClick)shareCellOnClick{

    _shareCellOnClick = shareCellOnClick;
    

}
-(void)setlistCellOPerationOnclick:(listCellOPerationOnclick)listCellOnClick{

    _listOnClick = listCellOnClick;

}


- (void)listCellHandler:(NSInteger)row alertView:(HHQzoneAlertView *)alertView{

    
    _listOnClick(row);
    [self dismiss];
}

@end
