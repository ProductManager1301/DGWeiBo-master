//
//  RootViewController.h
//  DGWeiBo
//
//  Created by 钟伟迪 on 15/5/29.
//  Copyright (c) 2015年 钟伟迪. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;
@protocol RootViewControllerDelegate <NSObject>

@optional
- (void)deSelectedIndexPath:(NSIndexPath *)indexPath withRootViewController:(RootViewController *)rootViewController;

@end
@interface RootViewController : UIViewController

@property (weak , nonatomic)id <RootViewControllerDelegate> delegate;

@end
