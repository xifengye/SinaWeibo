//
//  MGWeiboCell.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/17.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusFrame.h"

#define CellBackgroundColor  [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1]

@interface MGWeiboCell : UITableViewCell
+(instancetype) cellWithTableView:(UITableView*)tableView;
@property(nonatomic,strong)StatusFrame* statusFrame;
@end
