//
//  YJStoreMenuView.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJStoreMenuView.h"
#import "YJTitleIcon.h"
@interface YJStoreMenuView()
@property(nonatomic,strong)NSArray *menuArray;
@end
static const NSInteger DefaultRowNumbers = 4;
@implementation YJStoreMenuView
-(instancetype)initMenu:(NSArray<TitleIconBtnModel *> *)menuArray
{
	if (self = [super init]) {
		self.backgroundColor = [UIColor whiteColor];
		self.menuArray = menuArray;
		for (TitleIconBtnModel *model in menuArray) {
			YJTitleIcon *titleView = [[YJTitleIcon alloc] initWithTitleLabel:model.title icon:model.icon boder:NO];
			titleView.tag = model.tag;
			titleView.userInteractionEnabled = YES;
			UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleIconViewClick)];
			[titleView addGestureRecognizer:tap];
			[self addSubview:titleView];
		}
	}
	return  self;
}
-(void)titleIconViewClick
{
	if ([self.delegate respondsToSelector:@selector(menuBtnClick)]) {
		[self.delegate menuBtnClick];
	}
}
-(void)layoutSubviews
{
	[super layoutSubviews];
	CGFloat width = ScreenWidth / DefaultRowNumbers;
	CGFloat heigth = 90;
	for (int i = 0; i < self.subviews.count; i ++) {
		YJTitleIcon *titleIcon = self.subviews[i];
		CGFloat viewX = width * (i % DefaultRowNumbers);
		CGFloat viewY = heigth * (i / DefaultRowNumbers);
		titleIcon.frame = CGRectMake(viewX, viewY, width, heigth);
	}
}


@end
