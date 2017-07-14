//
//  YJHomeCellModel.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJHomeCellModel.h"

@implementation YJHomeCellModel
+ (instancetype)initWithDic:(NSDictionary *)dict
{
	YJHomeCellModel *model = [[self alloc] init];
	[model setValuesForKeysWithDictionary:dict];
	return model;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
	
}
@end
