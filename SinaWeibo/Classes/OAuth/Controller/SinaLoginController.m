//
//  SinaLoginController.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/13.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "SinaLoginController.h"
#import "AFNetworking.h"
#import "MGAccount.h"
#import "NewFeatureController.h"
#import "MainController.h"
#import "MGAccountTool.h"
#import "MBProgressHUD+MJ.h"

@interface SinaLoginController() <UIWebViewDelegate>
@property(nonatomic,retain)UIWebView* webView;


@end

@implementation SinaLoginController

-(void)viewDidLoad{
    UIWebView* webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    webView.delegate = self;
    self.webView = webView;
    [self requestCode];
    }

-(void)requestCode{
    NSURL* url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=2572811273&redirect_uri=http://www.moregood.com"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

-(void)accessTokenWithCode:(NSString*)code{
    NSString* url = @"https://api.weibo.com/oauth2/access_token";
    NSLog(@"url=  %@\n\n",url);
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"2572811273";
    params[@"client_secret"] = @"cb92ea0cdb6a398be6478f426de44689";
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = @"http://www.moregood.com";
    params[@"code"] = code;
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        /*
         success    {
         "access_token" = "2.00oWPclCBkPHoC398153322adM3EiB";
         "expires_in" = 157679999;
         "remind_in" = 157679999;
         uid = 2535869614;
         }
         */
        MGAccount* account = [MGAccount accountWithDictionary:responseObject];
        [self didLoginSuccess:account];
        
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"\n\nerror     %@",error);
            [MBProgressHUD hideHUD];
    }];
    
}

-(void)didLoginSuccess:(MGAccount*) account{
    [MBProgressHUD hideHUD];
    [MGAccountTool saveAccount:account];
    BOOL isFirstOpenNewVersion = [NewFeatureController isFirstOpenNewVersion];
    if(isFirstOpenNewVersion){
        self.view.window.rootViewController = [[NewFeatureController alloc] init];
    }else{
        self.view.window.rootViewController = [[MainController alloc] init];
    }

}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"加载中请稍等..."];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUD];
}

-(void)onCode:(NSString*)code{
    NSLog(@"%@",code);
    [self accessTokenWithCode:code];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:
(UIWebViewNavigationType)navigationType{
    NSLog(@"url=  %@\n\n",request.URL.absoluteString);
    NSString* requestStr = request.URL.absoluteString;
    NSRange range = [requestStr rangeOfString:@"code="];
    if(range.location != NSNotFound){
        NSString* code = [requestStr substringFromIndex:(range.location+range.length)];
        [self onCode:code];
        return NO;
    }
    return YES;
}


@end
