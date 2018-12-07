//
//  BRNavView.m
//  BalaenicepsRexDemo
//
//  Created by 毕博洋 on 2018/12/7.
//  Copyright © 2018 毕博洋. All rights reserved.
//

#import "BRNavView.h"
#import "UIView+BRLayout.h"

@implementation BRNavView

- (id)init {
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 50, BRScreenWidth - 200, 30)];
    if (_nacTitle)
    {
        titleLabel.text = _nacTitle;
    }
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    UIButton *backButton = [[UIButton alloc]init];
    backButton.backgroundColor = [UIColor blueColor];
    backButton.frame = CGRectMake(0, 40, 60, 40);
    [backButton setTitle:@"back" forState:(UIControlStateNormal)];
    [backButton addTarget:self action:@selector(back:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:backButton];
    
}

- (void)back:(UIButton *)button {
    if (self.backBlock) {
        self.backBlock();
    }
}



@end
