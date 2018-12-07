//
//  BRFPSHelper.h
//  BalaenicepsRexDemo
//
//  Created by 毕博洋 on 2018/12/5.
//  Copyright © 2018 毕博洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BRFPSHelper : NSObject

+ (instancetype _Nonnull)sharedHelper;

- (void)start;

- (void)remove;

@end

NS_ASSUME_NONNULL_END
