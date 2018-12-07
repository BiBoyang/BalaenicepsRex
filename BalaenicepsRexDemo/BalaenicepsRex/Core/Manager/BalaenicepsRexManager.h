//
//  BalaenicepsRexManager.h
//  BalaenicepsRexDemo
//
//  Created by 毕博洋 on 2018/12/5.
//  Copyright © 2018 毕博洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BalaenicepsRexManager : NSObject


// Singleton
+ (instancetype)shareBalaenicepsRex;

@property (nonatomic, strong) NSMutableArray *allPluginArray;


//install
- (void)startBalaenicepsRex;

//stop
- (void)stopBalaenicepsRex;

//cancel
- (void)cancelBalaenicepsRex;

@end

NS_ASSUME_NONNULL_END
