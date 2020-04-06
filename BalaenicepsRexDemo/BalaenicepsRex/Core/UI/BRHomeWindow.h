//
//  BRHomeWindow.h
//  BalaenicepsRexDemo
//
//  Created by 毕博洋 on 2020/4/6.
//  Copyright © 2020 毕博洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BRHomeWindow : UIWindow

@property (nonatomic, strong) UINavigationController *nav;

+ (BRHomeWindow *)shareInstance;

- (void)openPlugin:(UIViewController *)vc;

- (void)show;

- (void)hide;


@end

NS_ASSUME_NONNULL_END
