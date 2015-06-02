//
//  CommentTableVIewCell.m
//  DGWeiBo
//
//  Created by 钟伟迪 on 15/5/31.
//  Copyright (c) 2015年 钟伟迪. All rights reserved.
//

#import "CommentTableVIewCell.h"


@implementation CommentTableVIewCell

- (void)awakeFromNib{
    _contentTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 280, 40)];
    _contentTextLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_contentTextLabel];
    _contentTextLabel.numberOfLines = 0;
    
    
    [_contentTextLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    _headerImageView.layer.masksToBounds = YES;
    _headerImageView.layer.cornerRadius = CGRectGetHeight(_headerImageView.frame)/2.0f;
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
        CGRect rect = [self.contentTextLabel.text boundingRectWithSize:CGSizeMake(_contentTextLabel.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : _contentTextLabel.font} context:nil];
        
        CGRect contentTextRect = _contentTextLabel.frame;
        contentTextRect.size = rect.size;
        _contentTextLabel.frame = contentTextRect;
        
        CGRect myRect = self.frame;
        myRect.size.height = contentTextRect.size.height + 90.0f;
        self.frame = myRect;
    
}

- (void)setCreateDate:(NSString *)createDate{
    _createDate = createDate;
    NSArray * strings = [createDate componentsSeparatedByString:@" "];
    if (strings.count >=4) {
        _timeLabel.text = [NSString stringWithFormat:@"%@",strings[3]];
    }
}

- (void)dealloc{
    [_contentTextLabel removeObserver:self forKeyPath:@"text"];
}



@end
