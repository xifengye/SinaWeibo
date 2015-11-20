//
//  MGStatusView.m
//  
//
//  Created by yexifeng on 15/11/19.
//
//

#import "MGStatusView.h"
#import "UIImage+MG.h"
#import "UIImageView+WebCache.h"


@implementation MGStatusView

-(instancetype)init{
    if(self = [super init]){
        self.userInteractionEnabled = true;
        self.image = [UIImage imageWithStretchable:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage imageWithStretchable:@"timeline_card_top_background_highlighted"];
        
        UIImageView* profileView = [[UIImageView alloc]init];
        [self addSubview:profileView];
        self.profileView = profileView;
        
        
        UIImageView* vipView = [[UIImageView alloc]init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        
        MGPhotosView* photoView = [[MGPhotosView alloc]init];
        [self  addSubview:photoView];
        self.photoView = photoView;
        
        UILabel* nameLabel = [[UILabel alloc]init];
        nameLabel.font = StatusNameFont;
        nameLabel.textColor = [UIColor blackColor];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel* contentLabel = [[UILabel alloc]init];
        contentLabel.font = StatusContentFont;
        contentLabel.numberOfLines = 0;
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        UILabel* sourceLabel = [[UILabel alloc]init];
        sourceLabel.font = StatusSourceFont;
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        UILabel* timeLabel = [[UILabel alloc]init];
        timeLabel.font = StatusTimeFont;
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;

        
        MGStatusRetweetView* retweetView = [[MGStatusRetweetView alloc]init];
        [self addSubview:retweetView];
        self.statusRetweetView = retweetView;
    }
    return self;
}

-(void)setStatusFrame:(StatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    Status* status = statusFrame.status;
    User* user = status.user;
    
    [self.profileView setImageWithURL:user.profile_image_url placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.profileView.frame = self.statusFrame.profileViewF;
    
    [self.nameLabel setText:user.name];
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    
    if(status.user.mbrank>0){
        self.vipView.hidden = NO;
        [self.vipView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank]]];
        self.vipView.frame = self.statusFrame.vipViewF;
    }else{
        self.vipView.hidden = YES;
    }
    

    [self.timeLabel setText:status.created_at];
    CGSize timeSize = [status.created_at sizeWithFont:StatusTimeFont];
    CGFloat timeX = self.statusFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(self.statusFrame.profileViewF)-timeSize.height;
    
    self.timeLabel.frame = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    
    [self.sourceLabel setText:status.source];
    CGSize sourceSize = [status.source sizeWithFont:StatusSourceFont];
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame)+StatusCellMargin;
    CGFloat sourceY = timeY;
    self.sourceLabel.frame = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);;
    
    [self.contentLabel setText:status.text];
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    
    if(status.pic_urls){
        self.photoView.hidden = NO;
        self.photoView.frame = self.statusFrame.statusPhotoF;
//        [self.photoView setStatusFrame:self.statusFrame.status singlePhotoViewF:self.statusFrame.singlePhotoViewF ninePhotoViewsF:self.statusFrame.ninePhotoViewsF];
        self.photoView.photos = status.pic_urls;
    }else{
        self.photoView.hidden = YES;
    }
    
    Status* retweetStatus = status.retweeted_status;
    if(retweetStatus){//存在被转发微博
        self.statusRetweetView.hidden = NO;
        self.statusRetweetView.frame = self.statusFrame.retweetTopViewF;
        self.statusRetweetView.statusFrame = statusFrame;
        
    }else{
        self.statusRetweetView.hidden = YES;
    }


}

@end
