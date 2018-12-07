//
//  UIView+BRLayout.h
//  BalaenicepsRexDemo
//
//  Created by 毕博洋 on 2018/12/5.
//  Copyright © 2018 毕博洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define BRScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define BRScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface UIView (BRLayout)

@property (nonatomic, assign) CGFloat   x;

@property (nonatomic, assign) CGFloat   y;

@property (nonatomic, assign) CGFloat   width;

@property (nonatomic, assign) CGFloat   height;

@property (nonatomic, assign) CGPoint   origin;

@property (nonatomic, assign) CGSize    size;

@property (nonatomic, assign) CGFloat   bottom;

@property (nonatomic, assign) CGFloat   right;

@property (nonatomic, assign) CGFloat   left;

@property (nonatomic, assign) CGFloat   top;

@property (nonatomic, assign) CGFloat   centerX;

@property (nonatomic, assign) CGFloat   centerY;


@end

NS_ASSUME_NONNULL_END
