//
//  MGComposeToolBar.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/25.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGComposeToolBarItemButton.h"

#define ToolBbarHeight  44

typedef enum {
    MGComposeToolBarButtonTypeCarema,
    MGComposeToolBarButtonTypePicture,
    MGComposeToolBarButtonTypeMention,
    MGComposeToolBarButtonTypeTrend,
    MGComposeToolBarButtonTypeEmotion
} MGComposeToolBarButtonType;
@protocol ComposeToolBarDetegate <NSObject>

-(void)composeToolBarDidClickedItem:(MGComposeToolBarButtonType)tag;

@end


@interface MGComposeToolBar : UIImageView
@property(nonatomic,assign)id delegate;
@end
