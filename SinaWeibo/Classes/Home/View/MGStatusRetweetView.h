//
//  MGStatusRetweetView.h
//  
//
//  Created by yexifeng on 15/11/19.
//
//

#import <UIKit/UIKit.h>
#import "Status.h"
#import "StatusFrame.h"
#import "User.h"
#import "MGPhotosView.h"

@interface MGStatusRetweetView : UIImageView
@property (nonatomic,strong)StatusFrame* statusFrame;
@property(nonatomic,weak)UILabel* retweetNameLabel;
@property(nonatomic,weak)UILabel* retweetContentLabel;
@property(nonatomic,weak)MGPhotosView* retweetPhotoView;
@end
