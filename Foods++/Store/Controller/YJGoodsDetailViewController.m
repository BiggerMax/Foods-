//
//  YJGoodsDetailViewController.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJGoodsDetailViewController.h"
#import <WebKit/WebKit.h>
@interface YJGoodsDetailViewController ()<WKNavigationDelegate>
@property(nonatomic,strong)WKWebView *webView;
@property(nonatomic,strong)UIProgressView *progressView;
@property(nonatomic,assign)NSUInteger loadCount;
@end

@implementation YJGoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
	self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:ThemeColor};
	WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.goodsDetailURL]]];
	self.webView = webView;
	webView.navigationDelegate = self;
	[self.view addSubview:webView];
	
	[webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
	UIProgressView *progress = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 4)];
	self.progressView = progress;
	progress.progressTintColor = ThemeColor;
	[self.view addSubview:progress];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"estimatedProgress"]) {
		self.progressView.progress = self.webView.estimatedProgress;
	}
	if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
		CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
		if (newprogress == 1) {
			self.progressView.hidden = YES;
			[self.progressView setProgress:0 animated:NO];
		}else {
			self.progressView.hidden = NO;
			[self.progressView setProgress:newprogress animated:YES];
		}
	}

}
- (void)setLoadCount:(NSUInteger)loadCount {
	_loadCount = loadCount;
	
	if (loadCount == 0) {
		self.progressView.hidden = YES;
		[self.progressView setProgress:0 animated:NO];
	}else {
		self.progressView.hidden = NO;
		CGFloat oldP = self.progressView.progress;
		CGFloat newP = (1.0 - oldP) / (loadCount + 1) + oldP;
		if (newP > 0.95) {
			newP = 0.95;
		}
		[self.progressView setProgress:newP animated:YES];
		
	}
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
	self.loadCount ++;
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
	self.loadCount --;
}
- (void)webView:(WKWebView *)webView didFailNavigation: (null_unspecified WKNavigation *)navigation withError:(NSError *)error {
	self.loadCount --;
	NSLog(@"%@",error);
}

- (void)dealloc
{
	[self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
@end
