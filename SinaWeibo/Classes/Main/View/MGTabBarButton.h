//
//  UICustomTabBarButton.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/6.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGTabBarButton : UIButton
-(void)setItem:(UITabBarItem *)item;
-(void)setBadgeValue:(NSString*)badgeValue;
@end
