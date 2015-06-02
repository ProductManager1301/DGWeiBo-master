//
//  DGImageCollectionCell.h
//  ImageViewer
//
//  Created by zhongweidi on 14-8-15.
//  Copyright (c) 2014年 hnqn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRZoomScrollView.h"

@interface DGImageCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet MRZoomScrollView *itemScrollView; 
@end
