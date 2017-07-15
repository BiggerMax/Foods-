//
//  YJActivityCell.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJActivityCell.h"

@interface YJActivityCell()
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;

@end
@implementation YJActivityCell

- (void)awakeFromNib {
    [super awakeFromNib];
	self.width = ScreenWidth;
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
	static NSString *ID = @"MapCell";
	
	YJActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
	if (cell == nil) {
		cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
		cell.selectionStyle =UITableViewCellSelectionStyleNone;
	}
	return cell;

}
- (void)setModel:(YJActivityModel *)model
{
	_model = model;
	
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		[self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.goods_image]];
	});
	
	self.nameLabel.text = model.goods_name;
	self.endLabel.text = model.end_virtual;
	self.hintLabel.text = model.hint_virtual;
}

- (CGFloat)cellHeight
{
	[self layoutIfNeeded];
	
	return CGRectGetMaxY(self.picImageView.frame) + 35;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
