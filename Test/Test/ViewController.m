//
//  ViewController.m
//  Test
//
//  Created by Mac on 2018/8/1.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "HHQQAlertViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnOnClick {
    
    
    HHQQAlertViewController *vc = [[HHQQAlertViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end
