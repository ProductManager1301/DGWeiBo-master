//
//  RootViewController.m
//  DGWeiBo
//
//  Created by 钟伟迪 on 15/5/29.
//  Copyright (c) 2015年 钟伟迪. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h"
#import "HeadUserInfoCell.h"
#import "CategordCell.h"
#import "UIImage+APLBlurEffect.h"
#import "DGJSONModel.h"
#import "HTTPRequest.h"
#import "DGPackageData.h"
#import "AppDelegate.h"

@interface RootViewController ()<UITableViewDataSource , UITableViewDelegate>

@property (strong , nonatomic)NSArray * titleInfoes;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RootViewController

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.titleInfoes = @[@{@"image":@"home",
                               @"title":@"最新公共微博"},
                             @{@"image":@"heard",
                               @"title":@"我的关注"},
                             @{@"image":@"messages",
                               @"title":@"消息中心"},
                             @{@"image":@"location",
                               @"title":@"发现"},
                             @{@"image":@"lclendar",
                               @"title":@"我的记录"},
                             @{@"image":@"edit",
                               @"title":@"我的评论"}];
    }
    return self;

}

- (void)viewDidLoad{
    [super viewDidLoad];
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    UINavigationController * navigationController = [storyboard instantiateViewControllerWithIdentifier:@"BaseNavigationController"];
    
    [self.view addSubview:navigationController.view];
    
    [self addChildViewController:navigationController];
    
    self.delegate = (id)navigationController.topViewController;
    
    
    //设置列表分割线风格
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIImageView * backImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    backImageView.image = [UIImage imageNamed:@"RootBackgroud"];
    
    [self.view insertSubview:backImageView atIndex:0];
    
    AppDelegate * appDelegate  = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [DGPackageData gainUserInfoWithUID:appDelegate.wbCurrentUserID responseObject:^(id responseObject) {
        ex_userInfo = responseObject;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
 
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _titleInfoes.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        static NSString * identifier = @"HeadUserInfoCell";
        HeadUserInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier ];
        
        [HTTPRequest downLoadImage:ex_userInfo.profile_image_url qualityRatio:1.0 pixelRatio:1.0 responseObject:^(id responseObject) {
            cell.headerImageView.image = responseObject;
        } failure:^(NSError *error, NSString *pathString) {
            
        }];
        
        cell.userNameLabel.text = ex_userInfo.screen_name;
        cell.signerLabel.text = ex_userInfo.user_description;
        
        return cell;
        
    }else{
        static NSString * identifer = @"CategordCell";
        CategordCell * cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        
        cell.titleLabel.text = self.titleInfoes[indexPath.row-1][@"title"];
        cell.titleImageView.image = [UIImage imageNamed:self.titleInfoes[indexPath.row-1][@"image"]];
        
        
        return cell;
        
    }
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        return 80;
    }else{
        return 55;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(deSelectedIndexPath:withRootViewController:)]) {
        [self.delegate deSelectedIndexPath:indexPath withRootViewController:self];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//获取当前不同显示类型的数组内容


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


@end
