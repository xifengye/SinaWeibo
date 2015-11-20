//
//  MGStatusToolBar.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/18.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "MGStatusToolBar.h"
#import "UIImage+MG.h"
#import "StatusFrame.h"
#import "Status.h"

#define TAG_SEPARATOR   1001

@interface MGStatusToolBar()

@property(nonatomic,strong)NSMutableArray* separator;
@property(nonatomic,strong)NSMutableArray* items;
@end

@implementation MGStatusToolBar

-(NSMutableArray*)separator{
    if(_separator==nil){
        _separator=[NSMutableArray array];
    }
    return _separator;
}

-(NSMutableArray*)items{
    if(_items==nil){
        _items=[NSMutableArray array];
    }
    return _items;
}
-(instancetype)init{
    if(self = [super init]){
        self.userInteractionEnabled = true;
        self.image = [UIImage imageWithStretchable:@"timeline_card_bottom_background"];
        self.highlightedImage = [UIImage imageWithStretchable:@"timeline_card_bottom_background_highlighted"];
        
        
        UIButton* repostsBtn = [[UIButton alloc]init];
        [repostsBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        repostsBtn.contentMode = UIViewContentModeCenter;
        repostsBtn.font = StatusToolBarFont;
        [repostsBtn setBackgroundImage:[UIImage imageWithStretchable:@"timeline_card_leftbottom_highlighted"] forState:UIControlStateHighlighted];
        [repostsBtn setImage:[UIImage imageNamed:@"timeline_icon_retweet"] forState:UIControlStateNormal];
        [repostsBtn.imageView setImage:[UIImage imageNamed:@"timeline_icon_retweet"]];
        [self addToolItem:repostsBtn];
        self.repostsBtn = repostsBtn;
        
        UIButton* commentsBtn = [[UIButton alloc]init];
        [commentsBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        commentsBtn.font = StatusToolBarFont;
        [commentsBtn setBackgroundImage:[UIImage imageWithStretchable:@"timeline_card_middlebottom_highlighted"] forState:UIControlStateHighlighted];
        [commentsBtn setImage:[UIImage imageNamed:@"timeline_icon_comment"]  forState:UIControlStateNormal];
        [commentsBtn setTitle:@"评论" forState:UIControlStateNormal];
        [self addToolItem:commentsBtn];
        self.commentsBtn = commentsBtn;
        
        UIButton* attitudesBtn = [[UIButton alloc]init];
        [attitudesBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        attitudesBtn.font = StatusToolBarFont;
        [attitudesBtn setBackgroundImage:[UIImage imageWithStretchable:@"timeline_card_rightbottom_highlighted"] forState:UIControlStateHighlighted];
        [attitudesBtn setImage:[UIImage imageNamed:@"timeline_icon_unlike"] forState:UIControlStateNormal];
        [attitudesBtn setTitle:@"赞" forState:UIControlStateNormal];
        [self addToolItem:attitudesBtn];
        self.attitudesBtn = attitudesBtn;
    }
    return self;
}

-(void)layoutSubviews{
    CGFloat separatorsWidth = 0;
    CGFloat separatorWidth = 0;
    if(self.separator.count>0){
        UIImageView* separatorView = self.separator[0];
        separatorWidth = separatorView.image.size.width;
        separatorsWidth = separatorWidth*self.separator.count;
    }
    CGFloat itemWidth = (self.frame.size.width - separatorsWidth)/self.items.count;
    CGFloat itemHeight = self.frame.size.height;
    CGFloat itemY = 0;
    CGFloat itemX = 0;
    for (int i=0; i<self.items.count; i++) {
        UIView* child = self.items[i];
        child.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
        if(i<self.separator.count){
            UIView* separatorView = self.separator[i];
            CGFloat separatorY = itemY;
            CGFloat separatorX = CGRectGetMaxX(child.frame);
            CGFloat separatorHeight = itemHeight;
            separatorView.frame = CGRectMake(separatorX, separatorY, separatorsWidth, separatorHeight);
            itemX = CGRectGetMaxX(separatorView.frame);
        }
    }
}



-(void)addToolItem:(UIView*)view{
    if(self.items.count>0){
        UIImageView* separatorView = [[UIImageView alloc]init];
        separatorView.tag = TAG_SEPARATOR;
        separatorView.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
        separatorView.highlightedImage = [UIImage imageNamed:@"timeline_card_bottom_line_highlighted"];
        [self addSubview:separatorView];
        [self.separator addObject:separatorView];
    }
    [self addSubview:view];
    [self.items addObject:view];
}

-(void)setStatusFrame:(StatusFrame *)statusFrame{
    Status* status = statusFrame.status;
    if(status.reposts_count>0){
        [self.repostsBtn setTitle:[NSString stringWithFormat:@"%d",status.reposts_count] forState:UIControlStateNormal];
    }else{
        [self.repostsBtn setTitle:@"转发" forState:UIControlStateNormal];
    }
    
    if(status.comments_count>0){
        [self.commentsBtn setTitle:[NSString stringWithFormat:@"%d",status.comments_count] forState:UIControlStateNormal];
    }else{
        [self.commentsBtn setTitle:@"评论" forState:UIControlStateNormal];
    }
    
    if(status.attitudes_count>0){
        [self.attitudesBtn setTitle:[NSString stringWithFormat:@"%d",status.attitudes_count] forState:UIControlStateNormal];
    }else{
        [self.attitudesBtn setTitle:@"赞" forState:UIControlStateNormal];
    }

}
@end
