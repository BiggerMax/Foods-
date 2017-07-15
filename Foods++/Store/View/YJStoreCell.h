//
//  YJStoreCell.h
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJStoreModel.h"
@interface YJStoreCell : UITableViewCell
@property (nonatomic, strong) YJStoreModel *models;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**
 * 返回这个cell的高度
 */
- (CGFloat)cellHeight;
@end
