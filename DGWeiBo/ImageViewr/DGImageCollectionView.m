//
//  DGImageCollectionView.m
//  ImageViewer
//
//  Created by zhongweidi on 14-8-15.
//  Copyright (c) 2014年 hnqn. All rights reserved.
//

#import "DGImageCollectionView.h"

#import "DGImageCollectionCell.h"

#import "DGImageCollectionLayout.h"

#import "HTTPRequest.h"

@interface DGImageCollectionView()<UITextViewDelegate>{
    BOOL isShowNavigationView;
    CGFloat itemWidth;
    NSUInteger currentIndex;
}

@property (strong ,nonatomic)UIButton * rightBtn;

@property (strong , nonatomic)UITextView * contentTextView;

@property (strong , nonatomic)UIView * contentView;

@end

@implementation DGImageCollectionView

- (id)init{
    CGRect frame = CGRectMake(0, 0, MRScreenWidth, MRScreenHeight);
    return  [self initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame{
    DGImageCollectionLayout * layout  =[[DGImageCollectionLayout alloc] init];
    return [self initWithFrame:frame collectionViewLayout:layout];
}

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
     [(UICollectionViewFlowLayout *)layout setItemSize:frame.size];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.pagingEnabled = YES;
        self.tag = 1000;
        isShowNavigationView = NO;
        itemWidth = [(UICollectionViewFlowLayout*)layout itemSize].width;
        UINib * nib = [UINib nibWithNibName:@"DGImageCollectionCell" bundle:nil];
        [self registerNib:nib forCellWithReuseIdentifier:@"DGImageCollectionCell"];
        [self performSelector:@selector(initUI) withObject:self afterDelay:0.0];
        
    }
    return self;
}

#pragma mark - initWithUI
- (void)initUI{
    [self leftBtn];
}

- (UIView *)collectionNavigationView{
    if (!_collectionNavigationView) {
        _collectionNavigationView = [[UIView alloc] init];
        _collectionNavigationView.backgroundColor = [UIColor blackColor];
        CGRect rect = self.bounds;
        rect.size.height = 64;
        rect.origin.x = 0;
        _collectionNavigationView.frame = rect;
        _collectionNavigationView.alpha = .8;
        [self.superview addSubview:_collectionNavigationView];
        [self.superview bringSubviewToFront:_collectionNavigationView];
        }
    return _collectionNavigationView;
}

- (UILabel *)titleTextLabel{
    if (!_titleTextLabel) {
        _titleTextLabel = [[UILabel alloc] init];
        _titleTextLabel.frame = CGRectMake(0, 0, 200, 22);
        _titleTextLabel.font =[UIFont boldSystemFontOfSize:20];
        _titleTextLabel.textColor = [UIColor whiteColor];
        _titleTextLabel.textAlignment = NSTextAlignmentCenter;
        _titleTextLabel.center = CGPointMake(CGRectGetWidth(self.collectionNavigationView.bounds)/2.0f, CGRectGetHeight(self.collectionNavigationView.bounds)/2.0f+10.f);
        _titleTextLabel.backgroundColor = [UIColor clearColor];
        [self.collectionNavigationView addSubview:_titleTextLabel];
    }
    return _titleTextLabel;
}

- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame =CGRectMake(MRScreenWidth - 70, 30, 60, 24);
        [_rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.collectionNavigationView addSubview:_rightBtn];
    }
    return _rightBtn;
}

- (UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame =CGRectMake(10, 30, 60, 24);
        _leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 36.0f);
        _leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, -30);
        _leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_leftBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_leftBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(popoverImageController) forControlEvents:UIControlEventTouchUpInside];
        [self.collectionNavigationView addSubview:_leftBtn];
    }
    return _leftBtn;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        CGRect rect = self.bounds;
        rect.origin.y = rect.size.height - 100;
        rect.origin.x = 0;
        rect.size.height = 100;
        _contentView.frame = rect;
        _contentView.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:.8];
        [self.superview addSubview:_contentView];
    }
    return _contentView;
}


- (UITextView *)contentTextView{
    if (!_contentTextView) {
        _contentTextView = [[UITextView alloc] init];
        _contentTextView.backgroundColor = [UIColor clearColor];
        CGRect rect = self.contentView.bounds;
        rect.size.width -= 10;
        rect.origin.x += 5;
        _contentTextView.frame = rect;
        _contentTextView.delegate = self;
        [self.contentView  addSubview:_contentTextView];
    }
    return _contentTextView;
}

- (void)setContentText:(NSString *)contentText{
    _contentText = contentText;
    self.contentTextView.attributedText = [self textViewAttributedString:contentText];
}

- (void)setLeftImage:(UIImage *)leftImage{
    _leftImage = leftImage;
    CGFloat imageWidth = CGImageGetWidth(leftImage.CGImage);
    CGFloat imageHeight = CGImageGetWidth(leftImage.CGImage);
    CGFloat titleEdgeLeft = 24.0f*(imageHeight/imageWidth) - 24.0f;
     self.leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 60.0f - 24.0f*(imageHeight/imageWidth));
    _leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30-titleEdgeLeft, 0, -30-titleEdgeLeft);
    [self.leftBtn setImage:leftImage forState:UIControlStateNormal];
}

