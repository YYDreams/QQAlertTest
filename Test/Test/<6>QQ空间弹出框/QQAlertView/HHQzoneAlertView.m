//
//  HHQzoneAlertView.m
//  Flower
//
//  Created by 花花 on 2016/12/15.
//  Copyright © 2016年 花花. All rights reserved.
//

#import "HHQzoneAlertView.h"


#pragma mark - -------------HHQzoneAlertListCell---------------

@interface HHQzoneAlertListCell : UITableViewCell

@property(nonatomic, strong) UIImageView *leftImageView;
@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation HHQzoneAlertListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        [self addSubview:self.leftImageView];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat cell_height = self.frame.size.height;
    
    CGFloat cell_width = self.frame.size.width;
    
    CGFloat img_WH = cell_height * 0.5;
    
    CGFloat title_height = cell_height * 0.6;
    
    self.leftImageView.frame = CGRectMake(2 *margin, (cell_height -img_WH)/2, img_WH, img_WH);
    
    CGFloat title_width = CGRectGetMaxX(self.leftImageView.frame) + 2 * margin;
    
    self.titleLabel.frame = CGRectMake(title_width, (cell_height-title_height)/2, cell_width -title_width, title_height);
    
}

#pragma mark - Setter && Getter
-(UIImageView *)leftImageView{

    if (!_leftImageView) {
        _leftImageView =[UIImageView new];
    }
    return _leftImageView;
}

-(UILabel *)titleLabel{

    if (!_titleLabel) {
        _titleLabel =[UILabel new];
    }
    return _titleLabel;
}
@end

#pragma mark - -------------HHQzoneAlertShareCell---------------

@class HHQzoneAlertShareCell;
@protocol HHQzoneAlertShareCellDelegate <NSObject>
@optional
- (void)clickIndex:(NSInteger)index shareCell:(HHQzoneAlertShareCell *)shareCell;

@end
@interface HHQzoneAlertShareCell : HHQzoneAlertListCell

//存放btn(qq,微信，朋友)的数组
@property(nonatomic, strong) NSMutableArray *sharebtnArr;
//代理
@property(nonatomic, weak) id<HHQzoneAlertShareCellDelegate>delegate;

@end

@implementation HHQzoneAlertShareCell

#pragma mark - Init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self commonInit]; 
    }

    return self;

}
#pragma mark - layoutSubviews
- (void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat cell_height = self.frame.size.height;
    CGFloat cell_width = self.frame.size.width;
    CGFloat shareWH = cell_height *0.65;

    UIButton *sharebtn1 =  self.sharebtnArr[self.sharebtnArr.count -1];
    sharebtn1.frame = CGRectMake(cell_width -shareWH- margin, (cell_height -shareWH)/2, shareWH, shareWH);
    
    UIButton *shrebtn2 = self.sharebtnArr[self.sharebtnArr.count -2];
    shrebtn2.frame = CGRectMake(cell_width - (shareWH + margin) *2 - 20, (cell_height - shareWH)/2, shareWH, shareWH);
    
    UIButton *shrebtn3 = self.sharebtnArr[self.sharebtnArr.count -3 ];
    shrebtn3.frame = CGRectMake(cell_width - (shareWH + margin) *3 - 20 -20, (cell_height - shareWH)/2, shareWH, shareWH);

}
#pragma mark - commonInit
-(void)commonInit{
    for (int i = 0 ; i<3; i++) {
        UIButton *sharebtn =[[UIButton alloc]init];
        [sharebtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"share-%d",i]] forState:UIControlStateNormal];
        [sharebtn setTag:i];
        sharebtn.backgroundColor =[UIColor orangeColor];
        [sharebtn addTarget:self action:@selector(shareOnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:sharebtn];
        [self.sharebtnArr addObject:sharebtn];
    }
}

