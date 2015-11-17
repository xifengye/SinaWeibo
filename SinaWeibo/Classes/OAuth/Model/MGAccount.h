//
//  MGAccount.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/16.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGAccount : NSObject<NSCoding>
@property(nonatomic,copy)NSString* access_token;
@property(nonatomic,assign)long long expires_in;
@property(nonatomic,assign)long long remind_in;
@property(nonatomic,assign)long long uid;

@property(nonatomic,strong)NSDate* expire_date;

-(instancetype) initWithDictionary:(NSDictionary*)dictionary;
+(instancetype) accountWithDictionary:(NSDictionary*)dictionary;
@end
