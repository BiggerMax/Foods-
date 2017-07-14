//
//  YJStoreDetailModel.h
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJStoreDetailModel : NSObject
@property (nonatomic, copy) NSString *goods_image_url ;
@property (nonatomic, copy) NSString *goods_name ;
@property (nonatomic, copy) NSString *goods_jingle ;
@property (nonatomic, copy) NSString *goods_price ;
@property (nonatomic, copy) NSString *goods_marketprice ;
@property (nonatomic, copy) NSString *goods_salenum;
+ (instancetype)initWithDict:(NSDictionary *)dict;
@end
