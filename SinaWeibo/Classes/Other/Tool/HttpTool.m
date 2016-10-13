//
//  HttpTool.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/26.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "BinaryData.h"

@implementation HttpTool

+(void)GET:(NSString *)url params:(id)params success:(void (^)(id))success failure:(void (^)(NSError *))failure progressText:(NSString *)progressText successToast:(NSString *)successToast failureToast:(NSString *)failureToast{
    if(progressText){
        [MBProgressHUD showMessage:progressText];
    }
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(progressText){
            [MBProgressHUD hideHUD];
        }
        if(successToast){
            [MBProgressHUD showSuccess:successToast];
        }
        if(success){
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(progressText){
            [MBProgressHUD hideHUD];
        }
        if(failureToast){
            [MBProgressHUD showError:failureToast];
        }
        if(failure){
            failure(error);
        }
    }];

}

+(void)POST:(NSString *)url params:(id)params success:(void (^)(id))success failure:(void (^)(NSError *))failure progressText:(NSString *)progressText successToast:(NSString *)successToast failureToast:(NSString *)failureToast{
    if(progressText){
        [MBProgressHUD showMessage:progressText];
    }
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(progressText){
            [MBProgressHUD hideHUD];
        }
        if(successToast.length){
            [MBProgressHUD showSuccess:successToast];
        }
        if(success){
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(progressText){
            [MBProgressHUD hideHUD];
        }
        if(failureToast.length){
            [MBProgressHUD showError:failureToast];
        }
        if(failure){
            failure(error);
        }
    }];

}

+(void)POST:(NSString *)url textParams:(id)textParams binaryParams:(id)binaryParams success:(void (^)(id))success failure:(void (^)(NSError *))failure progressText:(NSString *)progressText successToast:(NSString *)successToast failureToast:(NSString *)failureToast{
    if(progressText){
        [MBProgressHUD showMessage:progressText];
    }
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:textParams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //constructingBodyWithBlock这个block在发送请求之前会自动调用
        for(BinaryData* data in binaryParams){
            [formData appendPartWithFileData:data.data name:data.paramName fileName:data.serverFileName mimeType:data.mimeType];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(success){
            success(responseObject);
        }
        if(progressText){
            [MBProgressHUD hideHUD];
        }
        if(successToast){
            [MBProgressHUD showSuccess:successToast];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(progressText){
            [MBProgressHUD hideHUD];
        }
        if(failureToast){
            [MBProgressHUD showError:failureToast];
        }
        if(failure){
            failure(error);
        }
    }];

}
@end
