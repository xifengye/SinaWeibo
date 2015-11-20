//
//  MGStatusToolBar.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/18.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusFrame.h"

@interface MGStatusToolBar : UIImageView
-(void)addToolItem:(UIView*)view;
@property (nonatomic,strong)StatusFrame* statusFrame;
@property(nonatomic,weak)UIButton* repostsBtn;
@property(nonatomic,weak)UIButton* commentsBtn;
@property(nonatomic,weak)UIButton* attitudesBtn;
@end
