//
//  YJBasketGoodsCell.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJBasketGoodsCell.h"

@interface YJBasketGoodsCell()
@property(nonatomic,strong) UIImageView *selectmageView;
@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end
@implementation YJBasketGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(allSelectClicked)];
	[self.selectmageView addGestureRecognizer:tap];
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
	static NSString *ID = @"BasketGoodsCell";
	
	YJBasketGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
	if (cell == nil) {
		cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
		cell.selectionStyle =UITableViewCellSelectionStyleNone;
	}
	return cell;
}
- (void)setModel:(YJBasketGoodsModel *)model
{
	_model = model;
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		[self.picView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
	});
	
	self.selectBtn.selected = model.selectBtn;
	self.goodsNameLabel.text = model.goods_name;
	self.goodsDescLabel.text = model.goods_desc;
	self.goodsPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.goods_price];
	self.goodsNumLabel.text = [NSString stringWithFormat:@"x%@",model.goods_num];
	
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selectBtnClick:(UIButton *)sender {
}

@end
