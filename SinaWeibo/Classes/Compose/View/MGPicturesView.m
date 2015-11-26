//
//  MGPicturesView.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/25.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import "MGPicturesView.h"
#import "MGPictureView.h"

#define ITEM_MARGIN_HORIZONTAL 10
#define ITEM_MARGIN_VERTICAL    5


@implementation MGPicturesView

-(NSMutableArray *)images{
    if(_images==nil){
        _images  = [NSMutableArray array];
    }
    return _images;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        addBtnIndex = NSNotFound;
        for(int i=0;i<9;i++){
            MGPictureView* picView = [[MGPictureView alloc]init];
            picView.hidden = YES;
            [self addSubview:picView];
            picView.tag = i;
            [picView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pictureTap:)]];
        }
    }
    return self;
}


-(void)pictureTap:(UITapGestureRecognizer*)recognizer{
    NSInteger tapIndex = recognizer.view.tag;
    NSLog(@"tapIndex=%ld",tapIndex);
    if(tapIndex==self.images.count){//点击加号
        if([self.delegate respondsToSelector:@selector(picturesViewDidAddItem)]){
            [self.delegate picturesViewDidAddItem];
        }
    }else{//点击其它已添加的图片
        //获取点击图片的位置
        CGPoint point = [recognizer locationInView:recognizer.view];
        MGPictureView* picView = recognizer.view;
        if([picView isClickedDeleteButton:point]){//点击删除按钮,执行删除
            [self deleteViewAtLocation:tapIndex];
        }else{//执行查看大图
            NSLog(@"查看大图");
        }
    }
}

-(void)deleteViewAtLocation:(NSInteger)location{
    NSLog(@"删除张图图片");
    [self resetAtLocation:location];
    
    MGPictureView* locationView = self.subviews[location];
    [self.images removeObjectAtIndex:location];
    CGPoint point = locationView.layer.position;//被点击删除Item的位置
    NSInteger tag = locationView.tag;
    for(int i=location+1;i<self.subviews.count;i++){
        MGPictureView* picView = self.subviews[i];
        CGPoint nextPoint = picView.layer.position;
        NSInteger nextTag = picView.tag;
        picView.tag = tag;
        [UIView animateWithDuration:0.5 animations:^{
            picView.layer.position = point;
        }];
        point = nextPoint;
        tag = nextTag;
    }
    [locationView removeFromSuperview];
    locationView.layer.position = point;
    locationView.tag = tag;
    [self addSubview:locationView];
    addBtnIndex-=1;
    if(self.images.count<=0){//只有一张图片无需动画
        [self resetAtLocation:addBtnIndex];
        if([self.delegate respondsToSelector:@selector(picturesViewBeganEmpty)]){
            [self.delegate picturesViewBeganEmpty];
        }

    }else{
        [self addItem:nil];
    }
}

-(void)resetAtLocation:(NSInteger)location{
    MGPictureView* picView = self.subviews[location];
    picView.image = nil;
    picView.hidden = YES;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = [UIImage imageNamed:@"compose_pic_add"].size;
    CGFloat width = MIN((self.frame.size.width-ITEM_MARGIN_HORIZONTAL*2)/3,size.width);
    CGFloat border = (self.frame.size.width-width*3-ITEM_MARGIN_HORIZONTAL*2)/2;
    CGFloat height = width;
    CGFloat x = border;
    CGFloat y = 0;
    for (int i=0; i<self.subviews.count; i++) {
        MGPictureView* picView = self.subviews[i];
        picView.frame = CGRectMake(x, y, width, height);
        x += (ITEM_MARGIN_HORIZONTAL+width);
        if((i+1)%3==0){
            x = border;
            y += (ITEM_MARGIN_VERTICAL+height);
        }
    }
}

-(void)addItem:(UIImage *)image{
    if(self.images.count>=9){
        return;
    }
    if(image!=nil){
        [self.images addObject:image];
        MGPictureView* picView = self.subviews[self.images.count-1];
        picView.image = image;
        picView.hidden = NO;
        picView.deleteBtn.hidden = NO;
        addBtnIndex = self.images.count;
    }
    if(addBtnIndex<self.subviews.count){
        MGPictureView* picView = self.subviews[self.images.count];
        picView.hidden = NO;
        picView.image = [UIImage imageNamed:@"compose_pic_add"];
        picView.deleteBtn.hidden = YES;
    }
}


@end
