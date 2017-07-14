//
//  YJHomeCellModel.h
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJHomeCellModel : NSObject
@property (nonatomic, copy) NSString *relation_object_image;
@property (nonatomic, copy) NSString *relation_object_title;
@property (nonatomic, copy) NSString *relation_object_jingle;
@property (nonatomic, copy) NSString *goods_price;
+ (instancetype)initWithDic:(NSDictionary *)dict;
@end
