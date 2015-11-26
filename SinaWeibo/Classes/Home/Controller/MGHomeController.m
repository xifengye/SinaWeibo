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
#import "UIImage+MG.h"
#import "MJRefresh.h"
#import "MGAccount.h"
#import "MGAccountTool.h"


typedef NS_ENUM(NSInteger, UITableDragWhere) {
    Header,
    Footer,
};

@interface MGHomeController ()<MJRefreshBaseViewDelegate>
@property(nonatomic,strong)NSMutableArray* statuesFrame;
//@property(nonatomic,strong)UIRefreshControl* refreshView;
@property(nonatomic,strong)MJRefreshFooterView* footerView;
@property(nonatomic,strong)MJRefreshHeaderView* headerView;
@property(nonatomic,assign)UITableDragWhere where;
@end



@implementation MGHomeController


-(NSMutableArray *)statuesFrame{
    if(_statuesFrame==nil){
        _statuesFrame = [NSMutableArray array];
    }
    return _statuesFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_statuesFrame removeAllObjects];
    [self setupNavBar];
    [self setupTableView];
    [self setupRefreshController];
    [self setupInfo];
    
}

/**
 加载用户信息
 */
-(void)setupInfo{
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    MGAccount* account = [MGAccountTool getAccount];
    NSString* url = [ NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%lld",account.access_token,account.uid];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        User* user = [User objectWithKeyValues:responseObject];
        MGTitleButton* titleView = self.navigationItem.titleView;
        [titleView setTitle:user.name forState:UIControlStateNormal];
        NSLog(@"加载当前用户信息成功:%@",user);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"加载当前用户信息失败");
    }];
}

-(void)setupTableView{
    self.tableView.backgroundColor = CellBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(TableCellBorder, 0, TableCellBorder, 0);
}

-(void)setupRefreshController{
//    UIRefreshControl* refreshView = [[UIRefreshControl alloc]init];
//    [self.tableView addSubview:refreshView];
//    self.refreshView = refreshView;
//    [refreshView addTarget:self action:@selector(tableViewRefresh:) forControlEvents:UIControlEventValueChanged];
//    [self.refreshView beginRefreshing];
//    [self tableViewHeaderRefresh:refreshView];
    
    MJRefreshHeaderView* headerView = [MJRefreshHeaderView header];
    headerView.scrollView = self.tableView;
    headerView.delegate = self;
    headerView.tag = 1;
    self.headerView = headerView;
    
    
    MJRefreshFooterView* footerView = [MJRefreshFooterView footer];
    footerView.scrollView = self.tableView;
    footerView.delegate = self;
    footerView.tag = 2;
    self.footerView = footerView;
    
    [headerView beginRefreshing];
}

//-(void)tableViewHeaderRefresh:(UIRefreshControl*)refreshView{
//    NSLog(@"refresh");
//    self.where = Header;
//    [self loadWeibo];
//}

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    self.where = refreshView.tag==1?Header:Footer;
    [self loadWeibo];
}


-(void)loadWeibo{
    MGAccount* account = [MGAccountTool getAccount];
    NSString* url = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"count"] = @20;
    if(self.where==Header){
        if(_statuesFrame.count>0){
            StatusFrame* s = self.statuesFrame[0];
            params[@"since_id"]=s.status.idstr;
        }
    }else if(self.where == Footer){
        StatusFrame* s = [self.statuesFrame lastObject];
        params[@"max_id"]=s.status.idstr;
    }
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation * operation, id response) {
//        NSLog(@"success   %@",response);
        NSArray* arr = response[@"statuses"];
        NSArray* statusArray = [Status objectArrayWithKeyValuesArray:arr];
        NSMutableArray* statusFrameArray = [NSMutableArray array];
        for(Status* status in statusArray){
            StatusFrame* statusFrame = [[StatusFrame alloc] init];
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        if(self.where==Header){
            [self toastRefreshResult:statusFrameArray.count];
            NSMutableArray* temp = [NSMutableArray array];
            [temp addObjectsFromArray:statusFrameArray];
            if(self.statuesFrame.count>0){
                [temp addObjectsFromArray:self.statuesFrame];
            }
            self.statuesFrame = temp;
            [self.headerView endRefreshing];
        }else if(self.where == Footer){
            [self.statuesFrame addObjectsFromArray:statusFrameArray];
            [self.footerView endRefreshing];
            
        }
        [self.tableView reloadData];
        
      } failure:^(AFHTTPRequestOperation * operation , NSError * error) {
//        NSLog(@"error   %@",error);
        if([self.headerView isRefreshing]){
            [self.headerView endRefreshing];
        }
        if([self.footerView isRefreshing]){
            [self.footerView endRefreshing];
        }
    }];
}

-(void)toastRefreshResult:(int)newCount{
    UIButton* btn = [[UIButton alloc]init];
    btn.userInteractionEnabled = NO;
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    [btn setBackgroundImage:[UIImage imageWithStretchable:@"timeline_new_status_background"] forState:UIControlStateNormal];
    if(newCount>0){
        [btn setTitle:[NSString stringWithFormat:@"%d 条新数据",newCount] forState:UIControlStateNormal];
    }else{
        [btn setTitle:@"没有新数据" forState:UIControlStateNormal];
    }
    
    CGFloat btnW = self.view.frame.size.width;
    CGFloat btnH = 30;
    CGFloat btnX = 0;
    CGFloat btnY = 64-btnH;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    [UIView animateWithDuration:0.7 animations:^{
        btn.transform = CGAffineTransformMakeTranslation(0, btnH+1);
    } completion:^(BOOL finished) {
        [UIView animateKeyframesWithDuration:0.7 delay:1.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [btn removeFromSuperview];
        }];
    }];
}

-(void)setupNavBar{
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithButton:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted" target:self action:@selector(leftBarButtonItemClicked:)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithButton:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted" target:self action:@selector(rightBarButtonItemClicked:)];
    
    NSString* title = @"首页";
    UIImage* rightImage = [UIImage imageNamed:@"navigationbar_arrow_down"];
    MGTitleButton* titleView = [[MGTitleButton alloc] init];
    titleView.delegate = self;
    [titleView setImage:rightImage forState:UIControlStateNormal];
    [titleView setTitle:title forState:UIControlStateNormal];
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
