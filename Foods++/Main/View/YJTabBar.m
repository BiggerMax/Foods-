//
//  YJTabBar.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJTabBar.h"

@implementation YJTabBar

-(void)layoutSubviews
{
	[super layoutSubviews];
	for (UIControl *tabBarButton in self.subviews) {
		if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
			[tabBarButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
		}
	}
}
- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
	for (UIView *imageView in tabBarButton.subviews) {
		if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
			//需要实现的帧动画
			CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
			animation.keyPath = @"transform.scale";
			animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
			animation.duration = 1;
			animation.calculationMode = kCAAnimationCubic;
			//把动画添加上去
			[imageView.layer addAnimation:animation forKey:nil];
		}
	}
}
@end
