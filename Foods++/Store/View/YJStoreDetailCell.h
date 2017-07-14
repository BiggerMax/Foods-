//
//  YJStoreDetailCell.h
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJStoreDetailModel.h"

@class YJStoreDetailModel;

@interface YJStoreDetailCell : UITableViewCell
@property (nonatomic, strong) YJStoreDetailModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (CGFloat)cellHeight;
@end
