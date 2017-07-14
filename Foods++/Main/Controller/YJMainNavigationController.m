//
//  YJMainNavigationController.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJMainNavigationController.h"

@interface YJMainNavigationController ()

@end

@implementation YJMainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	if (self.childViewControllers.count > 0) {
		[viewController setHidesBottomBarWhenPushed:YES];
		
		viewController.navigationItem.leftBarButtonItem = [self itemWithTarget:self action:@selector(close) image:@"nav_return_normal" highImage:@"nav_return_normal"];
	}
	[super pushViewController:viewController animated:animated];
}
-(void)close
{
	[self popViewControllerAnimated:YES];
}
-(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	[button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
	[button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
	button.size = button.currentBackgroundImage.size;
	return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
