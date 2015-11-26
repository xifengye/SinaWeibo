//
//  MGComposeToolBarItemButton.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/25.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import "MGComposeToolBarItemButton.h"

@implementation MGComposeToolBarItemButton
-(instancetype)initWithStatus:(UIControlState)state stateImageName:(NSString*)imageName stateNormalImageName:(NSString*)normalImageName{
    if(self=[super init]){
        [self setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:imageName] forState:state];
        self.clickState = state;
    }
    return self;
}


@end
