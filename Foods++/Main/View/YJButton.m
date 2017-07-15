//
//  YJButton.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJButton.h"

@implementation YJButton

//-(instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//	if (self = [super initWithCoder:aDecoder]) {
//		self.titleLabel.textAlignment = NSTextAlignmentCenter;
//		self.imageView.contentMode = UIViewContentModeScaleAspectFit;
//		self.titleLabel.font = [UIFont systemFontOfSize:12];
//	}
//	return self;
//}
-(instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		self.titleLabel.textAlignment = NSTextAlignmentCenter;
		self.imageView.contentMode = UIViewContentModeScaleAspectFit;
		self.titleLabel.font = [UIFont systemFontOfSize:12];
	}
	return self;
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
	CGFloat titleX = 0;
	CGFloat titleY = contentRect.size.height * 0.65;
	CGFloat titleW = contentRect.size.width;
	CGFloat titleH = contentRect.size.height - titleY;
	return CGRectMake(titleX, titleY, titleW, titleH);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
	CGFloat imageW = CGRectGetWidth(contentRect);
	CGFloat imageH = contentRect.size.height * 0.4;
	return CGRectMake(0, 5, imageW, imageH);
}
@end
