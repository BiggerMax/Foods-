//
//  YJBuyView.h
//  Foods++
//
//  Created by 袁杰 on 2017/7/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YJBuyViewDelegate <NSObject>

-(void)doneButtonClick:(NSInteger)goodsNum;
-(void)closeView;
@end

@interface YJBuyView : UIView
@property (nonatomic, weak) id<YJBuyViewDelegate> delegate;
@property (nonatomic, copy) NSString *goodsName;
@property (nonatomic, copy) NSString *goodsPicName;
@property (nonatomic, copy) NSString *goodsPrice;
@property (nonatomic, copy) NSString *goodsOrigPrice;
@property (nonatomic, strong) UIImageView *picImageView;
@end
