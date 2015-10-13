//
//  MQImageScrollView.h
//  MQImageScrollView
//
//  Created by WsdlDev on 15/10/10.
//  Copyright © 2015年 mazengyi. All rights reserved.
//

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
