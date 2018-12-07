//
//  BRWindowViewController.h
//  BalaenicepsRexDemo
//
//  Created by 毕博洋 on 2018/12/5.
//  Copyright © 2018 毕博洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface BRWindowViewController : UIViewController

@property (nonatomic, copy) void (^backBlock)(void);

@end

NS_ASSUME_NONNULL_END
