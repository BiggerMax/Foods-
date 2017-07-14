//
//  YJVideoCell.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJVideoCell.h"

@implementation YJVideoCell
+(instancetype)cellWithTableView:(UITableView *)tableView
{
	static NSString *ID = @"VideoCell";
	
	YJVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
	if (cell == nil) {
		cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
		cell.selectionStyle =UITableViewCellSelectionStyleNone;
	}
	return cell;

}
- (void)setModel:(YJVideoModel *)model
{
	_model = model;
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		[self.backImageView sd_setImageWithURL:[NSURL URLWithString:model.article_image]];
	});
	self.timeLabel.text = model.video_length;
	self.titleLabel.text = model.article_title;
	self.descLabel.text = model.article_abstract;
	
}
- (CGFloat)cellHeight
{
	[self layoutIfNeeded];
	
	return CGRectGetMaxY(self.descLabel.frame) + 25;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
