//
//  YJToolBarButton.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJToolBarButton.h"

@implementation YJToolBarButton

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder]) {
		[self initialize];
	}
	return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		[self initialize];
	}
	return self;
}
-(void)initialize
{
	self.titleLabel.textAlignment = NSTextAlignmentCenter;
	self.imageView.contentMode = UIViewContentModeScaleAspectFit;
	self.titleLabel.font = [UIFont systemFontOfSize:12];
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
	CGFloat titleX = 0;
	CGFloat titleY = contentRect.size.height * 0.6;
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
