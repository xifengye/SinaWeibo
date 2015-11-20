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
#import "MGStatusRetweetView.h"
#import "MGStatusView.h"



@interface MGWeiboCell()

@property(nonatomic,weak)MGStatusView* statusView;




@property(nonatomic,weak)MGStatusToolBar* statusToolBar;
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
        //添加工具条
        [self setupStatusToolBar];
    }
    return self;
}

-(void)setupOriginalSubviews{
    MGStatusView* statusView = [[MGStatusView alloc]init];
    [self.contentView addSubview:statusView];
    self.statusView = statusView;
    
    
}


-(void)setupStatusToolBar{
    MGStatusToolBar* statusToolBar = [[MGStatusToolBar alloc]init];
    
    [self.contentView addSubview:statusToolBar];
    self.statusToolBar = statusToolBar;
   

}

-(void)setStatusFrame:(StatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    
    //添加原创微博内部的子控件
    [self setupOriginalData];
    
    [self setupStatusToolBarData];

}

-(void)setupOriginalData{
    self.statusView.frame = self.statusFrame.topViewF;
    self.statusView.statusFrame = self.statusFrame;
}


-(void)setupStatusToolBarData{
    self.statusToolBar.frame = self.statusFrame.statusToolBarF;
    self.statusToolBar.statusFrame = self.statusFrame;
   
}

-(void)setFrame:(CGRect)frame{
    frame.origin.x = TableCellBorder;
    frame.size.width -= TableCellBorder*2;
    frame.size.height -= TableCellBorder;
    [super setFrame:frame];
}
@end
