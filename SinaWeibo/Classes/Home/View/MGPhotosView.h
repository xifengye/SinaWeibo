//
//  MGPhotosView.h
//  
//
//  Created by yexifeng on 15/11/19.
//
//

#import <UIKit/UIKit.h>
#import "MGPhotoView.h"

@interface MGPhotosView : UIView
@property(nonatomic,strong)NSArray* photos;

+(CGSize)photosViewSizeWithPhotosCount:(int)count;
@end
