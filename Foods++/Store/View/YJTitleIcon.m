//
//  YJTitleIcon.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJTitleIcon.h"

@interface YJTitleIcon()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *iconView;
@end
@implementation YJTitleIcon

-(instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		_titleLabel = [UILabel new];
		_titleLabel.textAlignment = NSTextAlignmentCenter;
		_titleLabel.textColor = [UIColor blackColor];
		_titleLabel.font = [UIFont systemFontOfSize:15];
		[self addSubview:_titleLabel];
		
		_iconView = [UIImageView new];
		[self addSubview:_iconView];
		
		[_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.equalTo(self);
			make.centerY.equalTo(self).offset(-10);
			make.size.mas_equalTo(CGSizeMake(30, 30));
		}];
		[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(_iconView.mas_bottom).offset(8);
			make.leading.trailing.equalTo(self);
			make.height.mas_equalTo(19);
		}];
	}
	return self;
}
-(instancetype)initWithTitleLabel:(NSString *)titleLabel icon:(NSString *)icon boder:(BOOL)boder
{
	if (self = [super init]) {
		self.titleLabel.text = titleLabel;
		[self.iconView sd_setImageWithURL:[NSURL URLWithString:icon] placeholderImage:nil];
	}
	return self;
}
@end
