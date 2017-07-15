//
//  YJListTopCell.h
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJListTopModel.h"
@class YJListTopModel;
@interface YJListTopCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (CGFloat)cellHeight;

@property (nonatomic, strong) YJListTopModel *model;
@end
