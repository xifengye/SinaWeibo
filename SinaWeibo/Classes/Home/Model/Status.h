//
//  WeiboItem.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/17.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
/**
 
 {
 "statuses": [
 {
 "created_at": "Tue May 31 17:46:55 +0800 2011",
 "id": 11488058246,
 "text": "求关注。"，
 "source": "<a href="http://weibo.com" rel="nofollow">新浪微博</a>",
 "favorited": false,
 "truncated": false,
 "in_reply_to_status_id": "",
 "in_reply_to_user_id": "",
 "in_reply_to_screen_name": "",
 "geo": null,
 "mid": "5612814510546515491",
 "reposts_count": 8,
 "comments_count": 9,
 "annotations": [],
 "user": {} },
 ...
 ],
 "ad": [
 {
 "id": 3366614911586452,
 "mark": "AB21321XDFJJK"
 },
 ...
 ],
 "previous_cursor": 0,      // 暂时不支持
 "next_cursor": 11488013766,     // 暂时不支持
 "total_number": 81655
 }
 
 */

@interface Status : NSObject
//+(instancetype)weiboWithDict:(NSDictionary*)dict;
//-(instancetype)initWithDict:(NSDictionary*)dict;
@property(nonatomic,copy)NSString* created_at;//创建时间
@property(nonatomic,assign)long long ID;
@property(nonatomic,copy)NSString* text;
@property(nonatomic,copy)NSString* source;
//@property(nonatomic,copy)NSString* thumbnail_pic;
@property(nonatomic,strong)NSArray* pic_urls;


@property(nonatomic,assign)int reposts_count;//转发数
@property(nonatomic,assign)int comments_count;//评论数
@property(nonatomic,assign)int attitudes_count;//被赞数
@property(nonatomic,strong)User* user;
@property(nonatomic,strong)Status* retweeted_status;//被转发微博

@end
