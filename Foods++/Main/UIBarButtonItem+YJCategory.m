//
//  UIBarButtonItem+YJCategory.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "UIBarButtonItem+YJCategory.h"

@implementation UIBarButtonItem (YJCategory)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
	/**
	 *  设置返回barButton
	 */
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	//设置图片
	[btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
	[btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
	//设置尺寸
	btn.size = btn.currentBackgroundImage.size;
	
	return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
