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
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullScreenBtnClick:) name:@"fullScreenBtnClickNotice" object:nil];
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
-(void)startPlayVideo:(UIButton *)sender
{
	_currentIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
	if ([UIDevice currentDevice].systemVersion.floatValue >= 8||[UIDevice currentDevice].systemVersion.floatValue<7) {
		self.currentCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_currentIndexPath.row inSection:0]];
	}else{
		self.currentCell = (YJVideoCell *)sender.superview.superview.superview;
	}
	YJVideoModel *model = [_videoModelArray objectAtIndex:sender.tag];
	if (self.wmPlayer) {
		[self releaseWMPlayer];
		self.wmPlayer = [WMPlayer new];
		self.wmPlayer.delegate = self;
		self.wmPlayer.closeBtnStyle = CloseBtnStyleClose;
		self.wmPlayer.URLString = model.article_video;
		self.wmPlayer.titleLabel.text = model.article_title;
	}else{
		self.wmPlayer = [WMPlayer new];
		self.wmPlayer.delegate = self;
		self.wmPlayer.closeBtnStyle = CloseBtnStyleClose;
		self.wmPlayer.URLString = model.article_video;
		self.wmPlayer.titleLabel.text = model.article_title;
	}
	[self.currentCell addSubview:self.wmPlayer];
	[self.currentCell bringSubviewToFront:self.wmPlayer];
	[self.currentCell.playBtn.superview sendSubviewToBack:self.currentCell.playBtn];
	[self.wmPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.currentCell).with.offset(0);
		make.left.equalTo(self.currentCell).with.offset(0);
		make.right.equalTo(self.currentCell).with.offset(0);
		make.height.equalTo(@(self.currentCell.coverView.frame.size.height));
	}];
	[self.wmPlayer play];

}
#pragma mark --WMPlayerDelegate
//点击关闭按钮代理方法
-(void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn
{
	[self releaseWMPlayer];
	
}
//点击全屏按钮代理方法
-(void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn
{
	//self.wmPlayer.transform = CGAffineTransformMakeRotation(M_PI / 2);
}
#pragma mark --播放通知
- (void)videoDidFinished:(NSNotification *)notice
{
	YJVideoCell *currentcCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndexPath.row inSection:0]];
	[currentcCell.playBtn.superview bringSubviewToFront:currentcCell.playBtn];
	[self.wmPlayer removeFromSuperview];
}
- (void)fullScreenBtnClick:(NSNotification *)notice{
	
}
-(void)closeTheVideo:(NSNotification *)obj
{
	YJVideoCell *currentCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndexPath.row inSection:0]];
	[currentCell.playBtn.superview bringSubviewToFront:currentCell.playBtn];
	[self releaseWMPlayer];
}
-(void)releaseWMPlayer
{
	[self.wmPlayer pause];
	[self.wmPlayer removeFromSuperview];
	[self.wmPlayer.playerLayer removeFromSuperlayer];
	[self.wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
	self.wmPlayer.player = nil;
	self.wmPlayer.currentItem = nil;
	[self.wmPlayer.autoDismissTimer invalidate];
	self.wmPlayer.autoDismissTimer = nil;
	
	self.wmPlayer.playOrPauseBtn = nil;
	self.wmPlayer.playerLayer = nil;
	self.wmPlayer = nil;
}
-(void)dealloc{
	NSLog(@"%@ dealloc",[self class]);
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	[self releaseWMPlayer];
}
@end
