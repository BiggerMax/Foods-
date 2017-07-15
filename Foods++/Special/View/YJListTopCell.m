//
//  YJListTopCell.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJListTopCell.h"

@interface YJListTopCell()
@property (weak, nonatomic) IBOutlet UILabel *FromLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UIView *AView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *abstractLabel;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;

@end
@implementation YJListTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
	self.width = ScreenWidth;
	self.AView.layer.borderColor = ThemeColor.CGColor;
	self.AView.layer.borderWidth = 0.5;

}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
	static NSString *ID = @"ListTopCell";
	
	YJListTopCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
	if (cell == nil) {
		cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
		cell.selectionStyle =UITableViewCellSelectionStyleNone;
	}
	return cell;
}
- (void)setModel:(YJListTopModel *)model
{
	_model = model;
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		
		[self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.article_image]];
	});
	self.abstractLabel.text = model.article_abstract;
	self.topLabel.text = [NSString stringWithFormat:@"TOP %@",model.top];
	self.titleLabel.text = model.article_title;
	self.FromLabel.text = model.article_origin;
	
}



- (CGFloat)cellHeight
{
	[self layoutIfNeeded];
	
	return CGRectGetMaxY(self.FromLabel.frame) + 25;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