- (void)setLeftTitle:(NSString *)leftTitle{
    _leftTitle = leftTitle;
    [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
}

- (void)popoverImageController{
    [(UINavigationController *)self.getCurrentRootViewController popViewControllerAnimated:YES];
}

- (void)rightBtnAction:(UIButton *)sender{

}

- (void)imageCollectionViewRightImage:(UIImage *)image target:(id)object SELAction:(SEL)sel{
    [self.rightBtn removeTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setImage:image forState:UIControlStateNormal];
     [self.rightBtn addTarget:object action:sel forControlEvents:UIControlEventTouchUpInside];
}

- (void)imageCollectionViewRightTitle:(NSString *)text target:(id)object SELAction:(SEL)sel{
    [self.rightBtn removeTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setTitle:text forState:UIControlStateNormal];
    [self.rightBtn addTarget:object action:sel forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelectIndex:(NSInteger)selectIndex{
    currentIndex = selectIndex;
    self.contentOffset = CGPointMake(currentIndex*itemWidth, 0);
    [self.superview bringSubviewToFront:self.collectionNavigationView];
    [self performSelector:@selector(delegateResponder) withObject:nil afterDelay:0.0];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  self.images? self.images.count: self.imagePahts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifierString = @"DGImageCollectionCell";
    DGImageCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifierString forIndexPath:indexPath];
    [cell.itemScrollView setZoomScale:1.0 animated:NO];
    if (self.imagePahts) {
        [cell.itemScrollView.activityView startAnimating];
        if (self.bufferingImage)  cell.itemScrollView.imageView.image  = self.bufferingImage;
        else cell.itemScrollView.imageView.image = [UIImage imageNamed:@"bufferingImage.jpg"];
        [HTTPRequest downLoadImage:self.imagePahts[indexPath.row] qualityRatio:0.5 pixelRatio:1.0 responseObject:^(id responseObject) {
            cell.itemScrollView.imageView.image = responseObject;
            [cell.itemScrollView.activityView stopAnimating];
        } failure:^(NSError *error, NSString *pathString) {
            if (self.errorImage) cell.itemScrollView.imageView.image =  self.errorImage;
            else cell.itemScrollView.imageView.image = [UIImage imageNamed:@"errorImage.jpg"];
            [cell.itemScrollView.activityView stopAnimating];
        }];
    }else if(self.images){
       cell.itemScrollView.imageView.image = self.images[indexPath.row];
        if (cell.itemScrollView.activityView.isAnimating)
            [cell.itemScrollView.activityView stopAnimating];
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.tag == 1000) {
         self.contentTextView.contentOffset = CGPointMake(0.0f, 0.0f);
        NSUInteger index = scrollView.contentOffset.x/itemWidth;
        currentIndex= index;
        [self delegateResponder];
    }
}

- (void)delegateResponder{
    if ([self.imageCotDelegate respondsToSelector:@selector(currentImageCollectionItemScrolling:index:)]) {
        [self.imageCotDelegate currentImageCollectionItemScrolling:self index:currentIndex];
    }

}


#pragma mark - UITextViewDelegate 
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}

#pragma mark - Super overwrite function
- (void)dismissImageViewerView:(MRZoomScrollView *)zoomScrollView{
    if ([self.superview respondsToSelector:@selector(dismissImageViewerView:)]) {
        [self.superview dismissImageViewerView:zoomScrollView];
    }
    
    if ([self.imageCotDelegate respondsToSelector:@selector(currentImageCollectionItem:index:)]) {
        [self.imageCotDelegate currentImageCollectionItem:self index:currentIndex];
    }
    
    self.collectionNavigationView.alpha = isShowNavigationView ? 0.0: 0.8;
    self.contentView.alpha = isShowNavigationView ? 0.0: 0.8;
    
    [UIView animateWithDuration:0.6 animations:^{
    self.collectionNavigationView.alpha = isShowNavigationView ? 0.8: 0.0;
    self.contentView.alpha = isShowNavigationView ? 0.8: 0.0;
        
    } completion:^(BOOL finished) {
        if (isShowNavigationView) {
            isShowNavigationView = NO;
            self.collectionNavigationView.userInteractionEnabled = YES;
            self.contentView.userInteractionEnabled = YES;
        }else {
            isShowNavigationView = YES;
            self.collectionNavigationView.userInteractionEnabled = NO;
            self.contentView.userInteractionEnabled = YES;
        }
        
    }];
}

#pragma mark - Text NSMutableAttributedString
- (NSMutableAttributedString *)textViewAttributedString:(NSString *)string{
    
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:string];
    
    //设置行间距对象
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5.0f;
    paragraphStyle.paragraphSpacing =10.0f;
    paragraphStyle.alignment =NSTextAlignmentJustified;
    //设置字体属性
    NSDictionary *refreshAttributesFirst =
    @{NSForegroundColorAttributeName : [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f],
      NSFontAttributeName : [UIFont systemFontOfSize:14.0f],
      NSParagraphStyleAttributeName : paragraphStyle, //行间距
      NSKernAttributeName : [NSNumber numberWithDouble:1.0f]}; //字间距
    [attriString setAttributes:refreshAttributesFirst range:NSMakeRange(0, attriString.length)];
    
    return attriString;
}

//获取当前的controller
- (UIViewController *)getCurrentRootViewController {
    
    UIViewController *result;
    
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    if (topWindow.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(topWindow in windows)
        {
            if (topWindow.windowLevel == UIWindowLevelNormal)
                break;
        }
    }
    
    UIView *rootView = [[topWindow subviews] objectAtIndex:0];
    id nextResponder = [rootView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else if ([topWindow respondsToSelector:@selector(rootViewController)] && topWindow.rootViewController != nil)
        result = topWindow.rootViewController;
    else
        NSAssert(NO, @"获取错误");
    return result;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
