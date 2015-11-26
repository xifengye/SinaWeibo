//
//  MGComposeToolBarItemButton.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/25.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGComposeToolBarItemButton : UIButton
@property(nonatomic,assign)UIControlState clickState;
-(instancetype)initWithStatus:(UIControlState)state stateImageName:(NSString*)imageName stateNormalImageName:(NSString*)normalImageName;
@end
