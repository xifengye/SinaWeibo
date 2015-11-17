//
//  MGAccountTool.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/16.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGAccount.h"
@interface MGAccountTool : NSObject
+(void)saveAccount:(MGAccount*)account;
+(MGAccount*)getAccount;
@end
