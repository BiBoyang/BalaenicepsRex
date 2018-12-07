//
//  BRViewController.m
//  BalaenicepsRexDemo
//
//  Created by 毕博洋 on 2018/12/5.
//  Copyright © 2018 毕博洋. All rights reserved.
//

#import "BRViewController.h"

@interface BRViewController ()

@property (nonatomic, strong) NSMutableString *string;

@property (nonatomic, copy)void (^block)(void);

@end

@implementation BRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor redColor];
    
    self.string = [[NSString stringWithFormat:@"aaa"]mutableCopy];
    
    self.block = ^{
        self.string = [[NSString stringWithFormat:@"bbb"]mutableCopy];
    };
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
