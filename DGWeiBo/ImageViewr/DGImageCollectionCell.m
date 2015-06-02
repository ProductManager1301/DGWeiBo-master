//
//  DGImageCollectionCell.m
//  ImageViewer
//
//  Created by zhongweidi on 14-8-15.
//  Copyright (c) 2014年 hnqn. All rights reserved.
//

#import "DGImageCollectionCell.h"

@implementation DGImageCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dismissImageViewerView:(MRZoomScrollView *)zoomScrollView{
    UIView * view = self.superview;
    while (view) {
        if ([view respondsToSelector:@selector(dismissImageViewerView:)]) {
            [view dismissImageViewerView:zoomScrollView];
            break;
        }
        view = view.superview;
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}


@end
