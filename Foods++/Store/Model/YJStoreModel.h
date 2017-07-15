//
//  YJStoreModel.h
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJStoreModel : NSObject
@property (nonatomic, copy) NSString *special_title;
@property (nonatomic, copy) NSString *special_image;

+ (instancetype)initWithDic:(NSDictionary *)dict;
@end
