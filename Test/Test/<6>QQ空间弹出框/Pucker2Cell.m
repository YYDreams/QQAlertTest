//
//  Pucker2Cell.m
//  PuckerTableView
//
//  Created by LOVE on 16/7/27.
//  Copyright © 2016年 LOVE. All rights reserved.
//

#import "Pucker2Cell.h"

@interface Pucker2Cell ()


@property(nonatomic, copy) downOnClick downOnclick;

@end
@implementation Pucker2Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)downOnlick:(UIButton *)sender {

    
    if (self.downOnclick) {
        self.downOnclick(self,sender);
    }
}

-(void)setdownOnClick:(downOnClick)downOnClick{

    _downOnclick = downOnClick;
    

}
@end
