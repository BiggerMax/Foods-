//
//  YJSearchViewController.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJSearchViewController.h"

@interface YJSearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,UISearchControllerDelegate>
@property(nonatomic,strong) NSMutableArray *items;
@property(nonatomic,strong) UISearchController *searchController;
@property(nonatomic,strong) NSMutableArray *searchResults;//接收数据源结果

@property (nonatomic, weak) UITableView *tableView;
@end

@implementation YJSearchViewController
- (NSMutableArray *)searchResults{
	if (!_searchResults) {
		_searchResults = [NSMutableArray array];
	}
	return _searchResults;
}
- (UISearchController *)searchController
{
	if (!_searchController) {
		
		_searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
		_searchController.searchResultsUpdater = self;
		
		_searchController.dimsBackgroundDuringPresentation = NO;
		
		_searchController.hidesNavigationBarDuringPresentation = NO;
		
		_searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
		
		//光标颜色
		        [[[_searchController.searchBar.subviews objectAtIndex:0].subviews objectAtIndex:1] setTintColor:ThemeColor];
		        UITextField *searchField = [_searchController.searchBar valueForKey:@"_searchField"];
		        searchField.textColor = ThemeColor;
		        searchField.placeholder = @"请搜索您感兴趣的事";
		        [searchField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
		        //取消按钮文字、颜色
		        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:[NSArray arrayWithObject:[UISearchBar class]]] setTintColor:ThemeColor];
		        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:[NSArray arrayWithObject:[UISearchBar class]]] setTitle:@"取消"];
		
		self.tableView.tableHeaderView = self.searchController.searchBar;
	}
	return _searchController;
}
- (void)viewDidLoad {
    [super viewDidLoad];

	[self loadData];
	[self setupTableView];
}
-(void)loadData
{
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		_items = [[NSMutableArray alloc] init];
		for (int i = 0; i < 20; i++) {
			[_items addObject:[self randomString]];
		}
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.tableView reloadData];
		});
	});
}
-(void)setupTableView
{
	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
	tableView.dataSource = self;
	tableView.delegate = self;
	
	self.tableView = tableView;
	[self.view addSubview:tableView];

}
- (NSString *)randomString

{
	
	char data[6];
	for (int x=0;x<10;data[x++] = (char)('A' + (arc4random_uniform(26))));
	
	return [[NSString alloc] initWithBytes:data length:6 encoding:NSUTF8StringEncoding];
	
}
#pragma mark -- UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (self.searchController.active) {
		return self.searchResults.count;
	}else
	{
		return self.items.count;
	}
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *identify = @"cellIdentify";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
	}
	if (!self.searchController.active) {
		cell.textLabel.text = [NSString stringWithFormat:@"%@",_items[indexPath.row]];
		
	}else
	{
		cell.textLabel.text = [NSString stringWithFormat:@"%@",_searchResults[indexPath.row]];
		
	}
	return cell;

}
#pragma mark--UISeachController
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
	NSString *searchString = [self.searchController.searchBar text];
	NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
	if (self.searchController != nil) {
		[self.searchResults removeAllObjects];
	}
	self.searchResults = [NSMutableArray arrayWithArray:[_items filteredArrayUsingPredicate:preicate]];
	[self.tableView reloadData];
}
@end
