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
    [self.BRWindow makeKeyAndVisible];
}

- (void)initData {
    
    
    [self addPluginNameWith:@"App信息" pluginClassName:@"appInfo" ModuleName:@"基本操作"];
    [self addPluginNameWith:@"沙盒信息" pluginClassName:@"SandBox" ModuleName:@"基本操作"];
    [self addPluginNameWith:@"H5测试" pluginClassName:@"H5" ModuleName:@"基本操作"];
    [self addPluginNameWith:@"内存泄漏" pluginClassName:@"MemoryLeak" ModuleName:@"基本操作"];
    
}

- (void)addPluginNameWith:(NSString *)pluginName pluginClassName:(NSString *)className ModuleName:(NSString *)moduleName {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:pluginName forKey:@"pluginName"];
    [dic setValue:className forKey:@"className"];
//    [dic setValue:moduleName forKey:@"moduleName"];
    
    
    
    NSMutableArray *pluginArray = [[NSMutableArray alloc] initWithObjects:dic, nil];
    [self addPluginWith:pluginArray withModuleName:nil];
}




- (void)addPluginWith:(NSMutableArray *)mutableArray withModuleName:(NSString *)name {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:mutableArray forKey:@"pluginDescArray"];
//    [dic setValue:name forKey:@"moduleName"];
    [self.allPluginArray addObject:dic];
    
        
    
}

- (NSMutableArray *)allPluginArray {
    if (!_allPluginArray) {
        _allPluginArray = [NSMutableArray new];
    }
    return _allPluginArray;
}





@end
