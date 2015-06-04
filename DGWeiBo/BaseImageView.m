//
//  BaseImageView.m
//  DGWeiBo
//
//  Created by 钟伟迪 on 15/6/4.
//  Copyright (c) 2015年 钟伟迪. All rights reserved.
//

#import "BaseImageView.h"

@implementation BaseImageView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.image = [UIImage imageNamed:@"DGDefault"];
    }
    return self;
}

- (void)awakeFromNib{
    self.image = [UIImage imageNamed:@"DGDefault"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
