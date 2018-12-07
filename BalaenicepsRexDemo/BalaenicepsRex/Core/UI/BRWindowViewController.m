//
//  BRWindowViewController.m
//  BalaenicepsRexDemo
//
//  Created by 毕博洋 on 2018/12/5.
//  Copyright © 2018 毕博洋. All rights reserved.
//

#import "BRWindowViewController.h"
#import "UIView+BRLayout.h"


@interface BRWindowViewController ()

@property (nonatomic, strong) UICollectionView *BRCollectionView;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@end

@implementation BRWindowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];

    [self setupCollectionView];

    
}

- (void)setupCollectionView {
    
    
    
    
}







- (void)buttonn:(UIButton *)button {
    if (self.backBlock)
    {
        self.backBlock();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (NSMutableArray *)sourceArray {
    if (!_sourceArray)
    {
        _sourceArray = [NSMutableArray array];
    }
    return _sourceArray;
}




@end
