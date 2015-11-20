//
//  WeiboItem.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/17.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "Status.h"
#import "NSDate+MG.h"
#import "MJExtension.h"
#import "Photo.h"

@implementation Status
/*
+(WeiboItem*)weiboWithDict:(NSDictionary*)dict{
    return [[self alloc]initWithDict:dict];
}
-(WeiboItem*)initWithDict:(NSDictionary*)dict{
    if(self = [super init]){
//        self.created_at =
        self.source = dict[@"source"];
        self.text = dict[@"text"];
        self.ID = dict[@"id"];
        self.reposts_count = [dict[@"reposts_count"] intValue];
        self.comments_count = [dict[@"comments_count"] intValue];
        self.user = [User userWithDict:dict[@"user"]];
    }
    return self;
}
 */

-(NSDictionary *)objectClassInArray{
    return @{@"pic_urls":[Photo class]};
}

-(NSString *)created_at{
    //Wed Nov 18 14:03:31 +0800 2015  create_at
    NSDateFormatter* format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate* createDate = [format dateFromString:_created_at];
    return createDate.timeFormatWithSina;
}
-(void)setSource:(NSString *)source{
    NSRange range = [source rangeOfString:@"rel=\"nofollow\">"];
    if(range.location!=NSNotFound){
        NSRange endRange = [source rangeOfString:@"</a>"];
        _source =  [NSString stringWithFormat:@"来自 %@",[source substringWithRange:NSMakeRange(range.location+range.length, endRange.location-(range.location+range.length))]];
    }

}


@end
