//
//  TitleIconBtnModel.h
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TitleIconBtnModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, strong) UIViewController *controller;
@property (nonatomic, assign) NSInteger tag;

+ (instancetype)titleIconWith:(NSString *)title icon:(NSString *)image controller:(UIViewController *)controlller tag:(NSInteger )tag;
@end
