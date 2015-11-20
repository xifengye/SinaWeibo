//
//  MGStatusRetweetView.m
//  
//
//  Created by yexifeng on 15/11/19.
//
//

#import "MGStatusRetweetView.h"
#import "UIImageView+WebCache.h"
#import "UIImage+MG.h"

@implementation MGStatusRetweetView
-(instancetype)init{
    if(self = [super init]){
        self.userInteractionEnabled = true;
        [self setImage:[UIImage imageWithStretchable:@"timeline_retweet_background" leftCapWidth:0.9 topCapHeight:0.5]];
        
        MGPhotosView* retweetPhotoView = [[MGPhotosView alloc]init];
        [self addSubview:retweetPhotoView];
        self.retweetPhotoView = retweetPhotoView;
        
        UILabel* retweetNameLabel = [[UILabel alloc]init];
        [self addSubview:retweetNameLabel];
        //    self.retweetNameLabel.font= StatusNameFont;
        [self.retweetNameLabel setTextColor:[UIColor blueColor]];
        self.retweetNameLabel = retweetNameLabel;
        
        UILabel* retweetContentLabel = [[UILabel alloc]init];
        [self addSubview:retweetContentLabel];
        self.retweetContentLabel.numberOfLines = 0;
        //    self.retweetContentLabel.font = StatusContentFont;
        self.retweetContentLabel = retweetContentLabel;

    }
    return self;
}


-(void)setStatusFrame:(StatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    Status* status = _statusFrame.status.retweeted_status;
    NSString* retweetName = [NSString stringWithFormat:@"@%@",status.user.name];
    self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
    [self.retweetNameLabel setTextColor:[UIColor blueColor]];
    self.retweetNameLabel.font = StatusNameFont;
    [self.retweetNameLabel setText:retweetName];
    
    self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
    self.retweetContentLabel.font = StatusContentFont;
    [self.retweetContentLabel setText:status.text];
    self.retweetContentLabel.numberOfLines = 0;
    
    if(status.pic_urls){
        self.retweetPhotoView.hidden = NO;
        self.retweetPhotoView.frame = self.statusFrame.retweetStatusPhotoF;
        self.retweetPhotoView.photos = status.pic_urls;
//        [self.retweetPhotoView setStatusFrame:status singlePhotoViewF:self.statusFrame.retweetSinglePhotoViewF ninePhotoViewsF:self.statusFrame.retweetNinePhotoViewsF];
    }else{
        self.retweetPhotoView.hidden = YES;
    }

}
@end
