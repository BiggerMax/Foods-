//
//  YJStoreHomeModel.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJStoreHomeModel.h"

@implementation YJStoreHomeModel
+ (instancetype)initWithDict:(NSDictionary *)dict
{
	YJStoreHomeModel *model = [[self alloc] init];
	[model setValuesForKeysWithDictionary:dict];
	return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
	
}
@end
