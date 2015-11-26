//
//  MGTextView.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/24.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGTextView : UITextView
@property(nonatomic,strong)UILabel* placeholderView;
-(void) setPlaceholder:(NSString *)placeholder;
@end
