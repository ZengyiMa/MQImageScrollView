//
//
//  Copyright (c) 2015 mazengyi https://github.com/semazengyi/MQImageScrollView
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <UIKit/UIKit.h>


/**
 *  @brief  图片轮播器
 */
@interface MQImageScrollView : UIView


///底部的pageControl
@property (nonatomic, strong, readonly)UIPageControl *pageControl;

///选择图片的回调
@property (nonatomic, copy) void (^selectedBlock)(NSUInteger index);

/**
 *  @brief  将图片展示在轮播器上
 *
 *  @param images       要显示的图片数组
 *  @param timeInterval 切换的时间(秒)
 */
- (void)showImages:(NSArray *)images ChangePageInterval:(CGFloat)timeInterval;
@end
