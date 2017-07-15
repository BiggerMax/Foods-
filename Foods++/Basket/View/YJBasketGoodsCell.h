//
//  YJBasketGoodsCell.h
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJBasketGoodsModel.h"

@protocol YJBasketGoodsCellDelegate <NSObject>

-(void)selectGoodsClick:(NSIndexPath *)index btn:(UIButton *)btn;

@end
@interface YJBasketGoodsCell : UITableViewCell
@property(nonatomic,weak)id<YJBasketGoodsCellDelegate>delegate;
@property(nonatomic,strong)YJBasketGoodsModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (copy, nonatomic) NSIndexPath *indexPath;
@end
