//
//  MGComposeToolBar.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/25.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import "MGComposeToolBar.h"

@implementation MGComposeToolBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = true;
        self.image = [UIImage imageNamed:@"compose_toolbar_background"];
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews{
    MGComposeToolBarItemButton* picturebutton = [[MGComposeToolBarItemButton alloc] initWithStatus:UIControlStateHighlighted stateImageName:@"compose_toolbar_picture_highlighted" stateNormalImageName:@"compose_toolbar_picture"];
    [self addItemByTag:picturebutton tag:MGComposeToolBarButtonTypePicture];
    
    MGComposeToolBarItemButton* camerabutton = [[MGComposeToolBarItemButton alloc] initWithStatus:UIControlStateHighlighted stateImageName:@"compose_camerabutton_background_highlighted" stateNormalImageName:@"compose_camerabutton_background"];
    [self addItemByTag:camerabutton tag:MGComposeToolBarButtonTypeCarema];

    MGComposeToolBarItemButton* trendbutton = [[MGComposeToolBarItemButton alloc] initWithStatus:UIControlStateHighlighted stateImageName:@"compose_trendbutton_background_highlighted" stateNormalImageName:@"compose_trendbutton_background"];
    [self addItemByTag:trendbutton tag:MGComposeToolBarButtonTypeTrend];
    
    MGComposeToolBarItemButton* mentionbutton = [[MGComposeToolBarItemButton alloc] initWithStatus:UIControlStateHighlighted stateImageName:@"compose_mentionbutton_background_highlighted" stateNormalImageName:@"compose_mentionbutton_background"];
    [self addItemByTag:mentionbutton tag:MGComposeToolBarButtonTypeMention];
    
    
    MGComposeToolBarItemButton* emoticonbutton = [[MGComposeToolBarItemButton alloc] initWithStatus:UIControlStateSelected stateImageName:@"compose_emoticonbutton_background_highlighted" stateNormalImageName:@"compose_emoticonbutton_background"];
    [self addItemByTag:emoticonbutton tag:MGComposeToolBarButtonTypeEmotion];
   }

-(void)addItemByTag:(MGComposeToolBarItemButton *)item tag:(MGComposeToolBarButtonType)tag{
    item.tag = tag;
    [self addSubview:item];
    [item addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)clicked:(MGComposeToolBarItemButton*)button{
    if(button.clickState==UIControlStateSelected){
        button.selected = !button.selected;
    }
    if([self.delegate respondsToSelector:@selector(composeToolBarDidClickedItem:)]){
        [self.delegate composeToolBarDidClickedItem:button.tag];
    }
}

-(void)layoutSubviews{
    CGFloat itemWidth = self.frame.size.width /self.subviews.count;
    CGFloat itemHeight = ToolBbarHeight;
    CGFloat itemY = 0;
    CGFloat itemX = 0;
    for (int i=0; i<self.subviews.count; i++) {
        UIView* child = self.subviews[i];
        child.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
        itemX+=itemWidth;
    }
}

@end
