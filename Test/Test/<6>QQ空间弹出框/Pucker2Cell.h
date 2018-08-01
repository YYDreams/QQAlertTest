//
//  Pucker2Cell.h
//  PuckerTableView
//
//  Created by LOVE on 16/7/27.
//  Copyright © 2016年 LOVE. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Pucker2Cell;
@protocol Pucker2CellDelegate <NSObject>

@optional
-(void)click:(UIButton *)btn showAlertView:(Pucker2Cell *)cell;


@end
//
@interface Pucker2Cell : UITableViewCell
typedef void(^downOnClick)(Pucker2Cell *cell,UIButton *btn);
@property(nonatomic, weak) id<Pucker2CellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *is_on_line;
@property (weak, nonatomic) IBOutlet UILabel *shuoshuo;

//由于qq列表和 QQ空间都是用的此cell所有
@property (weak, nonatomic) IBOutlet UIButton *downbtn;

-(void)setdownOnClick:(downOnClick)downOnClick;
@end
