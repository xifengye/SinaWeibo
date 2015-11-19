//
//  UIImage+MG.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/10.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "UIImage+MG.h"

@implementation UIImage (MG)
+(UIImage*) imageWithStretchable:(NSString*)imageName{
    UIImage* image = [UIImage imageNamed:imageName];
    return [self imageWithStretchable:imageName leftCapWidth:0.5 topCapHeight:0.5];
}
+(UIImage*) imageWithStretchable:(NSString*)imageName leftCapWidth:(CGFloat)left topCapHeight:(CGFloat)top{
    UIImage* image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width*left topCapHeight:image.size.height*top];
}
@end
