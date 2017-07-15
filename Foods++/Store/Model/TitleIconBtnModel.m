//
//  TitleIconBtnModel.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "TitleIconBtnModel.h"

@implementation TitleIconBtnModel
+ (instancetype)titleIconWith:(NSString *)title icon:(NSString *)image controller:(UIViewController *)controlller tag:(NSInteger )tag{
	TitleIconBtnModel *titleIconAction = [[TitleIconBtnModel alloc]init];
	titleIconAction.title = title;
	titleIconAction.icon = image;
	titleIconAction.controller = controlller;
	titleIconAction.tag = tag;
	return titleIconAction;
}
@end
