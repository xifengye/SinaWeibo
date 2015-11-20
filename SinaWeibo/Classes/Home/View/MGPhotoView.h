//
//  MGPhotoView.h
//  
//
//  Created by yexifeng on 15/11/19.
//
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface MGPhotoView : UIImageView
@property(nonatomic,strong)UIImageView* gifMark;
@property(nonatomic,strong)Photo* photo;
@end
