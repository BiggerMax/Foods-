//
//  YJActivityViewController.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJActivityViewController.h"
#import "YJActivityModel.h"
#import "YJActivityCell.h"
@interface YJActivityViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *activityArray;
@end

@implementation YJActivityViewController
- (NSMutableArray *)activityArray
{
	if (!_activityArray) {
		_activityArray = [NSMutableArray array];
	}
	return _activityArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
	[self loadDatas];
	[self setupTableView];
}
- (void)setupTableView
{
	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+40, ScreenWidth, ScreenHeight-64-40-44)];
	tableView.delegate = self;
	tableView.dataSource = self;
	self.tableView = tableView;
	[self.view addSubview:tableView];
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - 加载shuju
- (void)loadDatas
{
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		
		NSString *path = [[NSBundle mainBundle] pathForResource:@"activity" ofType:@"json"];
		NSData *data = [NSData dataWithContentsOfFile:path];
		NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
		
		NSDictionary *datas = [NSDictionary dictionary];
		datas = [json objectForKey:@"datas"];
		
		NSArray *articleList = datas[@"virtual"];
		for (NSDictionary *dict in articleList) {
			YJActivityModel *model = [YJActivityModel initWithDic:dict];
			[self.activityArray addObject:model];
		}
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.tableView reloadData];
		});
	});
}
#pragma mark - TableView代理方法
// tableView数据源代理方法啊
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.activityArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	YJActivityCell *cell = [YJActivityCell cellWithTableView:tableView];
	
	cell.model = self.activityArray[indexPath.row];
	
	return cell;
}


// tableView代理方法啊
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	return 180;
}


@end
