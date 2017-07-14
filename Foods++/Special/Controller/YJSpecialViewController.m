//
//  YJSpecialViewController.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJSpecialViewController.h"
#import "YJVideoViewController.h"
#import "YJListTopViewController.h"
#import "YJMapViewController.h"
#import "YJActivityViewController.h"
#import "YJKnowdgeViewController.h"

CGFloat const TitilesViewH = 44;
@interface YJSpecialViewController ()<UIScrollViewDelegate,UINavigationControllerDelegate>
/** 标签栏底部的红色指示器 */
@property (nonatomic, strong) UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic, strong) UIButton *selectedButton;
/** 顶部的所有标签 */
@property (nonatomic, strong) UIView *titlesView;
/** 底部的所有内容 */
@property (nonatomic, strong) UIScrollView *contentView;
@end

@implementation YJSpecialViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	[self setTitleView];
	[self setupChildVces];
	[self setupTitlesView];
	[self setupContentView];
	
}

-(void)setTitleView
{
	self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(search) image:@"icon_home_search" highImage:@"icon_home_search_index"];
	UIImageView *titleImage = [[UIImageView alloc] init];
	titleImage.frame = CGRectMake(20, 20, 60, 20);
	titleImage.image = [UIImage imageNamed:@"YS_food+"];
	self.navigationItem.titleView = titleImage;
	
}
-(void)setupChildVces
{
	YJVideoViewController *v1 = [[YJVideoViewController alloc] init];
	v1.title = @"视频";
	[self addChildViewController:v1];
	YJListTopViewController *v2 = [[YJListTopViewController alloc] init];
	v2.title = @"榜单";
	v2.view.backgroundColor = RandomColor;
	[self addChildViewController:v2];
	YJKnowdgeViewController *v3 = [[YJKnowdgeViewController alloc] init];
	v3.title = @"知识";
	v3.view.backgroundColor = RandomColor;
	[self addChildViewController:v3];
	YJKnowdgeViewController *v4 = [[YJKnowdgeViewController alloc] init];
	v4.title = @"人文";
	v4.view.backgroundColor = RandomColor;
	[self addChildViewController:v4];
	YJMapViewController *v5 = [[YJMapViewController alloc] init];
	v5.title = @"地图";
	v5.view.backgroundColor = RandomColor;
	[self addChildViewController:v5];
	YJActivityViewController *v6 = [[YJActivityViewController alloc] init];
	v6.title = @"活动";
	v6.view.backgroundColor = RandomColor;
	[self addChildViewController:v6];
	
}
-(void)setupTitlesView
{
	//标签栏整体
	UIView *titlesView =  [[UIView alloc] init];
	titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
	titlesView.width = self.view.width;
	titlesView.height = TitilesViewH;
	titlesView.y = 64;
	self.titlesView = titlesView;
	[self.view addSubview:titlesView];
	
	//下面的指示器view
	UIView *indicatorView = [[UIView alloc] init];
	indicatorView.backgroundColor = ThemeColor;
	indicatorView.height = 2;
	indicatorView.tag = -1;
	indicatorView.y = titlesView.height - indicatorView.height-1;
	self.indicatorView = indicatorView;
	CGFloat width = titlesView.width / self.childViewControllers.count;
	CGFloat height = titlesView.height;
	
	for (int i = 0; i < self.childViewControllers.count; i ++) {
		UIButton *button = [[UIButton alloc] init];
		button.tag = i;
		button.height = height;
		button.width = width;
		button.x = i * width;
		button.y = 0;
		UIViewController *vc = self.childViewControllers[i];
		[button setTitleEdgeInsets:UIEdgeInsetsMake(3, 0, 0, 0)];
		[button setTitle:vc.title forState:UIControlStateNormal];
		[button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
		[button setTitleColor:ThemeColor forState:UIControlStateSelected];
		button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
		[button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
		[titlesView addSubview:button];
		
		if (i == 0) {
			button.enabled = NO;
			self.selectedButton = button;
			[button.titleLabel sizeToFit];
			self.indicatorView.width = width;
			self.indicatorView.centerX = button.centerX;
		}
	}
	
	//底部灰色背景
	UIView *indicatorBgView = [[UIView alloc] init];
	indicatorBgView.backgroundColor = RGB(250, 250, 250);
	indicatorBgView.width = self.view.width;
	indicatorBgView.height = 2;
	indicatorBgView.y = TitilesViewH - 2;
	[self.titlesView addSubview:indicatorBgView];
	
	
	[titlesView addSubview:indicatorView];
	
}
-(void)setupContentView
{
	self.automaticallyAdjustsScrollViewInsets = NO;
	UIScrollView *scrollView = [UIScrollView new];
	scrollView.backgroundColor = [UIColor whiteColor];
	scrollView.frame = self.view.bounds;
	scrollView.delegate = self;
	scrollView.pagingEnabled = YES;
	[self.view insertSubview:scrollView atIndex:0];
	scrollView.contentSize = CGSizeMake(scrollView.width * self.childViewControllers.count, 0);
	self.contentView = scrollView;
	// 添加第一个控制器的view
	[self scrollViewDidEndScrollingAnimation:scrollView];

}
#pragma mark - <UIScrollViewDelegate>
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
	NSInteger index = scrollView.contentOffset.x / scrollView.width;
	UIViewController *vc = self.childViewControllers[index];
	vc.view.x = scrollView.contentOffset.x;
	vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
	vc.view.height = scrollView.height;
	//vc.view.frame = CGRectMake(index * ScreenWidth, 0, ScreenWidth, scrollView.height);
	[scrollView addSubview:vc.view];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	[self scrollViewDidEndScrollingAnimation:scrollView];
	
	NSInteger index = scrollView.contentOffset.x / scrollView.width;
	[self titleClick:self.titlesView.subviews[index]];
}
-(void)titleClick:(UIButton *)sender
{
	self.selectedButton.enabled = YES;
	sender.enabled = NO;
	self.selectedButton = sender;
	[UIView animateWithDuration:0.1 animations:^{
		self.indicatorView.centerX = sender.centerX;CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
		animation.keyPath = @"transform.scale";
		animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
		animation.duration = 1;
		animation.calculationMode = kCAAnimationCubic;

		[sender.layer addAnimation:animation forKey:nil];
	}];
	CGPoint offset = self.contentView.contentOffset;
	offset.x = sender.tag * self.contentView.width;
	[self.contentView setContentOffset:offset animated:YES];
	
}
- (void)search
{
	NSLog(@"search----");
	[SVProgressHUD showSuccessWithStatus:@"搜索"];
}
@end
