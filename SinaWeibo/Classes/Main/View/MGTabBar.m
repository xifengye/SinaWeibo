//
//  UICustomTabBar.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/5.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "MGTabBar.h"
#import "MGTabBarButton.h"

@interface MGTabBar()

@property (nonatomic,strong)NSMutableArray* tabButtons;
@property (nonatomic,weak) MGTabBarButton* selectBtn;
@property (nonatomic,retain)UIButton* plusButton;

@end

@implementation MGTabBar

-(NSMutableArray*)tabButtons{
    if(_tabButtons==nil){
        _tabButtons=[NSMutableArray array];
    }
    return _tabButtons;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
    }
    
    UIButton* plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    plusButton.bounds = CGRectMake(0, 0, plusButton.currentBackgroundImage.size.width, plusButton.currentBackgroundImage.size.height);
    [plusButton addTarget:self action:@selector(onPlusButtonClicked:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:plusButton];
    self.plusButton = plusButton;
    return self;
}

-(void)addTabItem:(UITabBarItem *)item{
    MGTabBarButton* btn = [[MGTabBarButton alloc] init];
    [btn setItem:item];
    [btn addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn];
    [self.tabButtons addObject:btn];
    if(self.tabButtons.count==1){
        [self onButtonClicked:btn];
    }
    
}

-(void)onPlusButtonClicked:(UIButton*)button{
    if([self.delegate respondsToSelector:@selector(plusBar:)]){
        [self.delegate plusBar:self];
    }
}

-(void)onButtonClicked:(MGTabBarButton*)button{
    if([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]){
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectBtn.tag to:button.tag];
    }
    self.selectBtn.selected = NO;
    button.selected = YES;
    self.selectBtn = button;
}

-(void)layoutSubviews{
    CGFloat width = self.frame.size.width/self.subviews.count;
    CGFloat height = self.frame.size.height;
    self.plusButton.center = CGPointMake(self.frame.size.width*0.5,height/2);
    CGFloat y = 0;
    for (UIView* childView in self.tabButtons) {
        int index = [self.tabButtons indexOfObject:childView];
        CGFloat x = width * index;
        if(index>=self.tabButtons.count/2){
            x+=width;
        }
        childView.tag = index;
        childView.frame = CGRectMake(x, y, width, height);
    }
}

@end
