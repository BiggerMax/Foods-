//
//  YJKnowledgeCell.h
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJKnowledgeMoedel.h"
@class YJKnowledgeMoedel;
@interface YJKnowledgeCell : UITableViewCell
@property (nonatomic, strong) YJKnowledgeMoedel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (CGFloat)cellHeight;
@end
