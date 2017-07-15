//
//  YJBasketViewController.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJBasketViewController.h"
#import "YJBasketGoodsModel.h"
#import "YJBasketGoodsCell.h"
@interface YJBasketViewController ()<UITableViewDelegate,UITableViewDataSource,YJBasketGoodsCellDelegate>
@property (nonatomic, strong) NSMutableArray *goodsArray;
@property (nonatomic, strong) UITableView *tableView ;
@property (nonatomic,strong)UIRefreshControl *rfcontrol;
@property (nonatomic, strong) UIButton *selImage;
@property (nonatomic, strong) UILabel *totalPrice;
@property (nonatomic, strong) UIButton *selectBtn ;

@property (nonatomic, assign) BOOL flag;
@end

@implementation YJBasketViewController
- (NSMutableArray *)goodsArray
{
	if (!_goodsArray) {
		_goodsArray = [NSMutableArray array];
	}
	return _goodsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.flag = NO;
	[self setupNav];
	[self loadData];
	[self setupTableView];
	[self setupFooterView];
}
-(void)setupNav
{
	self.view.backgroundColor = [UIColor whiteColor];
	self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: ThemeColor};
	self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(editClick) text:@"编辑" textColor:[UIColor grayColor]];
}
-(void)loadData
{
	
}
-(void)setupTableView{
	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
	tableView.dataSource = self;
	tableView.delegate = self;
	tableView.backgroundColor = [UIColor whiteColor];
	self.tableView = tableView;
	[self.view addSubview:tableView];
	//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	
	self.rfcontrol = [[UIRefreshControl alloc] init];
	self.rfcontrol.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
	[self.rfcontrol addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
	[tableView addSubview:self.rfcontrol];

}
-(void)setupFooterView{
	UIView *footerView = [[UIView alloc] init];
	[footerView setBackgroundColor:[UIColor whiteColor]];
	footerView.layer.borderColor = ThemeColor.CGColor;
	footerView.layer.borderWidth = 0.5;
	[self.view addSubview:footerView];
	
	UIButton *selImage = [UIButton buttonWithType:UIButtonTypeCustom];
	[selImage setImage:[UIImage imageNamed:@"car_noSelect"] forState:UIControlStateNormal];
	[selImage addTarget:self action:@selector(allSelectClick:) forControlEvents:UIControlEventTouchUpInside];
	[selImage setImage:[UIImage imageNamed:@"car_Select"] forState:UIControlStateSelected];
	self.selImage = selImage;
	[footerView addSubview:selImage];
	
	
	UILabel *allSelect = [[UILabel alloc] init];
	allSelect.text = @"全选";
	[footerView addSubview:allSelect];
	
	UILabel *allPrice = [[UILabel alloc] init];
	allPrice.text = @"合计:";
	allPrice.textAlignment = NSTextAlignmentRight;
	allPrice.font = [UIFont systemFontOfSize:13.0];
	[footerView addSubview:allPrice];
	
	UILabel *totalPrice = [[UILabel alloc] init];
	totalPrice.text =@"￥0.00";
	totalPrice.textAlignment = NSTextAlignmentLeft;
	totalPrice.font = [UIFont systemFontOfSize:13.0];
	totalPrice.textColor = ThemeColor;
	self.totalPrice = totalPrice;
	[footerView addSubview:totalPrice];
	
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn setBackgroundColor:ThemeColor];
	[btn setTitle:@"结算" forState:UIControlStateNormal];
	[btn setTintColor:[UIColor whiteColor]];
	[btn.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
	[btn addTarget:self action:@selector(buyBtnClick) forControlEvents:UIControlEventTouchUpInside];
	[footerView addSubview:btn];
	
	[footerView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.view.mas_left).offset(-0.5);
		make.right.mas_equalTo(self.view.mas_right).offset(0.5);
		make.bottom.mas_equalTo(self.view.mas_bottom).offset(-43.5);
		make.height.mas_equalTo(@44);
	}];
	
	[selImage mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(footerView).mas_equalTo(11);
		make.left.mas_equalTo(footerView).mas_equalTo(10);
		make.size.mas_equalTo(CGSizeMake(20, 20));
	}];
	
	[allSelect mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(footerView).mas_equalTo(11);
		make.left.mas_equalTo(selImage.mas_right).mas_equalTo(10);
		make.size.mas_equalTo(CGSizeMake(40, 20));
	}];
	
	[btn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(footerView.mas_right);
		make.top.mas_equalTo(footerView.mas_top);
		make.bottom.mas_equalTo(footerView.mas_bottom);
		make.width.mas_equalTo(100);
	}];
	
	[totalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(footerView).mas_equalTo(11);
		make.right.mas_equalTo(btn.mas_left).mas_equalTo(-20);
		make.height.mas_equalTo(20);
	}];
	
	[allPrice mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(footerView).mas_equalTo(11);
		make.right.mas_equalTo(totalPrice.mas_left).mas_equalTo(-5);
		make.size.mas_equalTo(CGSizeMake(40, 20));
	}];

}
- (void)editClick
{
	NSLog(@"------editClick-------");
}

