//
//  MGStatusView.h
//  
//
//  Created by yexifeng on 15/11/19.
//
//

#import <UIKit/UIKit.h>
#import "StatusFrame.h"
#import "Status.h"
#import "MGStatusRetweetView.h"
#import "MGStatusImagesView.h"
#import "MGPhotosView.h"


@interface MGStatusView : UIImageView
@property(nonatomic,strong)StatusFrame* statusFrame;

@property(nonatomic,weak)UIImageView* profileView;
@property(nonatomic,weak)UIImageView* vipView;
@property(nonatomic,weak)MGPhotosView* photoView;

@property(nonatomic,weak)UILabel* nameLabel;
@property(nonatomic,weak)UILabel* contentLabel;
@property(nonatomic,weak)UILabel* sourceLabel;
@property(nonatomic,weak)UILabel* timeLabel;

@property(nonatomic,weak)MGStatusRetweetView* statusRetweetView;

@end
