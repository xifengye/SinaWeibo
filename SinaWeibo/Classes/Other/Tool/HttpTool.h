//
//  HttpTool.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/26.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject


+(void)GET:(NSString*)url params:(id)params success:(void(^)(id response))success failure:(void(^)(NSError* error))failure progressText:(NSString*)progressText successToast:(NSString*)successToast failureToast:(NSString*)failureToast;
+(void)POST:(NSString*)url params:(id)params success:(void(^)(id response))success failure:(void(^)(NSError* error))failure progressText:(NSString*)progressText successToast:(NSString*)successToast failureToast:(NSString*)failureToast;
+(void)POST:(NSString*)url textParams:(id)textParams  binaryParams:(id) binaryParams success:(void(^)(id response))success failure:(void(^)(NSError* error))failure progressText:(NSString*)progressText successToast:(NSString*)successToast failureToast:(NSString*)failureToast;
@end
