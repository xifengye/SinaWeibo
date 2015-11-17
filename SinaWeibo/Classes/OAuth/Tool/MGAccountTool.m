//
//  MGAccountTool.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/16.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "MGAccountTool.h"
#import "MGAccount.h"

#define MGAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation MGAccountTool

+(void)saveAccount:(MGAccount *)account{
    NSDate* now = [NSDate date];
    account.expire_date = [now dateByAddingTimeInterval:account.expires_in];
    [NSKeyedArchiver archiveRootObject:account toFile:MGAccountFile];
}

+(MGAccount *)getAccount{
    NSDate* now = [NSDate date];
    MGAccount* account = [NSKeyedUnarchiver unarchiveObjectWithFile:MGAccountFile];
    if([now compare:account.expire_date] == NSOrderedAscending){
        return account;
    }else{
        return nil;
    }
}

@end
