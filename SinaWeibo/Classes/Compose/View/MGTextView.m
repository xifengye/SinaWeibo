//
//  MGTextView.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/24.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import "MGTextView.h"

@implementation MGTextView

-(instancetype)init{
    if(self = [super init]){
        UILabel* placeHolder = [[UILabel alloc]init];
        placeHolder.numberOfLines = 0;
        placeHolder.textColor = [UIColor grayColor];
        [self addSubview:placeHolder];
        self.placeholderView = placeHolder;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextViewTextDidChangeNotification object:self];
        
    }
    return self;
}

-(void)textChanged{
    self.placeholderView.hidden = self.text.length>0;
}


-(void)setPlaceholder:(NSString*)placeholder{
    self.placeholderView.text = placeholder;
    CGSize size = [placeholder sizeWithFont:self.placeholderView.font];
    self.placeholderView.frame = CGRectMake(6, 6, size.width-12, size.height);
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
