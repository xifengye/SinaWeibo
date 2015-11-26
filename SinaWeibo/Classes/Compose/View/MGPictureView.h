//
//  MGPictureView.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/25.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGPictureView : UIImageView
@property(nonatomic,weak)UIImageView* deleteBtn;
-(BOOL)isClickedDeleteButton:(CGPoint)point;
@end
