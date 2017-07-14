//
//  YJGuideViewController.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJGuideViewController.h"
#import "YJMainTabBarController.h"
@interface YJGuideViewController ()<UIScrollViewDelegate>
@property(nonatomic, weak)UIScrollView *scroll;
@property(nonatomic, weak)UIPageControl *pageControl;
@end

@implementation YJGuideViewController


- (void)viewDidLoad {
    [super viewDidLoad];
	[self scroll];
	[self pageControl];
}
-(UIScrollView *)scroll
{
	if (!_scroll) {
		UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
		scroll.contentSize = CGSizeMake(ScreenWidth * 5, ScreenHeight);
		scroll.bounces = NO;
		scroll.showsHorizontalScrollIndicator = NO;
		scroll.pagingEnabled = YES;
		scroll.delegate = self;
		self.scroll = scroll;
		[self.view addSubview:scroll];
		
		for (int i=0; i<5; i++) {
			UIImageView *imageView = [[UIImageView alloc] init];
			NSString *name = [NSString stringWithFormat:@"bg_guide_6_%d",i+1];
			imageView.image = [UIImage imageNamed:name];
			imageView.frame = CGRectMake(ScreenWidth*i, 0, ScreenWidth, ScreenHeight);
			[scroll addSubview:imageView];
			if (i==4) {
				UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
				btn.backgroundColor = [UIColor clearColor];
				btn.frame = CGRectMake(ScreenWidth*i + 100, ScreenHeight * 0.75, ScreenWidth-200, ScreenHeight * 0.15);
				[btn addTarget:self action:@selector(startApp) forControlEvents:UIControlEventTouchUpInside];
				[scroll addSubview:btn];
			}
		}
		
	}
	return _scroll;
}
-(UIPageControl *)pageControl
{
	if (!_pageControl) {
		UIPageControl *pageControl = [[UIPageControl alloc] init];
		pageControl.frame = CGRectMake(ScreenWidth * 0.4, ScreenHeight * 0.9, ScreenWidth * 0.2, 44);
		pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
		pageControl.numberOfPages = 4;
		self.pageControl = pageControl;
		pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:211/255.0 green:192/255.0 blue:162/255.0 alpha:1.0];
		[self.view addSubview:pageControl];

	}
	return _pageControl;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	long page = scrollView.contentOffset.x / ScreenWidth;
	
	if (page == 4) {
		self.pageControl.hidden = YES;
	} else {
		self.pageControl.hidden = NO;
	}
	self.pageControl.currentPage = (NSInteger)page+0.5;
}

- (void)startApp
{
	UIWindow *window = [UIApplication sharedApplication].keyWindow;
	window.rootViewController = [[YJMainTabBarController alloc] init];
}
@end
