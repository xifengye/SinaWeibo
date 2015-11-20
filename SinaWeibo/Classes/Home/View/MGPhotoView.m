//
//  MGPhotoView.m
//  
//
//  Created by yexifeng on 15/11/19.
//
//

#import "MGPhotoView.h"
#import "UIImageView+WebCache.h"

@implementation MGPhotoView

-(instancetype)init{
    if(self = [super init]){
        UIImageView* gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        self.gifMark = gifView;
        [self addSubview:gifView];
    }
    return self;
}

-(void)setPhoto:(Photo *)photo{
    _photo = photo;
    _gifMark.hidden = ![photo.thumbnail_pic hasSuffix:@"gif"];
    [self setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"movie"]];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.gifMark.layer.anchorPoint = CGPointMake(1, 1);
    self.gifMark.layer.position = CGPointMake(self.frame.size.width, self.frame.size.height);
}

@end
