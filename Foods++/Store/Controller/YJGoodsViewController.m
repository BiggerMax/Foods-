//
//  YJGoodsViewController.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJGoodsViewController.h"
#import "DCPicScrollView.h"
#import "DCWebImageManager.h"
#import "YJToolBarButton.h"
#import "YJGoodsDetailViewController.h"
#import "YJBuyView.h"
#import "YJStoreHomeController.h"
@interface YJGoodsViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,YJBuyViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *picScrollViewArray;
//商品信息
@property(nonatomic,copy)NSString *goodsName;
@property(nonatomic,copy)NSString *goodsDesc;
@property(nonatomic,copy)NSString *goodsPrice;
@property(nonatomic,copy)NSString *goodsOrigPrice;
@property(nonatomic,copy)NSString *goodsSaleNum;
@property(nonatomic,copy)NSString *goodsDetailURL;
@property(nonatomic,strong)NSArray *goodsPicArr;
@property(nonatomic,strong)UIImageView *picImageView;
@property(nonatomic,strong)YJBuyView *buyView;
@end

@implementation YJGoodsViewController
- (NSArray *)picScrollViewArray
{
	if (!_picScrollViewArray) {
		_picScrollViewArray = [NSArray array];
	}
	
	return _picScrollViewArray;
}
-(YJBuyView *)buyView
{
	if (!_buyView) {
		_buyView = [[YJBuyView alloc] initWithFrame:self.view.bounds];
		_buyView.delegate = self;
		_buyView.goodsPicName = self.goodsPicArr[0];
		_buyView.goodsName = self.goodsName;
		_buyView.goodsPrice = self.goodsPrice;
		_buyView.goodsOrigPrice = self.goodsOrigPrice;
		[self.view addSubview:self.buyView];
	}
	return _buyView;
}
- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	
}
- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	
	[self setupNav];
	[self loadData];
	[self setupTableView];
	[self setupToolBar];
	self.buyView.hidden = YES;
}
-(void)loadData
{
	NSString *path = [[NSBundle mainBundle] pathForResource:@"Goods_detail" ofType:@"json"];
	NSData *datas = [NSData dataWithContentsOfFile:path];
	NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingAllowFragments error:nil];
	NSDictionary *goodsDatas = jsonData[@"datas"];
	self.goodsPicArr = goodsDatas[@"spec_image"];
	//获取goods详情地址
	self.goodsDetailURL = goodsDatas[@"goods_detaileds"];
	//获取图片
	NSString *goodsImages = goodsDatas[@"goods_image"];
	NSArray *goodsImageArray = [goodsImages componentsSeparatedByString:@","];
	self.picScrollViewArray = goodsImageArray;
	
	NSDictionary *goodInfo = goodsDatas[@"goods_info"];
	self.goodsName = goodInfo[@"goods_name"];
	self.goodsDesc = goodInfo[@"goods_jingle"];
	self.goodsPrice = goodInfo[@"goods_price"];
	self.goodsOrigPrice = goodInfo[@"goods_marketprice"];
	self.goodsSaleNum = goodInfo[@"goods_salenum"];
	
	[self.tableView reloadData];

}
-(void)setupNav
{
	self.title = @"商品详情";
	self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: ThemeColor};
	self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(shareGoodsClick) image:@"YSShare_end" highImage:@"YSShare_end"];
}
-(void)setupTableView
{
	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-44)];
	tableView.delegate = self;
	tableView.dataSource = self;
	DCPicScrollView *picScrollView = ({
		DCPicScrollView *picScrollView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth) WithImageUrls:self.picScrollViewArray];
		//占位图片,你可以在下载图片失败处修改占位图片
		picScrollView.placeImage = [UIImage imageNamed:@"mine_backgroundImg"];
		
		[picScrollView setImageViewDidTapAtIndex:^(NSInteger index) {
			
		}];
		picScrollView.AutoScrollDelay = 3.5f;
		//下载失败重复下载次数,默认不重复,
		[[DCWebImageManager shareManager] setDownloadImageRepeatCount:1];
		[[DCWebImageManager shareManager] setDownLoadImageError:^(NSError *error, NSString *url) {
			NSLog(@"%@",error);
		}];
		
		picScrollView;
		
	});
	tableView.tableHeaderView = picScrollView;
	
	self.tableView = tableView;
	[self.view addSubview:tableView];


}
-(void)setupToolBar
{
	UIView *toolBar = [UIView new];
	toolBar.backgroundColor = [UIColor whiteColor];
	toolBar.layer.borderColor = ThemeColor.CGColor;
	toolBar.layer.borderWidth = 0.5;
	[self.view addSubview:toolBar];
	
	YJToolBarButton *basketBtn = [YJToolBarButton new];
	[basketBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
	[basketBtn setImage:[UIImage imageNamed:@"YS_car_sel"] forState:UIControlStateNormal];
	[basketBtn setTitle:@"购物篮" forState:UIControlStateNormal];
	[basketBtn addTarget:self action:@selector(basketBtnClicked) forControlEvents:UIControlEventTouchUpInside];
	[toolBar addSubview:basketBtn];
	YJToolBarButton *storeBtn = [YJToolBarButton buttonWithType:UIButtonTypeCustom];
	[storeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
	[storeBtn setTitle:@"店铺" forState:UIControlStateNormal];
	[storeBtn setImage:[UIImage imageNamed:@"ysstoreIcon"] forState:UIControlStateNormal];
	[storeBtn addTarget:self action:@selector(storeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
	[toolBar addSubview:storeBtn];
	
	YJToolBarButton *likeBtn = [YJToolBarButton buttonWithType:UIButtonTypeCustom];
	[likeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
	[likeBtn setTitle:@"收藏" forState:UIControlStateNormal];
	[likeBtn setImage:[UIImage imageNamed:@"shop_collection"] forState:UIControlStateNormal];
	[likeBtn addTarget:self action:@selector(likeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
	[toolBar addSubview:likeBtn];
	
	[toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.view);
		make.right.equalTo(self.view);
		make.bottom.equalTo(self.view);
		make.height.mas_equalTo(44);
	}];
	
	UIButton *addBasketBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[addBasketBtn setTitle:@"加入购物篮" forState:UIControlStateNormal];
	[addBasketBtn setBackgroundColor:RGB(190, 160, 150)];
	addBasketBtn.titleLabel.font = [UIFont systemFontOfSize:14];
	[addBasketBtn addTarget:self action:@selector(addBasketBtnClicked) forControlEvents:UIControlEventTouchUpInside];
	[toolBar addSubview:addBasketBtn];
	
	UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[buyBtn setTitle:@"立刻购买" forState:UIControlStateNormal];
	[buyBtn setBackgroundColor:ThemeColor];
	buyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
	[buyBtn addTarget:self action:@selector(buyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
	[toolBar addSubview:buyBtn];

	CGFloat btnWidth = ScreenWidth * 0.18;
	[basketBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(toolBar.mas_left);
		make.top.equalTo(toolBar);
		make.bottom.equalTo(toolBar);
		make.width.mas_equalTo(btnWidth);
	}];
	[storeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(basketBtn.mas_right);
		make.top.equalTo(toolBar);
		make.bottom.equalTo(toolBar);
		make.width.mas_equalTo(btnWidth);
	}];
	[likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(storeBtn.mas_right);
		make.top.equalTo(toolBar);
		make.bottom.equalTo(toolBar);
		make.width.mas_equalTo(btnWidth);
	}];
	
	[addBasketBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(likeBtn.mas_right);
		make.top.equalTo(toolBar);
		make.bottom.equalTo(toolBar);
		make.width.mas_equalTo(ScreenWidth *0.23);
	}];
	
	[buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(addBasketBtn.mas_right);
		make.top.equalTo(toolBar);
		make.bottom.equalTo(toolBar);
		make.width.mas_equalTo(ScreenWidth *0.23);
	}];

}
//分享商品
- (void)shareGoodsClick
{
	NSLog(@"-------shareGoodsClick-------");
	[SVProgressHUD showSuccessWithStatus:@"点击分享"];
}

//购物篮点击
- (void)basketBtnClicked
{
	NSLog(@"-----------basketBtnClicked------");
	[SVProgressHUD showSuccessWithStatus:@"点击购物篮"];
}

//店铺点击
- (void)storeBtnClicked
{
	NSLog(@"-----------storeBtnClicked------");
	[self.navigationController pushViewController:[[YJStoreHomeController alloc] init] animated:YES];
}

//收藏点击
- (void)likeBtnClicked
{
	NSLog(@"-----------likeBtnClicked------");
	[SVProgressHUD showSuccessWithStatus:@"点击收藏"];
}

//加入购物篮
- (void)addBasketBtnClicked
{
	NSLog(@"-----------addBasketBtnClicked------");
	[UIView animateWithDuration:0.5 animations:^{
		self.buyView.hidden = NO;
	} completion:^(BOOL finished) {
	}];
	
}

//立刻购买
- (void)buyBtnClicked
{
	NSLog(@"-----------buyBtnClicked------");
	[SVProgressHUD showSuccessWithStatus:@"buyBtnClicked"];
}
#pragma mark --UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		if (indexPath.row == 0 ) {
			
			cell.accessoryType = UITableViewCellAccessoryNone;
			UIView *cellView = [[UIView alloc] init];
			[cell.contentView addSubview:cellView];
			
			UILabel *titleLabel = [[UILabel alloc] init];
			titleLabel.text = self.goodsName;
			[cellView addSubview:titleLabel];
			
			UILabel *priceLabel = [[UILabel alloc] init];
			[priceLabel setTextColor:[UIColor redColor]];
			priceLabel.text = [NSString stringWithFormat:@"￥%@",self.goodsPrice];
			[cellView addSubview:priceLabel];
			
			UILabel *origPriceLabel = [[UILabel alloc] init];
			[origPriceLabel setFont:[UIFont systemFontOfSize:12.0]];
			[origPriceLabel setTextColor:[UIColor lightGrayColor]];
			NSString *origPricetext = [NSString stringWithFormat:@"￥%@",self.goodsOrigPrice];
			NSAttributedString *attrStr =
			[[NSAttributedString alloc] initWithString:origPricetext
											attributes:
			 @{
			   NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
			   NSStrikethroughColorAttributeName:[UIColor lightGrayColor]}];
			
			origPriceLabel.attributedText =  attrStr;
			[cellView addSubview:origPriceLabel];
			
			UILabel *saleNumLabel = [[UILabel alloc] init];
			[saleNumLabel setFont:[UIFont systemFontOfSize:12.0]];
			[origPriceLabel setTextColor:[UIColor lightGrayColor]];
			saleNumLabel.text = [NSString stringWithFormat:@"已售%@件",self.goodsSaleNum];
			[cellView addSubview:saleNumLabel];
			
			[cellView mas_makeConstraints:^(MASConstraintMaker *make) {
				make.top.mas_equalTo(cell.contentView);
				make.left.mas_equalTo(cell.contentView).offset(10);
				make.right.mas_equalTo(cell.contentView).offset(-10);
				make.bottom.mas_equalTo(cell.contentView);
			}];
			[titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
				make.top.mas_equalTo(cellView).offset(10);
				make.left.mas_equalTo(cellView);
				make.width.mas_equalTo(cellView);
				make.height.mas_equalTo(25);
			}];
			[priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
				make.top.mas_equalTo(titleLabel.mas_bottom).offset(5);
				make.left.mas_equalTo(titleLabel.mas_left);
				make.size.mas_equalTo(CGSizeMake(80, 25));
			}];
			[origPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
				make.top.mas_equalTo(priceLabel.mas_top);
				make.left.mas_equalTo(priceLabel.mas_right);
				make.size.mas_equalTo(CGSizeMake(80, 25));
			}];
			[saleNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
				make.top.mas_equalTo(priceLabel.mas_top);
				make.right.mas_equalTo(cellView.mas_right);
				make.size.mas_equalTo(CGSizeMake(80, 25));
			}];
		} else if (indexPath.row == 1) {
			cell.textLabel.text = self.goodsDesc;
			
			cell.accessoryType = UITableViewCellAccessoryNone;
		} else if (indexPath.row == 2) {
			
			cell.textLabel.text = @"产品详情";
		}
		else if (indexPath.row == 3) {
			
			cell.textLabel.text = @"商品评价";
		}
		else if (indexPath.row == 4) {
			
			cell.textLabel.text = @"物流信息";
		}
		else if (indexPath.row == 5) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
			cell.textLabel.text = @"联系客服(9:00-18:00)";
			cell.detailTextLabel.text = @"4006-277-717";
			cell.accessoryType = UITableViewCellAccessoryNone;
		}
		
	}

	return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 0 || indexPath.row == 1) {
		return 80;
	} else {
		return 44;
	}
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (indexPath.row == 2) {
		YJGoodsDetailViewController *goodsDetailVC = [[YJGoodsDetailViewController alloc] init];
		goodsDetailVC.goodsDetailURL = self.goodsDetailURL;
		[self.navigationController pushViewController:goodsDetailVC animated:YES];
	}
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat contentOffY = scrollView.contentOffset.y;
	
	if (contentOffY > 20) {
		[self.navigationController.navigationBar setHidden:NO ];
	}else{
		[self.navigationController.navigationBar setHidden:NO];
	}
}

#pragma mark --YJBuyViewDelegate
-(void)closeView
{
	[UIView animateWithDuration:0.5 animations:^{
		self.buyView.hidden = YES;
	}];
}
-(void)doneButtonClick:(NSInteger)goodsNum
{
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, ScreenHeight*0.6, 50, 50)];
	imageView.image = [UIImage imageNamed:@""];
	self.picImageView = imageView;
	[self.buyView addSubview:imageView];
	
	CABasicAnimation *rotAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	rotAnimation.toValue = [NSNumber numberWithFloat:M_PI * 11.0];
	rotAnimation.duration = 1.0;
	rotAnimation.cumulative = YES;
	rotAnimation.repeatCount = 0;
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[_picImageView.layer addAnimation:rotAnimation forKey:@"rotationAnimation"];
	});
	[UIView animateWithDuration:1.0f animations:^{
		_picImageView.frame = CGRectMake(20, ScreenHeight-20, 0, 0);
	} completion:^(BOOL finished) {
		[_picImageView removeFromSuperview];
		self.buyView.hidden = YES;
		
		
	}];
	[SVProgressHUD showSuccessWithStatus:@"已加入购物车"];
}
@end
