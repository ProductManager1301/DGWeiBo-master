//
//  HeadUserInfoCell.m
//  DGWeiBo
//
//  Created by 钟伟迪 on 15/5/30.
//  Copyright (c) 2015年 钟伟迪. All rights reserved.
//

#import "HeadUserInfoCell.h"

@implementation HeadUserInfoCell

- (void)awakeFromNib{
    self.headerImageView.layer.masksToBounds = YES;
    self.headerImageView.layer.cornerRadius = CGRectGetHeight(self.headerImageView.frame)/2.0f;
}



@end
