//
//  BRFPSHelper.m
//  BalaenicepsRexDemo
//
//  Created by 毕博洋 on 2018/12/5.
//  Copyright © 2018 毕博洋. All rights reserved.
//

#import "BRFPSHelper.h"
#import <QuartzCore/QuartzCore.h>



static BRFPSHelper *_instance = nil;

@interface BRFPSHelper ()

@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, assign) float fps;
@property (nonatomic, assign) NSTimeInterval lastTime;
@property (nonatomic, assign) NSUInteger count;

@end

@implementation BRFPSHelper

+ (instancetype)sharedHelper {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[BRFPSHelper alloc] init];
        [_instance initial];
    });
    return _instance;
}


- (void)initial {
    _fps = 60;
}

- (void)start {

    [self remove];

    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(fpsDisplayLinkAction:)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)remove {
    if (_link)
    {
        [_link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        [_link invalidate];
        _link = nil;
    }
}

- (void)fpsDisplayLinkAction:(CADisplayLink *)link {
    if (_lastTime == 0)
    {
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    _fps = _count / delta;
    _count = 0;
    
    NSLog(@"_____%f",_fps);
}



@end
