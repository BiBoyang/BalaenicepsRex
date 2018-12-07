//
//  BalaenicepsRexManager.m
//  BalaenicepsRexDemo
//
//  Created by 毕博洋 on 2018/12/5.
//  Copyright © 2018 毕博洋. All rights reserved.
//

#import "BalaenicepsRexManager.h"
#import "BRWindowView.h"
#import "BRFPSHelper.h"

static BalaenicepsRexManager *_instance;

@interface BalaenicepsRexManager ()

@property (nonatomic, strong) BRWindowView *BRWindow;

@end

@implementation BalaenicepsRexManager

// Singleton
+ (instancetype)shareBalaenicepsRex {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[BalaenicepsRexManager alloc]init];
        [_instance install];
    });
    return _instance;
}

- (void)startBalaenicepsRex {
    
    NSLog(@"start BalaenicepsRex");
        
    [self initData];
}

- (void)stopBalaenicepsRex {
    
    
    
    
}

- (void)cancelBalaenicepsRex {
    
    
}

- (void)install {

    self.BRWindow = [[BRWindowView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    //这里是为了延迟加载，防止UIWindow冲突
    //Application windows are expected to have a root view controller at the end of application launch
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.BRWindow makeKeyAndVisible];
//    });
    [self.BRWindow makeKeyAndVisible];

//    [[BRFPSHelper sharedHelper]start];
    
    
}

- (void)initData {
    
    
    [self addPluginNameWith:@"App信息" pluginClassName:@"appInfo" ModuleName:nil];
    [self addPluginNameWith:@"沙盒信息" pluginClassName:@"SandBox" ModuleName:nil];
    [self addPluginNameWith:@"H5测试" pluginClassName:@"H5" ModuleName:nil];
    [self addPluginNameWith:@"内存泄漏" pluginClassName:@"MemoryLeak" ModuleName:nil];
    
}

- (void)addPluginNameWith:(NSString *)pluginName pluginClassName:(NSString *)className ModuleName:(NSString *)moduleName {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:pluginName forKey:@"pluginName"];
    [dic setValue:className forKey:@"className"];
//    [dic setValue:moduleName forKey:@"moduleName"];
    
    
    
    NSMutableArray *pluginArray = [[NSMutableArray alloc] initWithObjects:dic, nil];
    [self addPluginWith:pluginArray withModuleName:@"BR"];
}




- (void)addPluginWith:(NSMutableArray *)mutableArray withModuleName:(NSString *)name {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:mutableArray forKey:@"pluginDescArray"];
    [dic setValue:name forKey:@"moduleName"];
    [self.allPluginArray addObject:dic];
    
    NSLog(@"________%@",self.allPluginArray);
    
}

- (NSMutableArray *)allPluginArray {
    if (!_allPluginArray) {
        _allPluginArray = [NSMutableArray new];
    }
    return _allPluginArray;
}





@end
