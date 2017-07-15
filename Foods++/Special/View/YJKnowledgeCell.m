//
//  YJKnowledgeCell.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJKnowledgeCell.h"

@interface YJKnowledgeCell()
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *qaLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end
@implementation YJKnowledgeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.width = ScreenWidth;
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
	static NSString *ID = @"KnowledgeCell";
	
	YJKnowledgeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
	if (cell == nil) {
		cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
		cell.selectionStyle =UITableViewCellSelectionStyleNone;
	}
	return cell;
}
- (void)setModel:(YJKnowledgeMoedel *)model
{
	_model = model;
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		
		[self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.article_image]];
	});
	
	self.titleLabel.text = model.article_title;
	self.descLabel.text = model.article_abstract;
	
}



- (CGFloat)cellHeight
{
	[self layoutIfNeeded];
	
	return CGRectGetMaxY(self.descLabel.frame) + 25;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
