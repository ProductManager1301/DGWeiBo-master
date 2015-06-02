//
//  ViewController.m
//  DGWeiBo
//
//  Created by 钟伟迪 on 15/5/26.
//  Copyright (c) 2015年 钟伟迪. All rights reserved.
//

//应用回调页，需要在开发平台>个人应用>应用管理>高级管理>回调URL ，进行设置
#define kRedirectURI    @"https://api.weibo.com/oauth2/default.html"


#import "ViewController.h"
#import "WeiboSDK.h"
#import "AppDelegate.h"
#import "DGPackageData.h"
#import "DGJSONModel.h"
#import "PullRefreshTableView.h"
#import "WeiBoTableViewCell.h"
#import "HTTPRequest.h"
#import "RootViewController.h"
#import "WeiboDetailViewController.h"
#import "BaseNavigationController.h"

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


typedef NS_ENUM(NSInteger , CURRENT_WEIBO_TYPE){
 CURRENT_WEIBO_TYPE_NEW = 1,  //最新微博
 CURRENT_WEIBO_TYPE_ATTENTION = 2//我关注的微博
};

@interface ViewController ()<PullRefreshDelegate,UITableViewDelegate,UITableViewDataSource,RootViewControllerDelegate>

@property (weak, nonatomic) IBOutlet PullRefreshTableView *weiboTableView;

@end

@implementation ViewController{
    NSInteger _currentPage;
    NSMutableArray * _newsWeibos;
    NSMutableArray * _attentionWeibos;
    CURRENT_WEIBO_TYPE _weiboType;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _weiboType = CURRENT_WEIBO_TYPE_NEW;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentPage = 1;
    
    self.title = @"公共微博";
    
    _newsWeibos = [NSMutableArray array];
    _attentionWeibos = [NSMutableArray array];
    
    [_weiboTableView setPDelegate:self];//设置下拉刷新的委托对象
    [_weiboTableView reloadDataFirst];//第一次刷新数据
    
}



//点击侧滑按钮事件
- (IBAction)siderRootViewAction:(id)sender {
    //发送侧滑通知
    [[NSNotificationCenter defaultCenter] postNotificationName:MENU_SLIDER object:nil];
}

- (IBAction)btnAction:(id)sender {
    
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

#pragma mark - RootViewControllerDelegate
- (void)deSelectedIndexPath:(NSIndexPath *)indexPath withRootViewController:(RootViewController *)rootViewController{
    
    _weiboType = indexPath.row;
    
    if (_weiboType == CURRENT_WEIBO_TYPE_NEW) {
    self.title = @"公共微博";
    }else if(_weiboType == CURRENT_WEIBO_TYPE_ATTENTION){
     self.title = @"我的关注";
    }
    
    [self.weiboTableView reloadDataFirst];
    [self.weiboTableView reloadData];
    [self siderRootViewAction:nil];
}

#pragma mark - PullRefreshDelegate
/*下拉刷新触发方法*/
- (void)upLoadDataWithTableView:(PullRefreshTableView *)tableView{
    _currentPage = 1;
    [self updateDataWithType:_weiboType isRemoveOldData:YES];
}

/*上拉加载触发方法*/
- (void)refreshDataWithTableView:(PullRefreshTableView *)tableView{
    _currentPage ++;
    [self updateDataWithType:_weiboType isRemoveOldData:NO];

}

- (void)updateDataWithType:(CURRENT_WEIBO_TYPE)type isRemoveOldData:(BOOL)isRemove{
    
    if (type == CURRENT_WEIBO_TYPE_NEW) {
        [DGPackageData newestPublicWeiboWithCount:@"20" page:@"1" baseApp:@"0" responseObject:^(id responseObject) {
            
            NewestWeiBoesModel * newsWeiboes = responseObject;
            
            if (isRemove) [_newsWeibos removeAllObjects];
            
            [_newsWeibos addObjectsFromArray:newsWeiboes.statuses];
            
            self.weiboTableView.reachedTheEnd = YES;
            
            [self.weiboTableView reloadData];
            
        } failure:^(NSError *error) {
            self.weiboTableView.isUpdataError = YES;
            self.weiboTableView.labelCenter.text = @"授权过期了";
            [self.weiboTableView reloadData];
        }];
    }else{
        
        [DGPackageData attentionWeiboWithCount:@"20" page:@"1" baseApp:@"0" responseObject:^(id responseObject) {
            
            NewestWeiBoesModel * newsWeiboes = responseObject;
            
            if (isRemove) [_attentionWeibos removeAllObjects];
            
            [_attentionWeibos addObjectsFromArray:newsWeiboes.statuses];
            
            self.weiboTableView.reachedTheEnd = YES;
            
            [self.weiboTableView reloadData];
            
        } failure:^(NSError *error) {
            
            self.weiboTableView.isUpdataError = YES;
            self.weiboTableView.labelCenter.text = @"授权过期了";
            [self.weiboTableView reloadData];

        }];
        
    }
    
}

- (NSArray *)currentArray{
    if (_weiboType ==CURRENT_WEIBO_TYPE_NEW) {
        return _newsWeibos;
    }else{
        return _attentionWeibos;
    
    }
}

//我们需要将视图拖动的事件返给PullRefreshTableView
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.weiboTableView pullScrollViewDidScroll:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.weiboTableView pullScrollViewWillBeginDragging:scrollView];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * array = self.currentArray;
    return array.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * indentifier = @"WeiBoTableViewCell";
    WeiBoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:indentifier owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NewestWeiBoModel * weibo = self.currentArray[indexPath.row];
    
    cell.contentTextLabel.text = weibo.text;
    cell.commentsCountLabel.text =[NSString stringWithFormat:@"评论:%ld",weibo.comments_count];
    
    cell.repostsCountLabel.text = [NSString stringWithFormat:@"转发:%ld",weibo.reposts_count];
    
    cell.attitudesCountLabel.text = [NSString stringWithFormat:@"赞:%ld",weibo.attitudes_count];
    
    cell.timeString = weibo.created_at;
    
    cell.imageUrls = weibo.pic_urls;
    
    UserInfoModel * userInfo = weibo.user;
    
    cell.userNameLabel.text = userInfo.screen_name;
    
    [HTTPRequest downLoadImage:userInfo.avatar_large qualityRatio:1.0 pixelRatio:1.0 responseObject:^(id responseObject) {
        cell.headerImageView.image = responseObject;
        
    } failure:^(NSError *error, NSString *pathString) {
        
    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}

#pragma  mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"PushWeiboDetailView" sender:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Push stroyboard
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"PushWeiboDetailView"]) {
        WeiboDetailViewController * detailViewController = segue.destinationViewController;
        NSIndexPath * indexPath = sender;
        detailViewController.currnetWeibo = self.currentArray[indexPath.row];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

