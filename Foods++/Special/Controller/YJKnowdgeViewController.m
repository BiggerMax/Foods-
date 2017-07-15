//
//  YJKnowdgeViewController.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJKnowdgeViewController.h"
#import "YJKnowledgeMoedel.h"
#import "YJKnowledgeCell.h"
#import "YJGoodsDetailViewController.h"
@interface YJKnowdgeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *heights;
@property (nonatomic, strong) NSMutableArray *knowledgeArray;

@end

@implementation YJKnowdgeViewController
- (NSMutableDictionary *)heights
{
	if (!_heights) {
		_heights = [NSMutableDictionary dictionary];
	}
	return _heights;
}

- (NSMutableArray *)knowledgeArray
{
	if (!_knowledgeArray) {
		_knowledgeArray = [NSMutableArray array];
	}
	return _knowledgeArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
	[self loadData];
	[self setupTableView];
}
-(void)loadData
{
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		
		NSString *path = [[NSBundle mainBundle] pathForResource:@"knowledge" ofType:@"json"];
		NSData *data = [NSData dataWithContentsOfFile:path];
		NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
		
		NSDictionary *datas = [NSDictionary dictionary];
		datas = [json objectForKey:@"datas"];
		
		NSArray *articleList = datas[@"article_list"];
		for (NSDictionary *dict in articleList) {
			YJKnowledgeMoedel *model = [YJKnowledgeMoedel initWithDic:dict];
			[self.knowledgeArray addObject:model];
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
	return self.knowledgeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	YJKnowledgeCell *cell = [YJKnowledgeCell cellWithTableView:tableView];
	
	cell.model = self.knowledgeArray[indexPath.row];
	
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
