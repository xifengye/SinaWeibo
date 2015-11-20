//
//  MGStatusImagesView.h
//  
//
//  Created by yexifeng on 15/11/19.
//
//

#import <UIKit/UIKit.h>
#import "StatusFrame.h"
#import "Photo.h"
#import "MGPhotoView.h"

@interface MGStatusImagesView : UIView
-(void)setStatusFrame:(Status *)status singlePhotoViewF:(CGRect)rect ninePhotoViewsF:(NSArray*) rects;
//@property(nonatomic,strong)StatusFrame* statusFrame;
@property(nonatomic,weak)MGPhotoView* photoView;
@property(nonatomic,strong)NSMutableArray* ninePhotoViews;

@end
