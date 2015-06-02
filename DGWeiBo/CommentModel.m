//
//  CommentModel.m
//  DGWeiBo
//
//  Created by 钟伟迪 on 15/5/31.
//  Copyright (c) 2015年 钟伟迪. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentsModel


@end

@implementation CommentModel

//数据映射
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc]
            initWithDictionary:@{@"id": @"ID"}];
}

@end
