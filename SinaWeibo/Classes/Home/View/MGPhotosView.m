//
//  MGPhotosView.m
//  
//
//  Created by yexifeng on 15/11/19.
//
//

#import "MGPhotosView.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"


#define MGPhotoWidth    100
#define MGPhotoHeight    100
#define MGPhotoMargin   10

@implementation MGPhotosView

-(instancetype)init{
    if(self = [super init]){
        for (int i=0; i<9; i++) {
            MGPhotoView* photoView = [[MGPhotoView alloc]init];
            photoView.userInteractionEnabled = true;
            photoView.tag = i;
            [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)]];
            [self addSubview:photoView];
        }
    }
    return self;
}

-(void)photoTap:(UITapGestureRecognizer*)recognizer{
    NSLog(@"photoTap %d",recognizer.view.tag);
    int count = _photos.count;
    // 1.封装图片数据
    NSMutableArray *photoArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        Photo* photo = _photos[i];
        NSString *url = [photo.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"];
        MJPhoto *photoView = [[MJPhoto alloc] init];
        photoView.url = [NSURL URLWithString:url]; // 图片路径
        photoView.srcImageView = self.subviews[i]; // 来源于哪个UIImageView
        [photoArray addObject:photoView];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = recognizer.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photoArray; // 设置所有的图片
    [browser show];

}

-(void)setPhotos:(NSArray *)photos{
    _photos = photos;
    for (int i = 0; i<self.subviews.count; i++) {
        // 取出i位置对应的imageView
        MGPhotoView *photoView = self.subviews[i];
        
        // 判断这个imageView是否需要显示数据
        if (i < photos.count) {
            // 显示图片
            photoView.hidden = NO;
            
            // 传递模型数据
            photoView.photo = photos[i];
            
            // 设置子控件的frame
            int maxColumns = (photos.count == 4) ? 2 : 3;
            int col = i % maxColumns;
            int row = i / maxColumns;
            CGFloat photoX = col * (MGPhotoWidth + MGPhotoMargin);
            CGFloat photoY = row * (MGPhotoHeight + MGPhotoMargin);
            photoView.frame = CGRectMake(photoX, photoY, MGPhotoWidth, MGPhotoHeight);
            
            // Aspect : 按照图片的原来宽高比进行缩
            // UIViewContentModeScaleAspectFit : 按照图片的原来宽高比进行缩放(一定要看到整张图片)
            // UIViewContentModeScaleAspectFill :  按照图片的原来宽高比进行缩放(只能图片最中间的内容)
            // UIViewContentModeScaleToFill : 直接拉伸图片至填充整个imageView
            
            if (photos.count == 1) {
                photoView.contentMode = UIViewContentModeScaleAspectFit;
                photoView.clipsToBounds = NO;
            } else {
                photoView.contentMode = UIViewContentModeScaleAspectFill;
                photoView.clipsToBounds = YES;
            }
        } else { // 隐藏imageView
            photoView.hidden = YES;
        }
    }
    
}

+(CGSize)photosViewSizeWithPhotosCount:(int)count{
    int maxColumns = (count == 4)?2:3;
    int rows = (count + maxColumns -1)/maxColumns;
    
    CGFloat photosH = rows* MGPhotoHeight + (rows-1)*MGPhotoMargin;
    
    int columns = count>=maxColumns?maxColumns:count;
    
    CGFloat photoW = columns* MGPhotoWidth + (columns-1)*MGPhotoMargin;
    return CGSizeMake(photoW, photosH);
}

@end
