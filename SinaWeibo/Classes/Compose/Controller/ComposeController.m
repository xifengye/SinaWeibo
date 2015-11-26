//
//  ComposeController.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/24.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import "ComposeController.h"
#import "MGTextView.h"
#import "AFNetworking.h"
#import "MGAccount.h"
#import "MGAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "MGComposeToolBar.h"
#import "MGPicturesView.h"

#define MGNotificationCenter [NSNotificationCenter defaultCenter]
#define TextViewTextHeight  100

@interface ComposeController()
{
    BOOL sendEnable;
}
@end

@interface ComposeController ()<ComposeToolBarDetegate,UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,MGPicturesViewDelegate>
@property(nonatomic,weak)MGTextView* textView;
@property(nonatomic,weak)MGComposeToolBar* composeToolBar;
@property(nonatomic,weak)MGPicturesView* picturesView;
@end

@implementation ComposeController

- (void)viewDidLoad {
    [super viewDidLoad];
    sendEnable = false;
    [self setupNavBar];
    [self setupTextView];
    [self setupToolBar];
    [self setupPicturesView];
   }

-(void)setupPicturesView{
    MGPicturesView* pictureView = [[MGPicturesView alloc]init];
    pictureView.frame = CGRectMake(0, TextViewTextHeight+10, self.textView.frame.size.width, self.textView.frame.size.height-TextViewTextHeight);
    [self.textView addSubview:pictureView];
    self.picturesView = pictureView;
    pictureView.hidden = YES;
    pictureView.delegate = self;
}

-(void)setupToolBar{
    MGComposeToolBar* toolbar = [[MGComposeToolBar alloc]init];
    toolbar.frame = CGRectMake(0, self.view.frame.size.height-ToolBbarHeight, self.view.frame.size.width, ToolBbarHeight);
    [self.view addSubview:toolbar];
    toolbar.delegate = self;
    self.composeToolBar = toolbar;
}

-(void)composeToolBarDidClickedItem:(MGComposeToolBarButtonType)tag{
    switch (tag) {
        case MGComposeToolBarButtonTypePicture://照片
            NSLog(@"发照片");
            [self openAlbum];
            break;
        case MGComposeToolBarButtonTypeCarema://拍照
            NSLog(@"发拍照");
            [self openCarema];
            break;
            
        case MGComposeToolBarButtonTypeTrend://热门话题
            NSLog(@"热门话题");
            break;
        case MGComposeToolBarButtonTypeMention://私信
            NSLog(@"发私信");
            break;
        case MGComposeToolBarButtonTypeEmotion://表情
            NSLog(@"发表情");
            break;
        default:
            break;
    }
}

-(void)openAlbum{
    UIImagePickerController* ipc = [[UIImagePickerController alloc]init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:ipc animated:YES completion:nil];
    ipc.delegate = self;
}

-(void)openCarema{
    UIImagePickerController* ipc = [[UIImagePickerController alloc]init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:ipc animated:YES completion:nil];
    ipc.delegate = self;
}

//从相册或照相机中选择照片返回时被调用
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:true completion:nil];
//    NSLog(@"info=%@",info);
    UIImage* image = info[UIImagePickerControllerOriginalImage];
    self.picturesView.hidden = NO;
    [self.picturesView addItem:image];
//    sendEnable = true;
}

-(void)setupTextView{
    MGTextView* textView = [[MGTextView alloc]init];
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:15];
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    [self.view addSubview:textView];
    
    self.textView = textView;
    [self.textView setPlaceholder:@"来,说两句..."];
    //监听textView文字变化,当文字发生变化的时候会调用textViewTextChanged方法
    [MGNotificationCenter addObserver:self selector:@selector(textViewTextChanged) name:UITextViewTextDidChangeNotification object:textView];
    
    [MGNotificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [MGNotificationCenter addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}

//键盘显示时将底部工具栏移动到键盘之上
-(void)keyboardWillShow:(NSNotification*)notifaction{
    NSValue* value = notifaction.userInfo[UIKeyboardBoundsUserInfoKey];
    CGFloat keyBoardHeight = value.CGRectValue.size.height;
    [UIView animateWithDuration:0.5 animations:^{
        self.composeToolBar.transform = CGAffineTransformMakeTranslation(0, -keyBoardHeight);
    } completion:^(BOOL finished) {
        
    }];
}

//键盘隐藏时将底部工具栏还原到原来位置
-(void)keyboardWillHidden:(NSNotification*)notifaction{
    self.composeToolBar.transform = CGAffineTransformIdentity;//还原动画之前的位置
}

-(void)viewDidAppear:(BOOL)animated{
    [self.textView becomeFirstResponder];//设置键盘第一个获取到焦点,即弹出键盘,如果不放在这里在didViewload方法中就卡一下
}

-(void)setupNavBar{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(sendMessage)];
    
    self.navigationItem.title = @"发微博";

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self sendStateChange];
}



-(void)textViewTextChanged{
    sendEnable = self.textView.text.length>0;
    [self sendStateChange];
}

-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)sendMessage{
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    MGAccount* account = [MGAccountTool getAccount];
    if(self.picturesView.images.count>0){
        [self sendPictureMessage:self.textView.text images:nil useAccessToken:account.access_token byAf:manager];
    }else{
        [self sendTextMessage:self.textView.text useAccessToken:account.access_token byAf:manager];
    }
    
    [self cancel];
}

-(void)sendPictureMessage:(NSString*)text images:(NSArray*)images useAccessToken:(NSString*)accessToken byAf:(AFHTTPRequestOperationManager*)manager{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    NSString* url = @"https://api.weibo.com/2/statuses/upload.json";
    params[@"access_token"] = accessToken;
    NSString *encodedValue = self.textView.text;
    params[@"status"] = encodedValue;
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //constructingBodyWithBlock这个block在发送请求之前会自动调用
        for(int i=0;i<self.picturesView.images.count;i++){
            NSData* data = UIImageJPEGRepresentation(self.picturesView.images[i], 1.0);
            [formData appendPartWithFileData:data name:@"pic" fileName:@"" mimeType:@"image/jepg"];
        }
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"发送一条信息成功:%@",responseObject);
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"发送一条信息失败:%@",error);
        [MBProgressHUD showError:@"发送失败"];
    }];
}

-(void)sendTextMessage:(NSString*)text useAccessToken:(NSString*)accessToken byAf:(AFHTTPRequestOperationManager*)manager{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    NSString* url = @"https://api.weibo.com/2/statuses/update.json";
    params[@"access_token"] = accessToken;
    NSString *encodedValue = text;
    params[@"status"] = encodedValue;
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"发送一条信息成功:%@",responseObject);
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"发送一条信息失败:%@",error);
        [MBProgressHUD showError:@"发送失败"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)dealloc{
    [MGNotificationCenter removeObserver:self];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];//结束编辑隐藏键盘
}

-(void)picturesViewDidAddItem{
    NSLog(@"picturesViewDidAddItem");
    [self openAlbum];
}

-(void)picturesViewBeganEmpty{
    sendEnable = self.textView.text.length>0;
    [self sendStateChange];
}

-(void)sendStateChange{
    [self.navigationItem.rightBarButtonItem setEnabled:sendEnable];
}

@end
