//
//  HHQQAlertViewController.m
//  Flower
//
//  Created by 花花 on 2016/12/14.
//  Copyright © 2016年 花花. All rights reserved.
//

#import "HHQQAlertViewController.h"
#import "Pucker2Cell.h"
#import "HHQzoneAlert.h"
@interface HHQQAlertViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) NSMutableArray *ArrData;
@property(nonatomic, strong) UITableView *tableView;
@end

static NSString *const cellID = @"cellID";
@implementation HHQQAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    self.tableView =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    
    
        [self.tableView registerNib:[UINib nibWithNibName:(NSStringFromClass([Pucker2Cell class])) bundle:nil] forCellReuseIdentifier:cellID];
    _ArrData = @[].mutableCopy;
    
    [self.view addSubview:self.tableView];
    
    for (int i = 0; i<30; i++) {
        
        [self.ArrData addObject:[NSString stringWithFormat:@"好一朵美丽茉莉花%zd",i]];
    }
 
}


#pragma mark - <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

 return   self.ArrData.count;

}
/**显示在指定的位置 指定的y值 例如中心位置  显示默认的  不传数组进去
 第一种:[[HHQzoneAlert shareQzoneAlert]show:<#(CGFloat)#>
 CGFloat  self_height= self.view.frame.size.height-64;
 CGFloat  self_center= self_height/2;
 [[HHQzoneAlert shareQzoneAlert]show:self_center];
 
 
 
 [[HHQzoneAlert shareQzoneAlert]show:<#(CGFloat)#> array:<#(NSArray<NSDictionary *> *)#>
 CGFloat  self_height= self.view.frame.size.height-64;
 CGFloat  self_center= self_height/2;
 [[HHQzoneAlert shareQzoneAlert]show:self_center array:arr];
 
 
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Pucker2Cell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    cell.shuoshuo.hidden = YES;
    cell.name.text = self.ArrData[indexPath.row];
    [cell setdownOnClick:^(Pucker2Cell *cell, UIButton *btn) {
        NSArray *arr = @[
                         @{HHAlertViewLeftImageKey:@"qzone-1",HHAlertViewTitleLabelKey:@"分享",
                           HHAlertViewCellTypeKey : @(HHQzoneAlertCellTypeShare)},
                         @{HHAlertViewLeftImageKey:@"qzone-2",HHAlertViewTitleLabelKey:@"收藏"},
                         @{HHAlertViewLeftImageKey:@"qzone-3",HHAlertViewTitleLabelKey:@"转载照片"},
                         @{HHAlertViewLeftImageKey:@"qzone-4",HHAlertViewTitleLabelKey:@"隐藏此条动态"},
                         @{HHAlertViewLeftImageKey:@"qzone-5",HHAlertViewTitleLabelKey:@"不看他的动态"},
                         ];
        [[HHQzoneAlert shareQzoneAlert] showAround:btn array:arr];
    
        [[HHQzoneAlert shareQzoneAlert]setlistCellOPerationOnclick:^(NSInteger row) {
            NSDictionary *dic = arr[row];
            NSLog(@"%@------",dic[HHAlertViewTitleLabelKey]);
//             [self showHudAutoHideString:dic[HHAlertViewTitleLabelKey]];
        }];
     
        [[HHQzoneAlert shareQzoneAlert] setshareCellOperationOnClick:^(NSInteger index) {
            NSString *text;
            switch (index) {
                case 0:
                    text = @"QQ分享";
                    break;
                    
                case 1:
                    text = @"微信分享";
                    break;
                default:
                    text = @"朋友圈分享";
                    break;
            }
            
            NSLog(@"%@------",text);
//            [self showHudAutoHideString:text];
        }];
        }];
  
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 80;
}


@end
