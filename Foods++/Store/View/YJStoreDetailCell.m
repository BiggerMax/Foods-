//
//  YJStoreDetailCell.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJStoreDetailCell.h"

@interface YJStoreDetailCell()
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *shopDesc;
@property (weak, nonatomic) IBOutlet UILabel *saleNum;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *originalPrice;

@end
@implementation YJStoreDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
	static NSString *ID = @"StoreDetailCell";
	YJStoreDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
	if (cell == nil) {
		cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
	}
	return cell;
}
-(void)setModel:(YJStoreDetailModel *)model
{
	self.shopName.text = model.goods_name;
	self.shopDesc.text = model.goods_jingle;
	self.priceLabel.text = [NSString stringWithFormat:@"￥ %@",model.goods_price];
	NSString *origPricetext = [NSString stringWithFormat:@"原价: %@",model.goods_marketprice];
	NSAttributedString *attrStr =
	[[NSAttributedString alloc] initWithString:origPricetext
									attributes:
	 @{
	   NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
	   NSStrikethroughColorAttributeName:[UIColor lightGrayColor]}];
	
	self.originalPrice.attributedText =  attrStr;
	self.saleNum.text = [NSString stringWithFormat:@"已售: %@件",model.goods_salenum] ;
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		[self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.goods_image_url]];
	});

}
- (void)awakeFromNib {
    [super awakeFromNib];
	self.width = ScreenWidth;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (CGFloat)cellHeight
{
	[self layoutIfNeeded];
	
	return CGRectGetMaxY(self.saleNum.frame) + 15;
	
}
@end
