//
//  YJKnowledgeMoedel.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJKnowledgeMoedel.h"

@implementation YJKnowledgeMoedel
+ (instancetype)initWithDic:(NSDictionary *)dict
{
	YJKnowledgeMoedel *model = [[self alloc] init];
	[model setValuesForKeysWithDictionary:dict];
	return model;
	
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
	
}
@end
