//
//  MQImageScrollView.m
//  MQImageScrollView
//
//  Created by WsdlDev on 15/10/10.
//  Copyright © 2015年 mazengyi. All rights reserved.
//

#import "MQImageScrollView.h"

@interface MQImageScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView* imagesContainer;
@property (nonatomic, strong) NSMutableArray<UIImageView*>* imageViews;
@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic, assign) CGFloat timeInterval;
@property (nonatomic, strong) UIPageControl* pageControl;
@property (nonatomic, copy) NSArray<UIImage *>* images;

@end

@implementation MQImageScrollView {
    CGFloat _rightEnd;
    NSUInteger _pageIndex;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder*)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - public
- (void)showImages:(NSArray *)images ChangePageInterval:(CGFloat)timeInterval
{
    if (_imagesContainer == nil && images == nil) {
        return;
    }
    
   
    self.images = images;
    self.pageControl.numberOfPages = self.images.count;
    self.pageControl.currentPage = 0;
    self.timeInterval = timeInterval;
     //回归最初状态
    _pageIndex = 0;
    [_timer invalidate];
    _timer = nil;
    [self showImagesWithCurrentPageIndex:_pageIndex];
    [self.imagesContainer setContentOffset:CGPointMake(self.bounds.size.width, 0)];
    self.timer.fireDate = [NSDate dateWithTimeIntervalSince1970:[NSDate date].timeIntervalSince1970 + timeInterval];
}

#pragma mark - private
- (void)commonInit
{
    _rightEnd = self.bounds.size.width * 2;
    self.imagesContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.imagesContainer];
    //加约束
    [self addConstraints:@[
        [NSLayoutConstraint constraintWithItem:_imagesContainer
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1
                                      constant:0],
        [NSLayoutConstraint constraintWithItem:_imagesContainer
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1
                                      constant:0],
        [NSLayoutConstraint constraintWithItem:_imagesContainer
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1
                                      constant:0],
        [NSLayoutConstraint constraintWithItem:_imagesContainer
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1
                                      constant:0]
    ]];

    ///uiimageview 的创建
    for (NSUInteger i = 0; i < 3; ++i) {
        UIImageView* imageview = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
        imageview.tag = i - 1;
        imageview.userInteractionEnabled = YES;
        
        [imageview addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHandler:)]];
        [self.imagesContainer addSubview:imageview];
        [self.imageViews addObject:imageview];
    }
    [self.imagesContainer setContentSize:CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height)];
    //pageControl
    self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.pageControl];

    //加约束
    [self addConstraints:@[

        [NSLayoutConstraint constraintWithItem:_pageControl
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1
                                      constant:-10.],
        [NSLayoutConstraint constraintWithItem:_pageControl
                                     attribute:NSLayoutAttributeCenterX
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeCenterX
                                    multiplier:1
                                      constant:0]
    ]];
}

- (void)showImagesWithCurrentPageIndex:(NSUInteger)pageIndex
{
    __weak typeof(self) weakSelf = self;
    [self.imageViews enumerateObjectsUsingBlock:^(UIImageView* _Nonnull obj, NSUInteger idx, BOOL* _Nonnull stop) {
        obj.image = weakSelf.images[[weakSelf getNextPageIndexWithCurrentIndex:_pageIndex + idx - 1]];
    }];
}

- (NSUInteger)getNextPageIndexWithCurrentIndex:(NSInteger)currentIndex
{
    if (currentIndex < 0) {
        return self.images.count - 1;
    }
    else if (currentIndex == self.images.count) {
        return 0;
    }
    else {
        return currentIndex;
    }
}

#pragma mark - scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    if (scrollView.contentOffset.x >= _rightEnd) {
        _pageIndex = [self getNextPageIndexWithCurrentIndex:_pageIndex + 1];
        [self showImagesWithCurrentPageIndex:_pageIndex];
        [self.imagesContainer setContentOffset:CGPointMake(self.frame.size.width, 0)];
    }
    else if (scrollView.contentOffset.x <= 0) {
        _pageIndex = [self getNextPageIndexWithCurrentIndex:_pageIndex - 1];
        [self showImagesWithCurrentPageIndex:_pageIndex];
        [self.imagesContainer setContentOffset:CGPointMake(self.frame.size.width, 0)];
    }
    self.pageControl.currentPage = _pageIndex;
}

- (void)scrollViewWillBeginDragging:(UIScrollView*)scrollView
{
    self.timer.fireDate = [NSDate distantFuture];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    self.timer.fireDate = [NSDate dateWithTimeIntervalSince1970:[NSDate date].timeIntervalSince1970 + _timeInterval];
    [self.imagesContainer setContentOffset:CGPointMake(self.frame.size.width, 0)];

}

#pragma mark - selector
- (void)changePage
{
    [self.imagesContainer setContentOffset:CGPointMake(2 * self.bounds.size.width, 0) animated:YES];
}

- (void)tapHandler:(UITapGestureRecognizer *)ges
{
//    NSLog(@"选择了图片是：%lu", _pageIndex + ges.view.tag);
    if (_selectedBlock) {
        _selectedBlock(_pageIndex + ges.view.tag);
    }
}

#pragma mark - getter
- (UIScrollView*)imagesContainer
{
    if (_imagesContainer == nil) {
        _imagesContainer = [[UIScrollView alloc] init];
        _imagesContainer.delegate = self;
        _imagesContainer.pagingEnabled = YES;
        _imagesContainer.showsHorizontalScrollIndicator = NO;
    }
    return _imagesContainer;
}

- (NSMutableArray<UIImageView*>*)imageViews
{
    if (_imageViews == nil) {
        _imageViews = [NSMutableArray array];
    }
    return _imageViews;
}

- (NSTimer*)timer
{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(changePage) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (UIPageControl*)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
    }
    return _pageControl;
}

@end
