//
//  YJActivityCell.h
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJActivityModel.h"
@interface YJActivityCell : UITableViewCell
@property (nonatomic, strong) YJActivityModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (CGFloat)cellHeight;
@end
