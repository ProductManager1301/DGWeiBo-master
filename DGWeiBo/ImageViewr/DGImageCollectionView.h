//
//  DGImageCollectionView.h
//  ImageViewer
//
//  Created by zhongweidi on 14-8-15.
//  Copyright (c) 2014年 hnqn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DGImageCollectionView;
@class MRZoomScrollView;
@protocol DGImageCollectionViewDelegate <NSObject>
@optional
- (void)currentImageCollectionItem:(DGImageCollectionView *)imageCollectionView index:(NSUInteger)index;

- (void)currentImageCollectionItemScrolling:(DGImageCollectionView *)imageCollectionView index:(NSUInteger)index;

@end

@interface DGImageCollectionView : UICollectionView<UICollectionViewDataSource , UICollectionViewDelegate>

- (id)initWithFrame:(CGRect)frame;

- (id)init;

@property (weak , nonatomic) id<DGImageCollectionViewDelegate>imageCotDelegate;

@property (strong ,nonatomic)UILabel * titleTextLabel;

@property (strong , nonatomic)UIView * collectionNavigationView;

@property (strong , nonatomic)UIButton * leftBtn;

@property (strong , nonatomic)NSString * leftTitle;

@property (strong ,nonatomic)UIImage * leftImage;

@property (strong , nonatomic)NSString * contentText;

@property (strong , nonatomic)NSArray * imagePahts;//图片资源的显示路径

@property (strong , nonatomic)NSArray * images;//所需显示的所有图片,Obj为UIImage对象

@property (assign ,nonatomic)NSInteger selectIndex;//指定跳到第几行

@property (strong , nonatomic)UIImage * bufferingImage;//加载时的缓冲图片

@property (strong , nonatomic)UIImage * errorImage;//加载图片失败时显示errorImage

- (void)imageCollectionViewRightImage:(UIImage *)image target:(id)object SELAction:(SEL)sel;

- (void)imageCollectionViewRightTitle:(NSString *)text target:(id)object SELAction:(SEL)sel;

@end
