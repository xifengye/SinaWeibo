//
//  StatusFrame.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/17.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "StatusFrame.h"





@interface StatusFrame()


@end

@implementation StatusFrame
- (void)setStatus:(Status *)status{
    _status = status;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width - TableCellBorder*2;
    CGFloat topViewW = screenWidth;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    CGFloat topViewH = 0;
    
    CGFloat profileWH = StatusProfileWH;
    CGFloat profileX = StatusCellMargin;
    CGFloat profileY = StatusCellMargin;
    _profileViewF = CGRectMake(profileX, profileY, profileWH, profileWH);
    
    CGSize nameSize = [status.user.name sizeWithFont:StatusNameFont];
    CGFloat nameX = CGRectGetMaxX(_profileViewF)+StatusCellMargin;
    CGFloat nameY = StatusCellMargin;
    _nameLabelF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    if(status.user.mbrank>0){
        CGFloat vipW = 35;
        CGFloat vipH = nameSize.height;
        CGFloat vipX = CGRectGetMaxX(_nameLabelF)+StatusCellMargin;
        CGFloat vipY = StatusCellMargin;
        _vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    CGFloat contentW = topViewW-StatusCellMargin*2;
    CGSize contentSize = [status.text sizeWithFont:StatusContentFont constrainedToSize:CGSizeMake(contentW, MAXFLOAT)];
    CGFloat contentX = StatusCellMargin;
    CGFloat contentY = MAX(CGRectGetMaxY(_profileViewF),CGRectGetMaxY(_timeLabelF))+StatusCellMargin;
    _contentLabelF = CGRectMake(contentX, contentY, contentW, contentSize.height);
    
    if(status.thumbnail_pic){
        CGFloat photoW = 80;
        CGFloat photoH = 80;
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(_contentLabelF)+StatusCellMargin;
        _photoViewF = CGRectMake(photoX, photoY, photoW, photoH);
    }
    
    //被转发
    if(status.retweeted_status){
        CGFloat retweetTopX = contentX;
        CGFloat retweetTopY = CGRectGetMaxY(_contentLabelF)+StatusCellMargin;
        CGFloat retweetTopW = topViewW-StatusCellMargin*2;
        CGFloat retweetTopH = 0;
        
        NSString* retweetName = [NSString stringWithFormat:@"@%@",status.retweeted_status.user.name];
        CGSize retweetNameSize = [retweetName sizeWithFont:StatusNameFont];
        CGFloat retweetNameX = StatusCellMargin*2;
        CGFloat retweetNameY = StatusCellMargin*2;
        _retweetNameLabelF = CGRectMake(retweetNameX, retweetNameY, retweetNameSize.width, retweetNameSize.height);
        
        CGFloat retweetContentW = retweetTopW-StatusCellMargin*2;
        CGSize retweetContentSize = [status.retweeted_status.text sizeWithFont:StatusContentFont constrainedToSize:CGSizeMake(retweetContentW, MAXFLOAT)];
        CGFloat retweetContentX = StatusCellMargin;
        CGFloat retweetContentY = CGRectGetMaxY(_retweetNameLabelF)+StatusCellMargin;
        _retweetContentLabelF = CGRectMake(retweetContentX, retweetContentY, retweetContentW, retweetContentSize.height);
        
        
        if(status.retweeted_status.thumbnail_pic){
            CGFloat retweetPhotoW = 80;
            CGFloat retweetPhotoH = 80;
            CGFloat retweetPhotoX = retweetContentX;
            CGFloat retweetPhotoY = CGRectGetMaxY(_retweetContentLabelF)+StatusCellMargin;
            _retweetPhotoViewF = CGRectMake(retweetPhotoX, retweetPhotoY, retweetPhotoW, retweetPhotoH);
            
            retweetTopH = CGRectGetMaxY(_retweetPhotoViewF)+StatusCellMargin;
        }else{
           retweetTopH = CGRectGetMaxY(_retweetContentLabelF)+StatusCellMargin;
        }

        _retweetTopViewF = CGRectMake(retweetTopX, retweetTopY, retweetTopW, retweetTopH);
        topViewH = CGRectGetMaxY(_retweetTopViewF)+StatusCellMargin;
    }else{
        if(status.thumbnail_pic){
            topViewH = CGRectGetMaxY(_photoViewF)+StatusCellMargin;
        }else{
            topViewH = CGRectGetMaxY(_contentLabelF)+StatusCellMargin;
        }

        
    }
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    //topView end
    
    
    CGFloat toolBarW = topViewW;
    CGFloat toolBarH = 50;
    CGFloat toolBarX = topViewX;
    CGFloat toolBarY = CGRectGetMaxY(_topViewF);
    _statusToolBarF = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    _cellHeight = CGRectGetMaxY(_statusToolBarF)+TableCellBorder;
}
@end
