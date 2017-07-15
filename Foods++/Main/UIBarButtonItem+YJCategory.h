//
//  UIBarButtonItem+YJCategory.h
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YJCategory)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action text:(NSString *)text textColor:(UIColor *)color;
@end
