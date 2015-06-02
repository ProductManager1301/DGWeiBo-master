//
//  CommentTableVIewCell.h
//  DGWeiBo
//
//  Created by 钟伟迪 on 15/5/31.
//  Copyright (c) 2015年 钟伟迪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableVIewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (strong ,nonatomic)UILabel * contentTextLabel;//内容

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *floorLabel;

@property (strong ,nonatomic)NSString * createDate;
@end
