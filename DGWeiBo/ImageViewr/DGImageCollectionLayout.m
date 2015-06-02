//
//  DGImageCollectionLayout.m
//  ImageViewer
//
//  Created by zhongweidi on 14-8-16.
//  Copyright (c) 2014年 hnqn. All rights reserved.
//

#import "DGImageCollectionLayout.h"

@implementation DGImageCollectionLayout

- (id)init{
    self =[super init];
    if (self) {
        self.sectionInset =UIEdgeInsetsMake(0, 0, 0, 0);
        self.minimumLineSpacing=0.0f;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *array =[super layoutAttributesForElementsInRect:rect];
    return array;
}

@end
