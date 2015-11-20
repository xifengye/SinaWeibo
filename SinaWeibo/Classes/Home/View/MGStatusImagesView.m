//
//  MGStatusImagesView.m
//  
//
//  Created by yexifeng on 15/11/19.
//
//

#import "MGStatusImagesView.h"
#import "UIImageView+WebCache.h"
#import <Foundation/Foundation.h>

@implementation MGStatusImagesView

-(instancetype)init{
    if(self = [super init]){
        MGPhotoView* photoView = [[MGPhotoView alloc]init];
        [self addSubview:photoView];
        photoView.backgroundColor = [UIColor redColor];
        photoView.contentMode = UIViewContentModeScaleAspectFill;
        photoView.clipsToBounds = YES;
        self.photoView = photoView;
        
        for (int i=0; i<9; i++) {
            MGPhotoView* pView = [[MGPhotoView alloc]init];
            pView.contentMode = UIViewContentModeScaleAspectFill;
            pView.clipsToBounds = YES;
            [self addSubview:pView];
            [self.ninePhotoViews addObject:pView];
        }
    }
    return self;
}

-(NSMutableArray*)ninePhotoViews{
    if(_ninePhotoViews==nil){
        _ninePhotoViews = [NSMutableArray array];
    }
    return _ninePhotoViews;
}

-(void)setStatusFrame:(Status *)status singlePhotoViewF:(CGRect)rect ninePhotoViewsF:(NSArray*) rects{
    if(status.pic_urls.count>0){
        int picUrlsCount = status.pic_urls.count;
        if(picUrlsCount>1){//超过1张图
            self.photoView.hidden = YES;
            for(int i=0;i<self.ninePhotoViews.count;i++){
                MGPhotoView* iv = self.ninePhotoViews[i];
                if(i<picUrlsCount){
                    iv.hidden = NO;
                    NSValue* value = rects[i];
                    CGRect rect = [value CGRectValue];
                    iv.frame = rect;
                    iv.photo = status.pic_urls[i];
                }else{
                    iv.hidden = YES;
                }
            }
        }else{
            self.photoView.hidden = NO;
            for(UIImageView* iv in self.ninePhotoViews){
                iv.hidden = YES;
            }
            self.photoView.frame = rect;
            self.photoView.photo = status.pic_urls[0];
        }
    }else{
        self.photoView.hidden = YES;
        for(UIImageView* iv in self.ninePhotoViews){
            iv.hidden = YES;
        }
    }
}

@end
