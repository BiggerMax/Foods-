//
//  YJVideoViewController.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJVideoViewController.h"
#import "YJVideoModel.h"
#import "WMPlayer.h"
#import "YJVideoCell.h"
@interface YJVideoViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,WMPlayerDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *videoModelArray;
@property (strong, nonatomic) NSMutableDictionary *heights;
@property (nonatomic, strong)  WMPlayer *wmPlayer;
@property (nonatomic, assign)  NSIndexPath *currentIndexPath;
@property (nonatomic,retain) YJVideoCell *currentCell;
@end

@implementation YJVideoViewController
- (NSMutableArray *)videoModelArray
{
	if (!_videoModelArray) {
		_videoModelArray = [NSMutableArray array];
	}
	return _videoModelArray;
}

- (NSMutableDictionary *)heights
{
	if (!_heights) {
		_heights = [NSMutableDictionary dictionary];
	}
	return _heights;
}
- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupConfig];
	[self loadData];
	[self setupTableView];
}
-(void)setupConfig
{

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
	//注册播放完成通知
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullScreenBtnClick:) name:@"fullScreenBtnClickNotice" object:nil];
	//关闭通知
	//关闭通知
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(closeTheVideo:)
												 name:@"closeTheVideo"
											   object:nil
	 ];

}
-(void)loadData
{
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		
		NSString *path = [[NSBundle mainBundle] pathForResource:@"shipin" ofType:@"json"];
		NSData *data = [NSData dataWithContentsOfFile:path];
		NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
		NSLog(@"json = %@",json);
		
		NSDictionary *datas = json[@"datas"];
		
		NSArray *listArray = datas[@"article_list"];
		
		for (NSDictionary *dict in listArray) {
			YJVideoModel *model = [YJVideoModel initWithDic:dict];
			[self.videoModelArray addObject:model];
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
}
#pragma mark - TableView代理方法
// tableView数据源代理方法啊
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.videoModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	YJVideoCell *cell = [YJVideoCell cellWithTableView:tableView];
	cell.model = self.videoModelArray[indexPath.row];
	CGFloat tmpHeight = [cell cellHeight];
	[self.heights setObject:@(tmpHeight) forKey:@(indexPath.row)];
	[cell.playBtn addTarget:self action:@selector(startPlayVideo:) forControlEvents:UIControlEventTouchUpInside];
	cell.playBtn.tag = indexPath.row;
	
	if (self.wmPlayer&&self.wmPlayer.superview) {
		if (indexPath.row==_currentIndexPath.row) {
			[cell.playBtn.superview sendSubviewToBack:cell.playBtn];
		}else{
			[cell.playBtn.superview bringSubviewToFront:cell.playBtn];
		}
		NSArray *indexpaths = [tableView indexPathsForVisibleRows];
		if (![indexpaths containsObject:_currentIndexPath]) {//复用
			
			if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:self.wmPlayer]) {
				self.wmPlayer.hidden = NO;
				
			}else{
				self.wmPlayer.hidden = YES;
			}
		}else{
			if ([cell.subviews containsObject:self.wmPlayer]) {
				[cell addSubview:self.wmPlayer];
				
				[self.wmPlayer play];
				self.wmPlayer.hidden = NO;
			}
			
		}
	}
	
	
	
	return cell;
}


// tableView代理方法啊
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [self.heights[@(indexPath.row)] doubleValue];
}

@end
