//
//  MGWeiboCell.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/17.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "MGWeiboCell.h"
#import "Status.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "UIImage+MG.h"
#import "MGStatusToolBar.h"




@interface MGWeiboCell()

@property(nonatomic,weak)UIImageView* topView;
@property(nonatomic,weak)UIImageView* profileView;
@property(nonatomic,weak)UIImageView* vipView;
@property(nonatomic,weak)UIImageView* photoView;

@property(nonatomic,weak)UILabel* nameLabel;
@property(nonatomic,weak)UILabel* contentLabel;
@property(nonatomic,weak)UILabel* sourceLabel;
@property(nonatomic,weak)UILabel* timeLabel;

@property(nonatomic,weak)UIImageView* retweetTopView;
@property(nonatomic,weak)UILabel* retweetNameLabel;
@property(nonatomic,weak)UILabel* retweetContentLabel;
@property(nonatomic,weak)UIImageView* retweetPhotoView;

@property(nonatomic,weak)MGStatusToolBar* statusToolBar;
@property(nonatomic,weak)UIButton* repostsBtn;
@property(nonatomic,weak)UIButton* commentsBtn;
@property(nonatomic,weak)UIButton* attitudesBtn;
@end

@implementation MGWeiboCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString* ID = @"HomeCell";
    MGWeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell==nil){
        cell = [[MGWeiboCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        UIView* backgroundView = [[UIView alloc]init];
        backgroundView.backgroundColor = CellBackgroundColor;
        self.selectedBackgroundView = backgroundView;
        self.backgroundColor = CellBackgroundColor;
        //添加原创微博内部的子控件
        [self setupOriginalSubviews];
        //添加被转发微博的子控件
        [self setupRetweetSubviews];
        //添加工具条
        [self setupStatusToolBar];
    }
    return self;
}

-(void)setupOriginalSubviews{
    UIImageView* topView = [[UIImageView alloc]init];
    topView.image = [UIImage imageWithStretchable:@"timeline_card_top_background"];
    topView.highlightedImage = [UIImage imageWithStretchable:@"timeline_card_top_background_highlighted"];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
    UIImageView* profileView = [[UIImageView alloc]init];
    [self.topView addSubview:profileView];
    self.profileView = profileView;

    
    UIImageView* vipView = [[UIImageView alloc]init];
    vipView.contentMode = UIViewContentModeCenter;
    [self.topView addSubview:vipView];
    self.vipView = vipView;

    
    UIImageView* photoView = [[UIImageView alloc]init];
    [self.topView addSubview:photoView];
    self.photoView = photoView;
    
    UILabel* nameLabel = [[UILabel alloc]init];
    nameLabel.font = StatusNameFont;
    nameLabel.textColor = [UIColor blackColor];
    [self.topView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel* contentLabel = [[UILabel alloc]init];
    contentLabel.font = StatusContentFont;
    contentLabel.numberOfLines = 0;
    [self.topView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UILabel* sourceLabel = [[UILabel alloc]init];
    sourceLabel.font = StatusSourceFont;
    [self.topView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    UILabel* timeLabel = [[UILabel alloc]init];
    timeLabel.font = StatusTimeFont;
    [self.topView addSubview:timeLabel];
    self.timeLabel = timeLabel;
   
   

}

-(void)setupRetweetSubviews{
    
    UIImageView* retweetTopView = [[UIImageView alloc]init];
    [self.topView addSubview:retweetTopView];
    self.retweetTopView = retweetTopView;
    
    UIImageView* retweetPhotoView = [[UIImageView alloc]init];
    [self.retweetTopView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
    
    UILabel* retweetNameLabel = [[UILabel alloc]init];
    [self.retweetTopView addSubview:retweetNameLabel];
//    self.retweetNameLabel.font= StatusNameFont;
    [self.retweetNameLabel setTextColor:[UIColor blueColor]];
    self.retweetNameLabel = retweetNameLabel;
    
    UILabel* retweetContentLabel = [[UILabel alloc]init];
    [self.retweetTopView addSubview:retweetContentLabel];
    self.retweetContentLabel.numberOfLines = 0;
//    self.retweetContentLabel.font = StatusContentFont;
    self.retweetContentLabel = retweetContentLabel;


}
-(void)setupStatusToolBar{
    MGStatusToolBar* statusToolBar = [[MGStatusToolBar alloc]init];
    
    [self.contentView addSubview:statusToolBar];
    self.statusToolBar = statusToolBar;
    
    UIButton* repostsBtn = [[UIButton alloc]init];
    [repostsBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    repostsBtn.contentMode = UIViewContentModeCenter;
    repostsBtn.font = StatusToolBarFont;
    [repostsBtn setBackgroundImage:[UIImage imageWithStretchable:@"timeline_card_leftbottom_highlighted"] forState:UIControlStateHighlighted];
    [repostsBtn setImage:[UIImage imageNamed:@"timeline_icon_retweet"] forState:UIControlStateNormal];
    [repostsBtn.imageView setImage:[UIImage imageNamed:@"timeline_icon_retweet"]];
    [self.statusToolBar addToolItem:repostsBtn];
    self.repostsBtn = repostsBtn;
    
    UIButton* commentsBtn = [[UIButton alloc]init];
    [commentsBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    commentsBtn.font = StatusToolBarFont;
    [commentsBtn setBackgroundImage:[UIImage imageWithStretchable:@"timeline_card_middlebottom_highlighted"] forState:UIControlStateHighlighted];
    [commentsBtn setImage:[UIImage imageNamed:@"timeline_icon_comment"]  forState:UIControlStateNormal];
    [commentsBtn setTitle:@"评论" forState:UIControlStateNormal];
    [self.statusToolBar addToolItem:commentsBtn];
    self.commentsBtn = commentsBtn;
    
    UIButton* attitudesBtn = [[UIButton alloc]init];
    [attitudesBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    attitudesBtn.font = StatusToolBarFont;
    [attitudesBtn setBackgroundImage:[UIImage imageWithStretchable:@"timeline_card_rightbottom_highlighted"] forState:UIControlStateHighlighted];
    [attitudesBtn setImage:[UIImage imageNamed:@"timeline_icon_unlike"] forState:UIControlStateNormal];
    [attitudesBtn setTitle:@"赞" forState:UIControlStateNormal];
    [self.statusToolBar addToolItem:attitudesBtn];
    self.attitudesBtn = attitudesBtn;

}

-(void)setStatusFrame:(StatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    
    //添加原创微博内部的子控件
    [self setupOriginalData];
    //添加被转发微博的子控件
    [self setupRetweetData];
    
    [self setupStatusToolBarData];

}

-(void)setupOriginalData{
    Status* status = self.statusFrame.status;
    User* user = status.user;
    
    self.topView.frame = self.statusFrame.topViewF;
    
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
    
    if(status.thumbnail_pic){
        self.photoView.hidden = NO;
        self.photoView.frame = self.statusFrame.photoViewF;
        [self.photoView setImageWithURL:status.thumbnail_pic placeholderImage:[UIImage imageNamed:@"movie"]];
    }else{
        self.photoView.hidden = YES;
    }
     
     
}

-(void)setupRetweetData{
    Status* status = self.statusFrame.status.retweeted_status;
    if(status){//存在被转发微博
        self.retweetTopView.hidden = NO;
        self.retweetTopView.frame = self.statusFrame.retweetTopViewF;
        [self.retweetTopView setImage:[UIImage imageWithStretchable:@"timeline_retweet_background" leftCapWidth:0.9 topCapHeight:0.5]];
        
        NSString* retweetName = [NSString stringWithFormat:@"@%@",status.user.name];
        self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
        [self.retweetNameLabel setTextColor:[UIColor blueColor]];
        self.retweetNameLabel.font = StatusNameFont;
        [self.retweetNameLabel setText:retweetName];
        
        self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
        self.retweetContentLabel.font = StatusContentFont;
        [self.retweetContentLabel setText:status.text];
        self.retweetContentLabel.numberOfLines = 0;
        
        if(status.thumbnail_pic){
            self.retweetPhotoView.hidden = NO;
//            self.retweetPhotoView.backgroundColor = [UIColor redColor];
            self.retweetPhotoView.frame = self.statusFrame.retweetPhotoViewF;
            [self.retweetPhotoView setImageWithURL:status.thumbnail_pic placeholderImage:[UIImage imageNamed:@"AppIcon"]];
        }else{
            self.retweetPhotoView.hidden = YES;
        }
        
    }else{
        self.retweetTopView.hidden = YES;
    }
}

-(void)setupStatusToolBarData{
    self.statusToolBar.frame = self.statusFrame.statusToolBarF;
    Status* status = self.statusFrame.status;
    
//    self.repostsBtn.frame = self.statusFrame.repostsBtnF;
    if(status.reposts_count>0){
        [self.repostsBtn setTitle:[NSString stringWithFormat:@"%d",status.reposts_count] forState:UIControlStateNormal];
    }else{
        [self.repostsBtn setTitle:@"转发" forState:UIControlStateNormal];
    }
    
//    self.commentsBtn.frame = self.statusFrame.commentsBtnF;
    if(status.comments_count>0){
        [self.commentsBtn setTitle:[NSString stringWithFormat:@"%d",status.comments_count] forState:UIControlStateNormal];
    }else{
        [self.commentsBtn setTitle:@"评论" forState:UIControlStateNormal];
    }

//    self.attitudesBtn.frame = self.statusFrame.attitudesBtnF;
    if(status.attitudes_count>0){
        [self.attitudesBtn setTitle:[NSString stringWithFormat:@"%d",status.attitudes_count] forState:UIControlStateNormal];
    }else{
        [self.attitudesBtn setTitle:@"赞" forState:UIControlStateNormal];
    }

}

-(void)setFrame:(CGRect)frame{
    frame.origin.x = TableCellBorder;
    frame.size.width -= TableCellBorder*2;
    frame.size.height -= TableCellBorder;
    [super setFrame:frame];
}
@end
