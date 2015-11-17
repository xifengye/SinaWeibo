//
//  User.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/17.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 
 {
 "id": 1404376560,
 "screen_name": "zaku",
 "name": "zaku",
 "province": "11",
 "city": "5",
 "location": "北京 朝阳区",
 "description": "人生五十年，乃如梦如幻；有生斯有死，壮士复何憾。",
 "url": "http://blog.sina.com.cn/zaku",
 "profile_image_url": "http://tp1.sinaimg.cn/1404376560/50/0/1",
 "domain": "zaku",
 "gender": "m",
 "followers_count": 1204,
 "friends_count": 447,
 "statuses_count": 2908,
 "favourites_count": 0,
 "created_at": "Fri Aug 28 00:00:00 +0800 2009",
 "following": false,
 "allow_all_act_msg": false,
 "remark": "",
 "geo_enabled": true,
 "verified": false,
 "allow_all_comment": true,
 "avatar_large": "http://tp1.sinaimg.cn/1404376560/180/0/1",
 "verified_reason": "",
 "follow_me": false,
 "online_status": 0,
 "bi_followers_count": 215
 }

 
 
 */

@interface User : NSObject
//+(instancetype)userWithDict:(NSDictionary*)dict;
//-(instancetype)initWithDict:(NSDictionary*)dict;
@property(nonatomic,assign)long long ID;
@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* profile_image_url;
//@property(nonatomic,copy)NSString* screen_name;
//@property(nonatomic,assign)int followers_count;
//@property(nonatomic,assign)int statuses_count;
//@property(nonatomic,assign)int favourites_count;
@end