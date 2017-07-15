//
//  YJMapCell.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJMapCell.h"

@interface YJMapCell()
@property (weak, nonatomic) IBOutlet UILabel *localLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;

@end
@implementation YJMapCell

- (void)awakeFromNib {
    [super awakeFromNib];
	self.width = ScreenWidth;

}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
	static NSString *ID = @"MapCell";
	
	YJMapCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
	if (cell == nil) {
		cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
		cell.selectionStyle =UITableViewCellSelectionStyleNone;
	}
	return cell;
}

- (void)setModel:(YJMapModel *)model
{
	_model = model;
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		
		[self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.article_image]];
	});
	self.localLabel.text = model.article_title;
	self.titleLabel.text = model.article_abstract;
	
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
