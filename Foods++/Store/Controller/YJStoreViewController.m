//
//  YJStoreViewController.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJStoreViewController.h"
#import "TitleIconBtnModel.h"
#import "YJStoreModel.h"
#import "YJStoreCell.h"
#import "DCPicScrollView.h"
#import "DCWebImageManager.h"
#import "YJStoreMenuView.h"
#import "YJStoreDetailController.h"
@interface YJStoreViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,YJStoreMenuViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *upBtn;
@property (nonatomic, strong) NSMutableArray *bannerArray;
@property (nonatomic, strong) NSMutableArray *menuArray;
@property (nonatomic, strong) NSMutableArray *storeCellArray;
@property (nonatomic, strong) NSDictionary *channelDict;
@property (strong, nonatomic) NSMutableDictionary *heights;
@end

@implementation YJStoreViewController
- (NSDictionary *)channelDict
{
	if (!_channelDict) {
		_channelDict = [NSDictionary dictionary];
	}
	
	return _channelDict;
}

- (NSMutableDictionary *)heights
{
	if (!_heights) {
		_heights = [NSMutableDictionary dictionary];
	}
	return _heights;
}

- (NSMutableArray *)menuArray
{
	if (!_menuArray) {
		_menuArray = [NSMutableArray array];
	}
	return _menuArray;
}

- (NSMutableArray *)storeCellArray
{
	if (!_storeCellArray) {
		_storeCellArray = [NSMutableArray array];
	}
	return _storeCellArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	self.upBtn.hidden = YES;
	[self loadData];
	[self setTitleView];
	[self setupTableView];
	[self setUpBtn];
}
-(void)setTitleView
{
	UIImageView *titleImage = [[UIImageView alloc] init];
	titleImage.frame = CGRectMake(20, 20, 60, 20);
	titleImage.image = [UIImage imageNamed:@"YS_food+"];
	self.navigationItem.titleView = titleImage;
	self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(search) image:@"icon_home_search" highImage:@"icon_home_search_index"];
}
-(void)loadData
{
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		NSString *path = [[NSBundle mainBundle] pathForResource:@"Store" ofType:@"json"];
		NSData *data = [NSData dataWithContentsOfFile:path];
		NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
		
		NSDictionary *datas = [NSDictionary dictionary];
		datas = [json objectForKey:@"datas"];
		
		self.channelDict = [datas objectForKey:@"channel"];
		
		NSMutableArray *bannerArr = [NSMutableArray array];
		bannerArr = [datas objectForKey:@"banner"];
		
		self.bannerArray = [NSMutableArray array];
		for (int i =0 ; i<bannerArr.count; i++) {
			NSString *pic = [bannerArr[i] objectForKey:@"advertImg"];
			[self.bannerArray addObject:pic];
		}
		
		NSArray *menuArr = [NSArray array];
		menuArr = [datas objectForKey:@"tag_classify"];
		
		for (int i =0 ; i<menuArr.count; i++) {
			NSDictionary *dict = menuArr[i];
			TitleIconBtnModel *btnModel = [TitleIconBtnModel titleIconWith:[dict objectForKey:@"tag_name"] icon:[dict objectForKey:@"tag_img"] controller:self tag:[[dict objectForKey:@"tag_type"] intValue]];
			[self.menuArray addObject:btnModel];
		}
	
		NSMutableArray *query = [NSMutableArray array];
		query = [datas objectForKey:@"query"];
		self.storeCellArray = [NSMutableArray array];
		// 字典数组 -> 模型数组
		for (int i = 1; i<query.count; i++) {
			NSDictionary *dict = query[i];
			YJStoreModel *m = [YJStoreModel initWithDic:dict];
			[self.storeCellArray addObject:m];
		}
		
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.tableView reloadData];
		});
	});

}
-(void)setupTableView
{
	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
	tableView.dataSource = self;
	tableView.delegate = self;
	
	self.tableView = tableView;
	[self.view addSubview:tableView];
	tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}
-(void)setUpBtn
{
	UIButton *upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	upBtn.frame = CGRectMake(ScreenWidth - 70, ScreenHeight * 0.8, 44, 44);
	[upBtn setBackgroundImage:[UIImage imageNamed:@"icon_back_top"] forState:UIControlStateNormal];
	upBtn.hidden = YES;
	[upBtn addTarget:self action:@selector(backTop) forControlEvents:UIControlEventTouchUpInside];
	self.upBtn = upBtn;
	[self.view addSubview:upBtn];

}
- (void)search
{
	NSLog(@"search----");
	[SVProgressHUD showSuccessWithStatus:@"search"];
}

- (void)backTop
{
	[self.tableView setContentOffset:CGPointZero animated:YES];
}

#pragma mark --UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.storeCellArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	YJStoreCell *cell = [YJStoreCell cellWithTableView:tableView];
	cell.models = self.storeCellArray[indexPath.row];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	CGFloat heigth = [cell cellHeight];
	[self.heights setObject:@(heigth) forKey:@(indexPath.row)];
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	YJStoreDetailController *storeDetailVC = [[YJStoreDetailController alloc] init];
	[self.navigationController pushViewController:storeDetailVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	return [self.heights[@(indexPath.row)] doubleValue];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *headerView = [UIView new];
	DCPicScrollView *scrollView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 200) WithImageUrls:self.bannerArray];
	[headerView addSubview:scrollView];
	scrollView.placeImage = [UIImage imageNamed:@"place.png"];
	
	[scrollView setImageViewDidTapAtIndex:^(NSInteger index){
		
	}];
	scrollView.AutoScrollDelay = 3.0f;
	[[DCWebImageManager shareManager] setDownloadImageRepeatCount:1];
	[[DCWebImageManager shareManager] setDownLoadImageError:^(NSError *error, NSString *url) {
		NSLog(@"%@",error);
	}];
	YJStoreMenuView *menuView = [[YJStoreMenuView alloc] initMenu:self.menuArray];
	menuView.delegate = self;
	menuView.frame = CGRectMake(0, 200, ScreenWidth, 180);
	[headerView addSubview:menuView];
	
	
	return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 380;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if (scrollView.contentOffset.y > ScreenHeight) {
		self.upBtn.hidden = NO;
	} else {
		self.upBtn.hidden = YES;
	}
}
- (void)menuBtnClick
{
	NSLog(@"-----------");
	[SVProgressHUD showSuccessWithStatus:@"menuBtnClick"];
	[SVProgressHUD dismissWithDelay:1.0];
}
@end
