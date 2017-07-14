//
//  YJMainTabBarController.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJMainTabBarController.h"
#import "YJMainNavigationController.h"
#import "YJHomeViewController.h"
#import "YJStoreViewController.h"
#import "YJMeViewController.h"
#import "YJSpecialViewController.h"
#import "YJBasketViewController.h"
#import "YJTabBar.h"
@interface YJMainTabBarController ()

@end

@implementation YJMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
	YJHomeViewController *homeVC = [[YJHomeViewController alloc] init];
	homeVC.title = @"首页";
	[self addChildVC:homeVC imageName:@"YS_index_nor" selectedImageName:@"YS_index_sel"];
	
	YJSpecialViewController
 *specialVC = [[YJSpecialViewController alloc] init];
	specialVC.title = @"专题";
	[self addChildVC:specialVC imageName:@"YS_pro_nor" selectedImageName:@"YS_pro_sel"];
	
	
	YJStoreViewController *storeVC = [[YJStoreViewController alloc] init];
	storeVC.title = @"店铺";
	[self addChildVC:storeVC imageName:@"YS_shop_nor" selectedImageName:@"YS_shop_sel"];
	
	YJBasketViewController *basketVC = [[YJBasketViewController alloc] init];
	basketVC.title = @"购物篮";
	[self addChildVC:basketVC imageName:@"YS_car_nor" selectedImageName:@"YS_car_sel"];
	
	
	YJMeViewController *meVC = [[YJMeViewController alloc] init];
	meVC.title = @"我";
	[self addChildVC:meVC imageName:@"YS_mine_nor" selectedImageName:@"YS_mine_sel"];
	YJTabBar *tabBar = [YJTabBar new];
	[self setValue:tabBar forKey:@"tabBar"];
}
- (void)addChildVC:(UIViewController *)childVc imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
	
	// 设置图标
	childVc.tabBarItem.image = [UIImage imageNamed:imageName];
	
	
	//设置文字样式
	NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
	textAttrs[NSForegroundColorAttributeName] = RGB(168, 168, 168);
	[childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
	
	// 设置tabBarItem的选中文字颜色
	NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
	selectedTextAttrs[NSForegroundColorAttributeName] = RGB(211,192,162);
	[childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
	
	
	childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	
	// 添加为tabbar控制器的子控制器
	YJMainNavigationController *nav = [[YJMainNavigationController alloc] initWithRootViewController:childVc];
	
	[self addChildViewController:nav];
}

@end
