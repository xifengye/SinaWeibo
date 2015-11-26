//
//  MGPicturesView.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/25.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGPictureView.h"

@protocol MGPicturesViewDelegate <NSObject>

-(void)picturesViewDidAddItem;
-(void)picturesViewBeganEmpty;

@end

@interface MGPicturesView : UIView
{
    NSInteger addBtnIndex;
}
@property(nonatomic,strong)NSMutableArray* images;
@property(nonatomic,assign)id delegate;
-(void)addItem:(UIImage*)image;

@end
