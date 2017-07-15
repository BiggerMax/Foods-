//
//  YJStoreMenuView.h
//  Foods++
//
//  Created by 袁杰 on 2017/7/15.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleIconBtnModel.h"

@protocol YJStoreMenuViewDelegate <NSObject>

-(void)menuBtnClick;

@end
@interface YJStoreMenuView : UIView
@property(nonatomic,weak)id<YJStoreMenuViewDelegate>delegate;
-(instancetype)initMenu:(NSArray<TitleIconBtnModel *>*)menuArray;
@end
