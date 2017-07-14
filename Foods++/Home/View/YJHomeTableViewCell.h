//
//  YJHomeTableViewCell.h
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJHomeCellModel.h"
@class YJHomeCellModel;
@interface YJHomeTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)YJHomeCellModel *model;
- (CGFloat)cellHeight;
@end
