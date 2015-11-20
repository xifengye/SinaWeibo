//
//  StatusFrame.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/17.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Status.h"

#define TableCellBorder 3
#define StatusCellMargin  6
#define StatusProfileWH 40
#define StatusPhotoW  120
#define StatusPhotoH  150
#define StatusNinePhotoMaxWH  90
#define StatusNinePhotoMargin  6

#define StatusNameFont [UIFont systemFontOfSize:16]
#define StatusContentFont [UIFont systemFontOfSize:14]
#define StatusTimeFont [UIFont systemFontOfSize:11]
#define StatusSourceFont StatusTimeFont
#define StatusToolBarFont [UIFont systemFontOfSize:15]

@interface StatusFrame : NSObject
@property(nonatomic,strong)Status* status;
@property(nonatomic,assign)CGFloat cellHeight;

@property(nonatomic,assign,readonly)CGRect  topViewF;
@property(nonatomic,assign,readonly)CGRect   profileViewF;
@property(nonatomic,assign,readonly)CGRect   vipViewF;
@property(nonatomic,assign,readonly)CGRect   statusPhotoF;

@property(nonatomic,assign,readonly)CGRect   nameLabelF;
@property(nonatomic,assign,readonly)CGRect   contentLabelF;
@property(nonatomic,assign,readonly)CGRect   sourceLabelF;
@property(nonatomic,assign,readonly)CGRect   timeLabelF;

@property(nonatomic,assign,readonly)CGRect   retweetTopViewF;
@property(nonatomic,assign,readonly)CGRect   retweetNameLabelF;
@property(nonatomic,assign,readonly)CGRect   retweetContentLabelF;
@property(nonatomic,assign,readonly)CGRect   retweetStatusPhotoF;

@property(nonatomic,assign,readonly)CGRect   statusToolBarF;
@property(nonatomic,assign,readonly)CGRect repostsBtnF;
@property(nonatomic,assign,readonly)CGRect commentsBtnF;
@property(nonatomic,assign,readonly)CGRect attitudesBtnF;

@end
