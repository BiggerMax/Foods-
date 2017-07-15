//
//  YJMapViewController.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJMapViewController.h"
#import "YJMapModel.h"
#import "YJMapCell.h"
#import "YJGoodsDetailViewController.h"
@interface YJMapViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *heights;
@property (nonatomic, strong) NSMutableArray *mapArray;
@end

@implementation YJMapViewController
- (NSMutableDictionary *)heights
{
	if (!_heights) {
		_heights = [NSMutableDictionary dictionary];
	}
	return _heights;
}

- (NSMutableArray *)mapArray
{
	if (!_mapArray) {
		_mapArray = [NSMutableArray array];
	}
	return _mapArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self loadData];
	[self setupTableView];
}
-(void)loadData
{
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		
		NSString *path = [[NSBundle mainBundle] pathForResource:@"map" ofType:@"json"];
		NSData *data = [NSData dataWithContentsOfFile:path];
		NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
		
		NSDictionary *datas = [NSDictionary dictionary];
		datas = [json objectForKey:@"datas"];
		
		NSArray *articleList = datas[@"article_list"];
		for (NSDictionary *dict in articleList) {
			YJMapModel *model = [YJMapModel initWithDic:dict];
			[self.mapArray addObject:model];
		}
		
		
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.tableView reloadData];
		});
	});

}
-(void)setupTableView
{
	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+40, ScreenWidth, ScreenHeight-64-40-44)];
	tableView.delegate = self;
	tableView.dataSource = self;
	self.tableView = tableView;
	[self.view addSubview:tableView];
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
#pragma mark - TableView代理方法
// tableView数据源代理方法啊
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.mapArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	YJMapCell *cell = [YJMapCell cellWithTableView:tableView];
	
	cell.model = self.mapArray[indexPath.row];
	
	CGFloat tmpHeight = [cell cellHeight];
	
	
	[self.heights setObject:@(tmpHeight) forKey:@(indexPath.row)];
	return cell;
}


// tableView代理方法啊
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	YJGoodsDetailViewController *vc = [[YJGoodsDetailViewController alloc] init];
	vc.goodsDetailURL = @"http://interface.yueshichina.com//?act=cms_index&op=article_content&type_id=3&article_id=1064";
	[self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	return [self.heights[@(indexPath.row)] doubleValue];
}

@end
