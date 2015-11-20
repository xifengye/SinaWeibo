//
//  StatusFrame.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/17.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "StatusFrame.h"
#import "MGPhotosView.h"


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
    
    CGFloat statusPhotoX = contentX;
    CGFloat statusPhotoY = CGRectGetMaxY(_contentLabelF)+StatusCellMargin;
    //原创发图
    int picUlrCount = status.pic_urls.count;
    if(picUlrCount>9){
        picUlrCount = 9;
    }
    if(picUlrCount>0){
        CGSize statsPhotoSize = [MGPhotosView photosViewSizeWithPhotosCount:picUlrCount];
        _statusPhotoF = CGRectMake(statusPhotoX, statusPhotoY, statsPhotoSize.width, statsPhotoSize.height);
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
        
        
        
        CGFloat retweetStatusPhotoW = retweetContentW;
        CGFloat retweetStatusPhotoH = 0;
        CGFloat retweetStatusPhotoX = retweetContentX;
        CGFloat retweetStatusPhotoY = CGRectGetMaxY(_retweetContentLabelF)+StatusCellMargin;

        //转发发图
        int retweetPicUlrCount = status.retweeted_status.pic_urls.count;
        if(retweetPicUlrCount>9){
            retweetPicUlrCount = 9;
        }
        if(retweetPicUlrCount>0){
            CGSize retweetStatsPhotoSize = [MGPhotosView photosViewSizeWithPhotosCount:retweetPicUlrCount];
            _retweetStatusPhotoF = CGRectMake(retweetStatusPhotoX, retweetStatusPhotoY, retweetStatsPhotoSize.width, retweetStatsPhotoSize.height);
            retweetTopH = CGRectGetMaxY(_retweetStatusPhotoF)+StatusCellMargin;
        }else{
            retweetTopH = CGRectGetMaxY(_retweetContentLabelF)+StatusCellMargin;
        }
  
        _retweetTopViewF = CGRectMake(retweetTopX, retweetTopY, retweetTopW, retweetTopH);
        topViewH = CGRectGetMaxY(_retweetTopViewF)+StatusCellMargin;
    }else{
        if(status.pic_urls.count>0){
            topViewH = CGRectGetMaxY(_statusPhotoF)+StatusCellMargin;
        }else{
            topViewH = CGRectGetMaxY(_contentLabelF)+StatusCellMargin;
        }

        
    }
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    //topView end
    
    
    CGFloat toolBarW = topViewW;
    CGFloat toolBarH = 40;
    CGFloat toolBarX = topViewX;
    CGFloat toolBarY = CGRectGetMaxY(_topViewF);
    _statusToolBarF = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    _cellHeight = CGRectGetMaxY(_statusToolBarF)+TableCellBorder;
}
@end
