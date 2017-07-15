//
//  YJBasketGoodsModel.h
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJBasketGoodsModel : NSObject
@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *goods_desc;
@property (nonatomic, copy) NSString *goods_price;
@property (nonatomic, copy) NSString *goods_img;
@property (nonatomic, copy) NSString *goods_num;

@property (nonatomic, assign) BOOL selectBtn;

+ (instancetype)initWithDic:(NSDictionary *)dict;
@end
