//
//  AppDelegate.h
//  DGWeiBo
//
//  Created by 钟伟迪 on 15/5/26.
//  Copyright (c) 2015年 钟伟迪. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kAppKey         @"141240461"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *wbtoken;  //密匙
@property (strong, nonatomic) NSString *wbCurrentUserID;  //当前登录用户的ID

@end

