//
//  YJMapCell.h
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJMapModel.h"
@interface YJMapCell : UITableViewCell
@property (nonatomic, strong) YJMapModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (CGFloat)cellHeight;
@end
