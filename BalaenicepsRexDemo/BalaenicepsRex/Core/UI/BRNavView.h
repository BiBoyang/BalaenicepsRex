//
//  BRNavView.h
//  BalaenicepsRexDemo
//
//  Created by 毕博洋 on 2018/12/7.
//  Copyright © 2018 毕博洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BRNavView : UIView

@property (nonatomic, strong) UILabel *titleLalebl;

@property (nonatomic, copy) NSString *nacTitle;

@property (nonatomic, copy) void(^backBlock)(void);


@end

NS_ASSUME_NONNULL_END
