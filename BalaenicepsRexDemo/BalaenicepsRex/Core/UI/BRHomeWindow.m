//
//  BRHomeWindow.m
//  BalaenicepsRexDemo
//
//  Created by 毕博洋 on 2020/4/6.
//  Copyright © 2020 毕博洋. All rights reserved.
//

#import "BRHomeWindow.h"
#import "UIView+BRLayout.h"
#import "BRWindowViewController.h"


@implementation BRHomeWindow

+ (BRHomeWindow *)shareInstance{
    static dispatch_once_t once;
    static BRHomeWindow *instance;
    dispatch_once(&once, ^{
        instance = [[BRHomeWindow alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    });
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = UIWindowLevelStatusBar + 50.f;
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
    }
    return self;
}

- (void)openPlugin:(UIViewController *)vc{
    [self setRootVc:vc];
}

- (void)show{
    BRWindowViewController *vc = [[BRWindowViewController alloc] init];
    [self setRootVc:vc];
    
    self.hidden = NO;
}

- (void)hide{
    [self setRootVc:nil];
    
    self.hidden = YES;
}

- (void)setRootVc:(UIViewController *)rootVc{
    if (rootVc) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootVc];
        NSDictionary *attributesDic = @{
                                        NSForegroundColorAttributeName:[UIColor blackColor],
                                        NSFontAttributeName:[UIFont systemFontOfSize:18]
                                        };
        [nav.navigationBar setTitleTextAttributes:attributesDic];
        _nav = nav;
        
        self.rootViewController = nav;
    }else{
        self.rootViewController = nil;
    }

}


@end
