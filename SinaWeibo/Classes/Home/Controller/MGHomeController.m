//
//  MGHomeController.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/5.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "MGHomeController.h"
#import "UIBarButtonItem+MG.h"
#import "MGTitleButton.h"
#import "AFNetworking.h"
#import "MGAccountTool.h"
#import "UIImageView+WebCache.h"
#import "Status.h"
#import "MJExtension.h"
#import "StatusFrame.h"
#import "MGWeiboCell.h"


@interface MGHomeController ()
@property(nonatomic,strong)NSArray* statuesFrame;
@end

@implementation MGHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self loadWeibo];
    self.tableView.backgroundColor = CellBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(TableCellBorder, 0, TableCellBorder, 0);
}


-(void)loadWeibo{
    MGAccount* account = [MGAccountTool getAccount];
    NSString* url = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation * operation, id response) {
        NSLog(@"success   %@",response);
        NSArray* arr = response[@"statuses"];
        /*
        NSMutableArray* mutableArr = [NSMutableArray array];
        for(int i=0;i<arr.count;i++){
            WeiboItem* item = [WeiboItem objectWithKeyValues:[arr objectAtIndex:i]];//[WeiboItem weiboWithDict:[arr objectAtIndex:i ]];
            [mutableArr addObject:item];
        }
        self.statues = mutableArr;
         */
        NSArray* statusArray = [Status objectArrayWithKeyValuesArray:arr];
        NSMutableArray* statusFrameArray = [NSMutableArray array];
        for(Status* status in statusArray){
            StatusFrame* statusFrame = [[StatusFrame alloc] init];
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        self.statuesFrame = statusFrameArray;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation * operation , NSError * error) {
        NSLog(@"error   %@",error);
    }];
}

-(void)setupNavBar{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithButton:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted" target:self action:@selector(leftBarButtonItemClicked:)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithButton:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted" target:self action:@selector(rightBarButtonItemClicked:)];
    
    NSString* title = @"微博Iphone客";
    UIImage* rightImage = [UIImage imageNamed:@"navigationbar_arrow_down"];
    MGTitleButton* titleView = [[MGTitleButton alloc] init];
    titleView.delegate = self;
    CGSize titleSize = [title sizeWithFont:titleView.font];
    CGFloat titleViewHeight = MAX(titleSize.height, rightImage.size.height);
    titleView.frame = CGRectMake(0, 0,titleSize.width+rightImage.size.width+10, titleViewHeight);
    [titleView setTitle:title forState:UIControlStateNormal];
    [titleView setImage:rightImage forState:UIControlStateNormal];
    self.navigationItem.titleView = titleView;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    StatusFrame* statusFrame = self.statuesFrame[indexPath.row];
    return statusFrame.cellHeight;
}

-(void)leftBarButtonItemClicked:(UIButton*)button{
    NSLog(@"leftBarButtonItemClicked");
}

-(void)rightBarButtonItemClicked:(UIButton*)button{
    NSLog(@"rightBarButtonItemClicked");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.statuesFrame.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MGWeiboCell* cell = [MGWeiboCell cellWithTableView:tableView];
    StatusFrame* statusFrame = self.statuesFrame[indexPath.row];
    cell.statusFrame = statusFrame;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController* controller = [[UIViewController alloc] init];
    controller.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:controller animated:true];
    
}

- (void)didDicrectChange:(BOOL)isUp{
    NSLog(@"didDrcrectChange %@",isUp?@"true":@"false");
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
