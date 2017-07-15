//
//  YJListTopModel.h
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJListTopModel : NSObject
@property (nonatomic, copy) NSString *article_title;
@property (nonatomic, copy) NSString *article_image;
@property (nonatomic, copy) NSString *article_abstract;
@property (nonatomic, copy) NSString *article_origin;
@property (nonatomic, copy) NSString *top;
+ (instancetype)initWithDic:(NSDictionary *)dict;
@end
