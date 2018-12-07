//
//  ViewController.m
//  BalaenicepsRexDemo
//
//  Created by 毕博洋 on 2018/12/5.
//  Copyright © 2018 毕博洋. All rights reserved.
//

#import "ViewController.h"

#import "BRViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor greenColor];
    
    
    [self setupView];
    
}

- (void)setupView {
    
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:@"push" forState:(UIControlStateNormal)];
    button.frame = CGRectMake(100, 200, 200, 200);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(pushViewController:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
}

- (void)pushViewController:(UIButton *)button {
    
    BRViewController *vc = [[BRViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}





@end
