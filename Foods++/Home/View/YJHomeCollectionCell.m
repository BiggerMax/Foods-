//
//  YJHomeCollectionCell.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJHomeCollectionCell.h"

@interface YJHomeCollectionCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
@implementation YJHomeCollectionCell
-(void)awakeFromNib
{
	[super awakeFromNib];
	self.layer.borderWidth = 0.5;
	self.layer.borderColor = RGB(211, 192, 162).CGColor;
}
- (void)setPciName:(NSString *)pciName
{
	self.imageView.image = [UIImage imageNamed:pciName];
}

- (void)setName:(NSString *)name
{
	self.nameLabel.text = name;
}

- (void)setPrice:(NSString *)price
{
	self.priceLabel.text = price;
}
@end
