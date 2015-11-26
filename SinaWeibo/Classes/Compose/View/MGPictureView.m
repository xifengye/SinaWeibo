//
//  MGPictureView.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/25.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import "MGPictureView.h"

@implementation MGPictureView
#define DeleteBtnWH 30
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = true;
        UIImageView* btn = [[UIImageView alloc]init];
        btn.userInteractionEnabled = true;
        btn.image = [UIImage imageNamed:@"common_icon_membership"];
        btn.frame = CGRectMake(0, 0, DeleteBtnWH, DeleteBtnWH);
//        btn.backgroundColor = [UIColor redColor];
        btn.contentMode = UIViewContentModeTopRight;
        [self addSubview:btn];
        self.deleteBtn = btn;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.deleteBtn.layer.anchorPoint = CGPointMake(1, 0);
    self.deleteBtn.layer.position = CGPointMake(self.frame.size.width,0);
}

-(BOOL)isClickedDeleteButton:(CGPoint)point{
    CGSize selfSize = self.frame.size;
    return (point.x>selfSize.width-DeleteBtnWH && point.x<selfSize.width) &&  (point.y>0 && point.y<DeleteBtnWH);
}

@end
