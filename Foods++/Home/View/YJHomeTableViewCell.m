//
//  YJHomeTableViewCell.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJHomeTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface YJHomeTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *picImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (weak, nonatomic) IBOutlet UIButton *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeLabel;

@end

@implementation YJHomeTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
	static NSString *ID = @"HomeCell";
	YJHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
	if (cell == nil) {
		cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
	}
	return cell;
}
-(void)awakeFromNib
{
	[super awakeFromNib];
	self.width = ScreenWidth;
	self.priceLabel.layer.borderWidth = 0.5;
	self.priceLabel.layer.borderColor = RGB(211, 192, 162).CGColor;
	self.priceLabel.layer.cornerRadius = 5.0;
	self.likeLabel.layer.borderWidth = 0.5;
	self.likeLabel.layer.borderColor = RGB(211, 192, 162).CGColor;
	self.likeLabel.layer.cornerRadius = 5.0;

}
- (void)setModel:(YJHomeCellModel *)model
{
	_model = model;
	[self.picImage sd_setImageWithURL:[NSURL URLWithString:model.relation_object_image]];
	self.nameLabel.text = model.relation_object_title;
	[self.priceLabel setTitle:[NSString stringWithFormat:@"$ %@",model.goods_price] forState:UIControlStateNormal];
	self.describeLabel.text = model.relation_object_jingle;
}
- (CGFloat)cellHeight
{
	[self layoutIfNeeded];
	
	return CGRectGetMaxY(self.describeLabel.frame) + 35;
	
}
@end
