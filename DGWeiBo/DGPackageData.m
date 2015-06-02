//
//  DGPackageData.m
//  DGWeiBo
//
//  Created by 钟伟迪 on 15/5/27.
//  Copyright (c) 2015年 钟伟迪. All rights reserved.
//

#import "DGPackageData.h"
#import "HTTPRequest.h"
#import "AppDelegate.h"
#import "DGJSONModel.h"
#import "AFNetworking.h"

#define source_token  [(AppDelegate*)[[UIApplication sharedApplication] delegate] wbtoken]

@implementation DGPackageData

//获取最新公众微博
+ (void)newestPublicWeiboWithCount:(NSString *)count page:(NSString *)page baseApp:(NSString *)baseApp responseObject:(requestData)blockObject failure:(failureError)failure{
    
    NSDictionary * dic = @{@"source"       : kAppKey,
                           @"access_token" : source_token,
                           @"count"        : count,
                           @"page"         : page,
                           @"base_app"     : baseApp};
    
    NSString * urlType = @"statuses/public_timeline.json";
    
    [HTTPRequest packageDatas:dic urlType:urlType responseObject:^(id responseObject) {

        NSError * err = nil;
        
        NewestWeiBoesModel* countrys = [[NewestWeiBoesModel alloc] initWithString:responseObject error:&err];
        if (err) {
            failure(err);
        }else{
            blockObject(countrys);
        }

    } failure:^(NSError *error) {
        failure(error);
    }];
}

//获取用户信息
+ (void)gainUserInfoWithUID:(NSString *)uid responseObject:(requestData)blockObject failure:(failureError)failure{
    NSDictionary * dic = @{@"source"       : kAppKey,
                           @"access_token" : source_token,
                           @"uid"          : uid,
                           @"screen_name"  : @""};
    
    NSString * urlType = @"users/show.json";
    
    
    [HTTPRequest packageDatas:dic urlType:urlType responseObject:^(id responseObject) {
        
        NSError * err = nil;

        UserInfoModel* countrys = [[UserInfoModel alloc] initWithString:responseObject error:&err];
        if (err) {
            failure(err);
        }else{
            blockObject(countrys);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];

}


+ (void)attentionWeiboWithCount:(NSString *)count page:(NSString *)page baseApp:(NSString *)baseApp responseObject:(requestData)blockObject failure:(failureError)failure{
    NSDictionary * dic = @{@"source"       : kAppKey,
                           @"access_token" : source_token,
                           @"count"        : count,
                           @"page"         : page,
                           @"base_app"     : baseApp};
    
    NSString * urlType = @"statuses/friends_timeline.json";
    
    
    [HTTPRequest packageDatas:dic urlType:urlType responseObject:^(id responseObject) {
        
        NSError * err = nil;
        
        NewestWeiBoesModel* countrys = [[NewestWeiBoesModel alloc] initWithString:responseObject error:&err];
        if (err) {
            failure(err);
        }else{
            blockObject(countrys);
        }
        
        
        
        
    } failure:^(NSError *error) {
        failure(error);
    }];

}

//获取微博评论
+ (void)weiboCommentWithID:(NSString *)ID  count:(NSString *)count page:(NSString *)page responseObject:(requestData)blockObject failure:(failureError)failure{
    NSDictionary * dic = @{@"source"       : kAppKey,
                           @"access_token" : source_token,
                           @"id"           : ID,
                           @"count"        : count,
                           @"page"         : page};
    
    NSString * urlType = @"comments/show.json";
    
    
    [HTTPRequest packageDatas:dic urlType:urlType responseObject:^(id responseObject) {
                
        NSError * err = nil;
        
        CommentsModel* countrys = [[CommentsModel alloc] initWithString:responseObject error:&err];
        if (err) {
            failure(err);
        }else{
            blockObject(countrys);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}


//获取当前用户发布的微博
+ (void)userSendedWeiboWithID:(NSString *)ID page:(NSString *)page responseObject:(requestData)blockObject failure:(failureError)failure{
    
    //请求消息体
    NSDictionary * dic = @{@"source"      : kAppKey,
                           @"access_token": source_token,
                           @"uid"         : ID,
                           @"page"        : page};
    
    NSString * urlString = @"statuses/user_timeline.json";
    

    [HTTPRequest packageDatas:dic urlType:urlString responseObject:^(id responseObject) {
        
        NSError * error;
        NewestWeiBoesModel * newes = [[NewestWeiBoesModel alloc] initWithString:responseObject error:&error];
        if (error) {
            NSLog(@"%@",error);
            failure(error);
        }else{
            blockObject(newes);/////
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}



















@end
