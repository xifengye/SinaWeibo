//
//  ViewController.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/4.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "MainController.h"
#import "MGDiscoverController.h"
#import "MGHomeController.h"
#import "MGMessageController.h"
#import "MGNavigationController.h"
#import "MGMeController.h"
#import "MGTabBar.h"

@interface MainController ()

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCustomTabBar];
    [self initViews];
    
    }


//View 被显示之时调用
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    for (UIView* childView in self.tabBar.subviews) {
        if([childView isKindOfClass:[UIControl class]]){
            [childView removeFromSuperview];
        }
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initViews{
    MGHomeController* homeController = [[MGHomeController alloc] init];
    MGDiscoverController* discoverController = [[MGDiscoverController alloc] init];
    MGMessageController* messageController = [[MGMessageController alloc] init];
    MGMeController* meController = [[MGMeController alloc] init];
    
    [self addTabController:homeController tabTitle:@"首页" tabImage:@"tabbar_home" tableSelectImage:@"tabbar_home_selected"];
    [self addTabController:discoverController tabTitle:@"广场" tabImage:@"tabbar_discover" tableSelectImage:@"tabbar_discover_selected"];
    [self addTabController:messageController tabTitle:@"消息" tabImage:@"tabbar_message_center" tableSelectImage:@"tabbar_message_center_selected"];
    [self addTabController:meController tabTitle:@"设置" tabImage:@"tabbar_profile" tableSelectImage:@"tabbar_profile_selected"];

}

-(void)initCustomTabBar{
    MGTabBar* customTabBar = [[MGTabBar alloc] initWithFrame:self.tabBar.bounds];
//    customTabBar.backgroundColor = [UIColor redColor];
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
    self.customTabBar.delegate = self;
}


-(void)addTabController:(UIViewController*)tabViewController tabTitle:(NSString*)title tabImage:(NSString*)imageName tableSelectImage:(NSString*)selectImageName{
    tabViewController.title = title;
    tabViewController.tabBarItem.badgeValue = @"XX";
    //controller.title = title 等效于controller.tabBarItem.title = title;controller.nagivationItem.title = title;
    UIImage* image = [UIImage imageNamed:imageName];
    [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabViewController.tabBarItem.image = image;
    UIImage* selectImage = [UIImage imageNamed:selectImageName];
    [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabViewController.tabBarItem.selectedImage = selectImage;
    MGNavigationController* navigationController = [[MGNavigationController alloc] initWithRootViewController:tabViewController];
    [self addChildViewController:navigationController];
    [self.customTabBar addTabItem:tabViewController.tabBarItem];

}

- (void)tabBar:(MGTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to{
    self.selectedIndex = to;
}

-(void)plusBar:(UIButton *)tabBar{
    NSLog(@"plusBar");
}

@end