#pragma mark - SEL Method
-(void)shareOnClick:(UIButton *)sharebtn{

    if ([self.delegate respondsToSelector:@selector(clickIndex:shareCell:)]) {
        [self.delegate clickIndex:sharebtn.tag shareCell:self];
    }
}
#pragma mark - Setter && Getter
-(NSMutableArray *)sharebtnArr{

    if (!_sharebtnArr) {
        _sharebtnArr = [NSMutableArray array];
    }
    
    return _sharebtnArr;
}
@end

#pragma mark - -------------HHQzoneAlertView---------------
@interface HHQzoneAlertView ()<UITableViewDataSource,UITableViewDelegate,HHQzoneAlertShareCellDelegate>

@end

static NSString *const listCellID = @"listCellID";
static NSString *const shareCellID = @"shareCellID";
@implementation HHQzoneAlertView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame{

    if (self =[super initWithFrame:frame]) {
        
        [self addSubview:self.tableView];
        [self.tableView registerClass:[HHQzoneAlertListCell class] forCellReuseIdentifier:listCellID];
        [self.tableView registerClass:[HHQzoneAlertShareCell class] forCellReuseIdentifier:shareCellID];
    }
    return self;
}
#pragma mark - <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.listArr.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *dict  = self.listArr[indexPath.row];
    NSNumber *number = dict[HHAlertViewCellTypeKey];
    
    if (number == nil) {
   
        HHQzoneAlertListCell *cell =[tableView dequeueReusableCellWithIdentifier:listCellID];
        NSDictionary *dic = self.listArr[indexPath.row];
        NSString *imageName = dic[HHAlertViewLeftImageKey];
        NSString *titleLabel = dic[HHAlertViewTitleLabelKey];
        cell.leftImageView.image =[UIImage imageNamed:imageName];
        cell.titleLabel.text = titleLabel;
        
        return cell;
    }
    
    switch (number.integerValue) {
        case 0:{
            HHQzoneAlertListCell *cell =[tableView dequeueReusableCellWithIdentifier:listCellID];
            NSDictionary *dic = self.listArr[indexPath.row];
            NSString *imageName = dic[HHAlertViewLeftImageKey];
            NSString *titleLabel = dic[HHAlertViewTitleLabelKey];
            cell.leftImageView.image =[UIImage imageNamed:imageName];
            cell.titleLabel.text = titleLabel;
            return cell;
        }
            
            break;
        case 1:{
        HHQzoneAlertShareCell *cell = [tableView dequeueReusableCellWithIdentifier:shareCellID];
            NSDictionary *dic = self.listArr[indexPath.row];
            NSString *imageName = dic[HHAlertViewLeftImageKey];
            NSString *titleLabel =dic[HHAlertViewTitleLabelKey];
            cell.leftImageView.image =[UIImage imageNamed:imageName];
            cell.titleLabel.text = titleLabel;
            cell.delegate = self;
            return cell;
        }
            break;
        default:
            return nil;
            break;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell  =[tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell isKindOfClass:[HHQzoneAlertShareCell class]]) {
        
    }else{
        
        if ([self.delegate respondsToSelector:@selector(listCellHandler:alertView:)]) {
            [self.delegate listCellHandler:indexPath.row alertView:self];
        }
    }
}
#pragma mark - <HHQzoneAlertShareCellDelegate>
- (void)clickIndex:(NSInteger)index shareCell:(HHQzoneAlertShareCell *)shareCell{

    if ([self.delegate respondsToSelector:@selector(shareButtonOnClick:alertView:)]) {
        [self.delegate shareButtonOnClick:index alertView:self];
    }
}
#pragma mark - Setter && Getter
-(UITableView *)tableView{

    if (!_tableView) {
        _tableView= [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 44;
        _tableView.scrollEnabled = NO;
        
    }
    return _tableView;
}

-(NSMutableArray *)listArr{

    if (!_listArr) {
        _listArr =[NSMutableArray array];
    }
    return _listArr;
}
@end
