//
//  YJActivityModel.h
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJActivityModel : NSObject
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *goods_image;
@property (nonatomic, copy) NSString *hint_virtual;
@property (nonatomic, copy) NSString *end_virtual;

+ (instancetype)initWithDic:(NSDictionary *)dict;

@end
