//
//  YJStoreCell.m
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJStoreCell.h"

@interface YJStoreCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;

@end
@implementation YJStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.width = ScreenWidth;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
	static NSString *ID = @"StoreCell";
	YJStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
	if (cell == nil) {
		cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
	}
	return cell;
}


- (void)setModels:(YJStoreModel *)models
{
	_models = models;
	
	self.titleLabel.text = models.special_title;
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		
		[self.picImageView sd_setImageWithURL:[NSURL URLWithString:models.special_image] placeholderImage:nil];
		dispatch_async(dispatch_get_main_queue(), ^{
			
		});
	});
}

- (CGFloat)cellHeight
{
	[self layoutIfNeeded];
	
	return CGRectGetMaxY(self.picImageView.frame) + 15;
	
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
