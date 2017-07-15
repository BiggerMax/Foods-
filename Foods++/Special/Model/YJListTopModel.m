//
//  YJListTopModel.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJListTopModel.h"

@implementation YJListTopModel
+ (instancetype)initWithDic:(NSDictionary *)dict
{
	YJListTopModel *model = [[self alloc] init];
	[model setValuesForKeysWithDictionary:dict];
	return model;
	
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
	
}
@end
