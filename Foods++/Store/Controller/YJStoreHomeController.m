//
//  YJStoreHomeController.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJStoreHomeController.h"
#import "YJStoreHomeCell.h"
#import "YJStoreHomeModel.h"
#import "YJCollectionHeaderView.h"
UIKIT_EXTERN NSString *const UICollectionElementKindSectionHeader;  //定义好Identifier
static NSString *const HeaderIdentifier = @"HeaderIdentifier";
@interface YJStoreHomeController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) NSString *picURL;
@end

@implementation YJStoreHomeController
{
	BOOL _isGrid;
}
- (NSMutableArray *)dataSource
{
	if (!_dataSource) {
		_dataSource = [NSMutableArray array];
	}
	return _dataSource;
}

- (UICollectionView *)collectionView
{
	if (!_collectionView)
	{
		UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
		//设置滚动方向
		[flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
		//左右间距
		flowlayout.minimumInteritemSpacing = 2;
		//上下间距
		flowlayout.minimumLineSpacing = 2;
		flowlayout.headerReferenceSize = CGSizeMake(ScreenWidth, 200);
		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(2 , 4 , ScreenWidth - 4, ScreenHeight - 4) collectionViewLayout:flowlayout];
		_collectionView.delegate = self;
		_collectionView.dataSource = self;
		_collectionView.showsVerticalScrollIndicator = NO;
		_collectionView.showsHorizontalScrollIndicator = NO;
		[_collectionView setBackgroundColor:[UIColor clearColor]];
		//注册cell
		[_collectionView registerClass:[YJStoreHomeCell class] forCellWithReuseIdentifier:kCellIdentifier_CollectionViewCell];
		[self.collectionView registerClass:[YJCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderIdentifier];
	}
	return _collectionView;
}


- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.navigationController.navigationBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	_isGrid = NO;
	[self setupNav];
	[self loadData];
	[self.view addSubview:self.collectionView];
}
-(void)setupNav
{
	self.title = @"悦食家";
	self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: ThemeColor};
	UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.rightButton = rightButton;
	[rightButton setBackgroundImage:[UIImage imageNamed:@"product_list_grid_btn"] forState:UIControlStateNormal];
	[rightButton setBackgroundImage:[UIImage imageNamed:@"product_list_grid_btn"] forState:UIControlStateHighlighted];
	//设置尺寸
	rightButton.size = rightButton.currentBackgroundImage.size;
	[rightButton addTarget:self action:@selector(swithBtnClick:) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
	self.navigationItem.rightBarButtonItem= rightItem;

}
-(void)loadData
{
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		
		NSString *path = [[NSBundle mainBundle] pathForResource:@"StoreHome" ofType:@"json"];
		NSData *data = [NSData dataWithContentsOfFile:path];
		NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
		NSDictionary *datas = jsonData[@"datas"];
		
		NSArray *list = datas[@"goods_list"];
		for (NSDictionary *dict in list) {
			[self.dataSource addObject:[YJStoreHomeModel initWithDict:dict]];
		}
		
		self.picURL = datas[@"store_banner"];
		
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.collectionView reloadData];
		});
	});

}
#pragma mark --UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	YJStoreHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_CollectionViewCell forIndexPath:indexPath];
	cell.isGrid = _isGrid;
	cell.model = self.dataSource[indexPath.row];
	return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	if (_isGrid) {
		return CGSizeMake((ScreenWidth - 6) / 2, (ScreenWidth - 6) / 2 + 40);
	} else {
		return CGSizeMake(ScreenWidth - 4, (ScreenWidth - 6) / 4 + 20);
	}
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
	if (kind == UICollectionElementKindSectionHeader) {
		YJCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderIdentifier forIndexPath:indexPath];
		UIImageView *picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, self.view.width - 20, 180)];
		[picImageView sd_setImageWithURL:[NSURL URLWithString:self.picURL]];
		[headerView addSubview:picImageView];
		return headerView;
	}
	return nil;
}
- (void)swithBtnClick:(UIButton *)btn
{
	_isGrid = !_isGrid;
	
	[self.collectionView reloadData];
	if (_isGrid) {
		[self.rightButton setBackgroundImage:[UIImage imageNamed:@"product_list_list_btn"] forState:UIControlStateNormal];
	} else {
		[self.rightButton setBackgroundImage:[UIImage imageNamed:@"product_list_grid_btn"] forState:UIControlStateNormal];
	}
}
@end
