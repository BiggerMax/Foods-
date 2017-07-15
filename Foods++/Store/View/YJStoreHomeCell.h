//
//  YJStoreHomeCell.h
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJStoreHomeModel.h"
#define kCellIdentifier_CollectionViewCell @"GridListCollectionViewCell"
@interface YJStoreHomeCell : UICollectionViewCell
/**
 0：列表视图，1：格子视图
 */
@property (nonatomic, assign) BOOL isGrid;

@property (nonatomic, strong) YJStoreHomeModel *model;

@end
