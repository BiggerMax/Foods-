//
//  YJMeViewController.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJMeViewController.h"
#import "YJMyOrderCell.h"
#import "YJMyAccountCell.h"
#define HeadViewH 200
#define HeadViewMinH 64

#define kIconW 60
#define kIconH 60
@interface YJMeViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, strong) UILabel *userLabel;
@end

@implementation YJMeViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	
	[self setupTableView];
	[self setupSettingBtn];
	
}
- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[self.navigationController setNavigationBarHidden:NO animated:NO];
}
-(void)setupTableView
{
	UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
	tableView.delegate = self;
	tableView.dataSource = self;
	self.tableView = tableView;
	[self.view addSubview:tableView];
	self.tableView.tableFooterView = [UIView new];
	
	
	self.topImageView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, -HeadViewH, self.view.frame.size.width, HeadViewH))];
	_topImageView.image = [UIImage imageNamed:@"wishbg.jpg"];
	
	_topImageView.contentMode = UIViewContentModeScaleAspectFill;
	
	_topImageView.clipsToBounds = YES;
	[self.tableView addSubview:self.topImageView];
	UIImageView *iconImage = [[UIImageView alloc] init];
	iconImage.layer.cornerRadius = 30;
	iconImage.layer.masksToBounds = YES;
	iconImage.image = [UIImage imageNamed:@"icon_share_wx.png"];
	self.iconImage = iconImage;
	[_topImageView addSubview:iconImage];
	[iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(_topImageView.mas_centerX);
		make.centerY.mas_equalTo(_topImageView.mas_centerY);
		make.size.mas_equalTo(CGSizeMake(kIconH, kIconH));
	}];
	UILabel *userLabel = [[UILabel alloc] init];
	userLabel.text = @"未登录";
	userLabel.font = [UIFont systemFontOfSize:18.0];
	userLabel.textColor = [UIColor whiteColor];
	userLabel.textAlignment = NSTextAlignmentCenter;
	self.userLabel = userLabel;
	[_topImageView addSubview:userLabel];
	[userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(iconImage.mas_bottom).offset(18);
		make.centerX.mas_equalTo(iconImage.mas_centerX);
		make.size.mas_equalTo(CGSizeMake(100, 21));
	}];
	
	self.tableView.contentInset = UIEdgeInsetsMake(HeadViewH, 0, 0, 0);
//	UIBlurEffect *blur = [UIBlurEffect effectWithStyle:(UIBlurEffectStyleLight)];
//	UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
//	effectView.frame = _topImageView.bounds;
//	_effectView = effectView;
//	[_topImageView addSubview:_effectView];
//	effectView.alpha = 0.5;
}
-(void)setupSettingBtn
{
	UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[settingBtn setBackgroundImage:[UIImage imageNamed:@"mine_setting"] forState:UIControlStateNormal];
	settingBtn.size = settingBtn.currentBackgroundImage.size;
	[self.view addSubview:settingBtn];
	[settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.view).offset(25);
		make.left.mas_equalTo(self.view).offset(25);
	}];
}
// tableView数据源代理方法啊
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
		
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
	}
	
	if (indexPath.row == 0) {
		YJMyOrderCell *cell = [YJMyOrderCell cellWithTableView:tableView];
		[cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, MAXFLOAT)];
		return cell;
	} else if (indexPath.row == 1) {
		YJMyAccountCell *cell = [YJMyAccountCell cellWithTableView:tableView];
		
		return cell;
	} else if (indexPath.row == 2) {
		
		cell.textLabel.text = @"我的收藏";
	}
	else if (indexPath.row == 3) {
		
		cell.textLabel.text = @"我的活动";
	}
	else if (indexPath.row == 4) {
		
		cell.textLabel.text = @"邀请好友";
	}
	
	
	return cell;
	
	
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 0) {
		return 150;
	} else if (indexPath.row == 1) {
		return 150;
	} else  {
		return 44;
	}
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	
	// 向下的话 为负数
	CGFloat offY = scrollView.contentOffset.y;
	
	// 下拉超过照片的高度的时候
	if (offY < - HeadViewH)
	{
		CGRect frame = self.topImageView.frame;
		// 这里的思路就是改变 顶部的照片的 fram
		self.topImageView.frame = CGRectMake(0, offY, frame.size.width, -offY);
		  //      self.effectView.frame = self.topImageView.frame;
		// 对应调整毛玻璃的效果
		//        self.effectView.alpha = 1 + (offY + HeadViewH) / ScreenHeight ;
	}
}

@end
