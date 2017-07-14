//
//  YJVideoModel.h
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJVideoModel : NSObject
@property (nonatomic, copy) NSString *article_title;
@property (nonatomic, copy) NSString *article_video;
@property (nonatomic, copy) NSString *article_image;
@property (nonatomic, copy) NSString *article_abstract;
@property (nonatomic, copy) NSString *video_length;

+ (instancetype)initWithDic:(NSDictionary *)dict;

@end
