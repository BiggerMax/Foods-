//
//  YJHomeViewController.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJHomeViewController.h"
#import "YJHomeCellModel.h"
#import "YJHomeTableViewCell.h"
#import "DCPicScrollView.h"
#import "YJHomeCollectionCell.h"
#import "YJStoreDetailController.h"
#import "YJGoodsViewController.h"
#import "YJSearchViewController.h"
@interface YJHomeViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIButton *upBtn;
@property(nonatomic, strong) NSMutableArray *tempArr;
@property(nonatomic, copy) NSString *infoString;
@property(nonatomic, copy) NSString *infoPicName;
@property(nonatomic,strong) NSMutableArray *homeCellData;
@property(strong, nonatomic) NSMutableDictionary *heights;
@end

@implementation YJHomeViewController
- (NSMutableDictionary *)heights
{
	if (!_heights) {
		_heights = [NSMutableDictionary dictionary];
	}
	return _heights;
}
- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	
	[self loadData];
	[self setNav];
	[self loadTableView];
	[self loadLayerBtn];
	
}
-(void)loadTableView
{
	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
	tableView.dataSource = self;
	tableView.delegate = self;
	self.tableView = tableView;
	[self.view addSubview:tableView];
	tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
-(void)loadLayerBtn
{
	UIButton *upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	upBtn.frame = CGRectMake(ScreenWidth - 70, ScreenHeight * 0.8, 44, 44);
	[upBtn setBackgroundImage:[UIImage imageNamed:@"icon_back_top"] forState:UIControlStateNormal];
	upBtn.hidden = YES;
	[upBtn addTarget:self action:@selector(backTop) forControlEvents:UIControlEventTouchUpInside];
	self.upBtn = upBtn;
	[self.view addSubview:upBtn];
}
-(void)setNav
{
	UIImageView *titleImage = [UIImageView new];
	titleImage.frame = CGRectMake(0, 0, 60, 20);
	titleImage.image = [UIImage imageNamed:@"YS_food+"];
	self.navigationItem.titleView = titleImage;
	self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(search) image:@"icon_home_search"  highImage:@"icon_home_search_index"];
}
-(void)loadData
{
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		NSString *path = [[NSBundle mainBundle] pathForResource:@"Home" ofType:@"json"];
		NSData *data = [NSData dataWithContentsOfFile:path];
		NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
		
		NSDictionary *datas = [NSDictionary dictionary];
		datas = [json objectForKey:@"datas"];
		NSMutableArray *bannerArr = [NSMutableArray array];
		bannerArr = [datas objectForKey:@"banner"];
		
		self.tempArr = [NSMutableArray new];
		for (int i = 0; i < bannerArr.count; i++) {
			NSString *pic = [bannerArr[i] objectForKey:@"advertImg"];
			[self.tempArr addObject:pic];
		}
		
		NSMutableArray *data_type = [NSMutableArray array];
		data_type = [datas objectForKey:@"data_type"];
		self.homeCellData = [NSMutableArray new];
		for (int i = 1; i < data_type.count; i++) {
			NSDictionary *dic = data_type[i];
			YJHomeCellModel *model = [YJHomeCellModel initWithDic:dic];
			[self.homeCellData addObject:model];
		}
		NSDictionary *firstData = data_type[0];
		self.infoString = [firstData objectForKey:@"relation_object_title"];
		self.infoPicName = [firstData objectForKey:@"relation_object_image"];
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.tableView reloadData];
		});
	});
}
#pragma mark - TableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
	return self.homeCellData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	YJHomeTableViewCell *cell = [YJHomeTableViewCell cellWithTableView: tableView];
	
	cell.model = self.homeCellData[indexPath.row];
	// 获取高度
	CGFloat tmpHeight = [cell cellHeight];
	
	
	[self.heights setObject:@(tmpHeight) forKey:@(indexPath.row)];
	return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [self.heights[@(indexPath.row)] doubleValue];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 650;
}
// tableView代理方法啊
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	[self.navigationController pushViewController:[[YJGoodsViewController alloc] init] animated:YES];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *headerView = [[UIView alloc] init];
	DCPicScrollView *scrollView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 200) WithImageUrls:self.tempArr];
	[headerView addSubview:scrollView];
	scrollView.placeImage = [UIImage imageNamed:@"place.png"];
	[scrollView setImageViewDidTapAtIndex:^(NSInteger index){
		[self.navigationController pushViewController:[[YJStoreDetailController alloc] init] animated:YES];
	}];
	
	scrollView.AutoScrollDelay = 3.0f;
	[[DCWebImageManager shareManager] setDownloadImageRepeatCount:1];
	[[DCWebImageManager shareManager] setDownLoadImageError:^(NSError *error, NSString *url){
		NSLog(@"%@",error);
	}];
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, ScreenWidth, 30)];
	label.text = @"每月精选";
	label.textColor = RGB(231, 198, 168);
	label.textAlignment = NSTextAlignmentCenter;
	label.font = [UIFont systemFontOfSize:15.0f];
	label.backgroundColor = [UIColor whiteColor];
	[headerView addSubview:label];
	
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 230, ScreenWidth, 200)];
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		[imageView sd_setImageWithURL:[NSURL URLWithString:self.infoPicName]];
	});
	UIToolbar *burlView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
	burlView.alpha = 0.8;
	[imageView addSubview:burlView];
	UIImageView *bImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * 0.2, 70, ScreenWidth * 0.6, 70)];
	bImageView.image = [UIImage imageNamed:@"InfoCelltitle"];
	[burlView addSubview:bImageView];
	UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake((bImageView.size.width-150)/2, 20, 150, 30)];
	infoLabel.textAlignment = NSTextAlignmentCenter;
	infoLabel.text = self.infoString;
	infoLabel.font = [UIFont systemFontOfSize:17.0];
	[bImageView addSubview:infoLabel];
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked)];
	[imageView addGestureRecognizer:tap];
	imageView.userInteractionEnabled = YES;
	[headerView addSubview:imageView];
	
	//collectionLayout
	UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
	layout.minimumLineSpacing = 15;
	layout.itemSize = CGSizeMake(120, 200);
	layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
	CGFloat margin = 15;
	layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
	
	UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 430, ScreenWidth, 220) collectionViewLayout:layout];
	collectionView.delegate = self;
	collectionView.dataSource = self;
	collectionView.backgroundColor = [UIColor whiteColor];
	collectionView.userInteractionEnabled = YES;
	[collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YJHomeCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:@"collectionCell"];
	collectionView.scrollEnabled = YES;
	collectionView.showsHorizontalScrollIndicator = NO;
	[headerView addSubview:collectionView];
	return headerView;
	
}
#pragma mark --CollectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return 5;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	YJHomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
	cell.userInteractionEnabled = YES;
	cell.name = [NSString stringWithFormat:@"每月精选%ld",(long)indexPath.item];
	cell.pciName = @"icon_share_wx";
	cell.price = [NSString stringWithFormat:@"$%d",arc4random()/100];
	return cell;
	
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if (scrollView.contentOffset.y > ScreenHeight) {
		self.upBtn.hidden = NO;
	} else {
		self.upBtn.hidden = YES;
	}
}
- (void)search
{
	NSLog(@"search----");
	[self.navigationController pushViewController:[[YJSearchViewController alloc] init] animated:YES];
}

- (void)backTop
{
	[self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}
-(void)tapClicked
{
	[self.navigationController pushViewController:[[YJStoreDetailController alloc] init] animated:YES];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"%ld",indexPath.row);
	[SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"点击了%ld行",indexPath.row]];
}
@end
