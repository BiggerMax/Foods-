//
//  YJStoreDetailModel.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJStoreDetailModel.h"

@implementation YJStoreDetailModel
+ (instancetype)initWithDict:(NSDictionary *)dict
{
	YJStoreDetailModel *model = [[self alloc] init];
	[model setValuesForKeysWithDictionary:dict];
	return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
	
}
@end