- (void)buyBtnClick
{
	NSLog(@"------buyBtnClick-------");
	[SVProgressHUD showSuccessWithStatus:@"立刻购买"];
}

- (void)allSelectClick:(UIButton *)button
{
	button.selected = !button.selected;
	
	for (YJBasketGoodsModel *shopModel in self.goodsArray) {
		shopModel.selectBtn = button.selected;
		self.selectBtn.selected = button.selected;
	}
	[self.tableView reloadData];
	if (button.selected) {
		[self.selectBtn setImage:[UIImage imageNamed:@"car_Select"] forState:UIControlStateSelected];
		[self updateAllprice];
	} else {
		self.totalPrice.text = @"￥:0.00";
	}
}
- (void)updateAllprice {
	CGFloat allmoney = 0;
	for (YJBasketGoodsModel *shopModel in self.goodsArray) {
		NSInteger goodsPrice = shopModel.goods_price.integerValue;
		NSInteger goodsNum = shopModel.goods_num.integerValue;
		if (shopModel.selectBtn == YES) {
			allmoney += goodsPrice * goodsNum;
		} else {
			
		}
		
		
	}
	NSString *moneys = [NSString stringWithFormat:@"¥%.2f",allmoney];
	self.totalPrice.text = moneys;
}

- (void)refresh
{
	[self.goodsArray removeAllObjects];
	[self loadData];
	[self.tableView reloadData];
	[self.rfcontrol endRefreshing];
}
#pragma mark --UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.goodsArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	YJBasketGoodsCell *cell = [YJBasketGoodsCell cellWithTableView:tableView];
	cell.model = self.goodsArray[indexPath.row];
	cell.indexPath = indexPath;
	cell.delegate = self;
	return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 110;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *head = [[UIView alloc] init];
	head.backgroundColor = [UIColor whiteColor];
	
	UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[selectBtn setImage:[UIImage imageNamed:@"car_noSelect"] forState:UIControlStateNormal];
	[selectBtn setImage:[UIImage imageNamed:@"car_Select"] forState:UIControlStateSelected];
	[selectBtn addTarget:self action:@selector(allSelectClick:) forControlEvents:UIControlEventTouchUpInside];
	self.selectBtn = selectBtn;
	[head addSubview:selectBtn];
	
	UIImageView *storeImg = [[UIImageView alloc] init];
	storeImg.image = [UIImage imageNamed:@"shopIcon"];
	[head addSubview:storeImg];
	
	UILabel *storeNameLabel = [[UILabel alloc] init];
	storeNameLabel.text = @"悦食家";
	storeNameLabel.textColor = ThemeColor;
	storeNameLabel.font = [UIFont systemFontOfSize:15.0];
	[head addSubview:storeNameLabel];
	
	UIImageView *inImg = [[UIImageView alloc] init];
	inImg.image = [UIImage imageNamed:@"btn_in"];
	[head addSubview:inImg];
	
	[selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(head).mas_equalTo(11);
		make.left.mas_equalTo(head).mas_equalTo(10);
		make.size.mas_equalTo(CGSizeMake(20, 20));
	}];
	
	[storeImg mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(selectBtn.mas_top);
		make.left.mas_equalTo(selectBtn.mas_right).mas_equalTo(20);
		make.size.mas_equalTo(CGSizeMake(20, 20));
	}];
	
	[storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(selectBtn.mas_top);
		make.left.mas_equalTo(storeImg.mas_right).mas_equalTo(20);
		make.height.mas_equalTo(20);
	}];
	
	[inImg mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(head.mas_right).offset(-15);
		make.centerY.mas_equalTo(head.mas_centerY);
		make.size.mas_equalTo(CGSizeMake(6, 11));
	}];
	
	return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 44;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}
//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		
		YJBasketGoodsModel *model = self.goodsArray[indexPath.row];
		NSInteger index = model.goods_id.integerValue;
		NSLog(@"---->%ld",index);
		[self.goodsArray removeObjectAtIndex:indexPath.row];
		[self deleteGoodsData:index];
		[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
		
	}
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return @"删除";
}
#pragma mark - cellDelegate
- (void)selectGoodsClick:(NSIndexPath *)indexPath btn:(UIButton *)btn
{
	if (btn.selected == NO) {
		self.selImage.selected = btn.selected;
	}
	YJBasketGoodsModel *shopModel = self.goodsArray[indexPath.row];
	shopModel.selectBtn = btn.selected;
	[self updateAllprice];
}
- (void)deleteGoodsData:(NSInteger)index
{
	NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
	NSString *sqlFilePath = [path stringByAppendingPathComponent:@"goods.sqlite"];
	
	}
@end
