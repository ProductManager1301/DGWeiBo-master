//
//  UserInfoModel.m
//  DGWeiBo
//
//  Created by 钟伟迪 on 15/5/27.
//  Copyright (c) 2015年 钟伟迪. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

//数据映射
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc]
            initWithDictionary:@{@"description": @"user_description"}];
    return [[JSONKeyMapper alloc]
            initWithDictionary:@{@"id": @"ID"}];
}

@end

#import "DGPackageData.h"
#import "AppDelegate.h"
@implementation UserInfoModel (currentUserInfoModel)

UserInfoModel * ex_userInfo = nil;

@end