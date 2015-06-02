//
//  WeiboDetailViewController.m
//  DGWeiBo
//
//  Created by 钟伟迪 on 15/5/31.
//  Copyright (c) 2015年 钟伟迪. All rights reserved.
//

#import "WeiboDetailViewController.h"
#import "WeiBoTableViewCell.h"
#import "DGJSONModel.h"
#import "CommentTableVIewCell.h"
#import "HTTPRequest.h"
#import "DGPackageData.h"
#import "PullRefreshTableView.h"

@interface WeiboDetailViewController ()<UITableViewDataSource,UITableViewDelegate,PullRefreshDelegate>
@property (weak, nonatomic) IBOutlet PullRefreshTableView *commentTableView;

@property (strong , nonatomic)NSMutableArray * comments;

@end

@implementation WeiboDetailViewController

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _comments = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [DGPackageData weiboCommentWithID:_currnetWeibo.ID count:@"20" page:@"1" responseObject:^(id responseObject) {
        
        CommentsModel * comments = responseObject;
        [_comments addObjectsFromArray:comments.comments];
        [self.commentTableView reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
    
    self.commentTableView.tableHeaderView = [self tableViewHeaderView];
    self.commentTableView.pDelegate = self;
    self.commentTableView.isRefresh = NO;
    

}

- (UIView *)tableViewHeaderView{
    static NSString * identifier = @"WeiBoTableViewCell";
    
    WeiBoTableViewCell * cell =nil;
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NewestWeiBoModel * weibo = self.currnetWeibo;
    
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

/*下拉刷新触发方法*/
- (void)upLoadDataWithTableView:(PullRefreshTableView *)tableView{

}

/*上拉加载触发方法*/
static int _currentPage = 1;
- (void)refreshDataWithTableView:(PullRefreshTableView *)tableView{
    _currentPage ++;
    NSString * page = [NSString stringWithFormat:@"%d",_currentPage];
    [DGPackageData weiboCommentWithID:_currnetWeibo.ID count:@"20" page:page responseObject:^(id responseObject) {
        
        CommentsModel * comments = responseObject;
        [_comments addObjectsFromArray:comments.comments];
        [self.commentTableView reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
}


//我们需要将视图拖动的事件返给PullRefreshTableView
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.commentTableView pullScrollViewDidScroll:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.commentTableView pullScrollViewWillBeginDragging:scrollView];
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _comments.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * identifier = @"CommentTableViewCell";
    
    CommentTableVIewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] lastObject];
    }
    CommentModel * comment = _comments[indexPath.row];
    
    UserInfoModel * userInfo = comment.user;
    
    cell.userNameLabel.text = userInfo.screen_name;
    
    cell.createDate = comment.created_at;
    
    cell.contentTextLabel.text = comment.text;
    
    cell.floorLabel.text = [NSString stringWithFormat:@"%ld 楼",indexPath.row+1];
    
    [HTTPRequest downLoadImage:userInfo.profile_image_url qualityRatio:1.0 pixelRatio:1.0 responseObject:^(id responseObject) {
        cell.headerImageView.image = responseObject;
    } failure:^(NSError *error, NSString *pathString) {
        NSLog(@"评论用户头像错误");
    }];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}



@end
