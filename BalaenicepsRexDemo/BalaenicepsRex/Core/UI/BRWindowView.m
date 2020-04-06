//
//  BRWindowView.m
//  BalaenicepsRexDemo
//
//  Created by 毕博洋 on 2018/12/5.
//  Copyright © 2018 毕博洋. All rights reserved.
//

#import "BRWindowView.h"
#import "BRWindowViewController.h"
#import "BRHomeWindow.h"
#import "BRMacros.h"
#import "UIView+BRLayout.h"
#import <mach/mach.h>


static CGFloat const kEntryViewSize = 50;

@interface BRWindowView ()

@property (nonatomic, strong) UIView *entryView;
@property (nonatomic, strong) UILabel *FPSLabel;
@property (nonatomic, strong) UILabel *CPULabel;

@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, assign) float fps;
@property (nonatomic, assign) NSTimeInterval lastTime;
@property (nonatomic, assign) NSUInteger count;

@property (nonatomic , strong) NSTimer *CPUTimer;
 
@end
@implementation BRWindowView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
        [self start];
        [self CPUTest];
    }
    return self;
}

- (void)setUpView {
    
    self.windowLevel = UIWindowLevelAlert + 5;
    if (!self.rootViewController) {
        self.rootViewController = [[UIViewController alloc] init];
    }
    
    self.entryView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, 50, 50)];
    self.entryView.backgroundColor = [UIColor whiteColor];
    [self.rootViewController.view addSubview:self.entryView];
    
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panEntryView:)];
    [self addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapEntryView:)];
    [self addGestureRecognizer:tap];
    
//    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTapEntryView:)];
//    [self addGestureRecognizer:doubleTap];
    
    
    // Create CPULabel
    self.CPULabel.frame = CGRectMake(0, 0, 50, 20);
    self.CPULabel.backgroundColor = [UIColor redColor];
    [self.entryView addSubview:self.CPULabel];
    
    // Create FPSLabel
    self.FPSLabel.frame = CGRectMake(0, 30, 50, 20);
    self.FPSLabel.backgroundColor = [UIColor redColor];
    [self.entryView addSubview:self.FPSLabel];
    
}

- (void)panEntryView:(UIPanGestureRecognizer *)pan {

    CGPoint offsetPoint = [pan translationInView:pan.view];
    [pan setTranslation:CGPointZero inView:pan.view];
    UIView *panView = pan.view;
    CGFloat newX = panView.center.x + offsetPoint.x;
    CGFloat newY = panView.center.y + offsetPoint.y;
    
    if (newX < kEntryViewSize / 2) {
        newX = kEntryViewSize / 2;
    } else if (newX > [UIScreen mainScreen].bounds.size.width + kEntryViewSize / 2) {
        newX = [UIScreen mainScreen].bounds.size.width + kEntryViewSize / 2;
    }

    if (newY < kEntryViewSize / 2) {
        newY = kEntryViewSize / 2;
    } else if (newY > [UIScreen mainScreen].bounds.size.height + kEntryViewSize / 2) {
        newY = [UIScreen mainScreen].bounds.size.height + kEntryViewSize / 2;
    }

    panView.center = CGPointMake(newX, newY);
}

- (void)tapEntryView:(UITapGestureRecognizer *)tap {
    
//    [self hideWindow];
//    UIViewController *vc = [[[UIApplication sharedApplication].delegate window] rootViewController];
//    BRWindowViewController *controller = [[BRWindowViewController alloc]init];
//    controller.backBlock = ^{
//        [self showWindow];
//    };
//    [vc presentViewController:controller animated:YES completion:nil];
    
    if([BRHomeWindow shareInstance].hidden) {
        [[BRHomeWindow shareInstance] show];
    } else {
        [[BRHomeWindow shareInstance] hide];
    }
    
    
}

- (void)doubleTapEntryView:(UITapGestureRecognizer *)tap {
    
    
    
}



- (void)showWindow {
    if (self.isHidden) {
        if ([[NSThread currentThread] isMainThread]){
            self.hidden = NO;
        } else {
            [self performSelectorOnMainThread:@selector(showWindow) withObject:nil waitUntilDone:YES];
        }
    }
}

- (void)hideWindow {
    if (self.isHidden == NO) {
        if ([[NSThread currentThread] isMainThread]) {
            self.hidden = YES;
        } else {
            [self performSelectorOnMainThread:@selector(hideWindow) withObject:nil waitUntilDone:YES];
        }
    }
}

#pragma mark-----FPS
- (void)start {
    [self remove];
    self.CPUTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(CPUTimerAction:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.CPUTimer forMode:NSRunLoopCommonModes];
    [self.CPUTimer fire];
    
    
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(fpsDisplayLinkAction:)];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)remove {
    if (self.CPUTimer) {
        [self.CPUTimer invalidate];
        self.CPUTimer = nil;
    }
    if (self.link) {
        [self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        [self.link invalidate];
        self.link = nil;
    }
}

- (void)fpsDisplayLinkAction:(CADisplayLink *)link {
    if (self.lastTime == 0) {
        self.lastTime = link.timestamp;
        return;
    }
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    self.lastTime = link.timestamp;
    self.fps = _count / delta;
    self.count = 0;
    self.FPSLabel.text = [NSString stringWithFormat:@"FPS：%.1f",_fps];
}

#pragma mark-----CPU
- (void)CPUTimerAction:(NSTimer *)timer {
    [self CPUTest];
}

- (void)CPUTest {
    kern_return_t kr;
    task_info_data_t tinfo;
    mach_msg_type_number_t task_info_count;
    
    task_info_count = TASK_INFO_MAX;
    //获取当前任务，即当前的进程信息
    kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    if (kr != KERN_SUCCESS) {
        return;
    }
    task_basic_info_t      basic_info;
    thread_array_t         thread_list;
    mach_msg_type_number_t thread_count;
    thread_info_data_t     thinfo;
    mach_msg_type_number_t thread_info_count;
    thread_basic_info_t basic_info_th;
    uint32_t stat_thread = 0; // Mach threads
    basic_info = (task_basic_info_t)tinfo;
    // get threads in the task
    //  获取当前进程中 线程列表
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS) {
        return;
    }
    if (thread_count > 0) {
        stat_thread += thread_count;
    }
    long tot_sec = 0;
    long tot_usec = 0;
    float tot_cpu = 0;
    int j;
    
    for (j = 0; j < thread_count; j++) {
        thread_info_count = THREAD_INFO_MAX;
        //获取每一个线程信息
        kr = thread_info(thread_list[j], THREAD_BASIC_INFO,
                         (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS) {
            return;
        }
        basic_info_th = (thread_basic_info_t)thinfo;
        if (!(basic_info_th->flags & TH_FLAGS_IDLE)) {
            tot_sec = tot_sec + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;
            tot_usec = tot_usec + basic_info_th->system_time.microseconds + basic_info_th->system_time.microseconds;
            // cpu_usage : Scaled cpu usage percentage. The scale factor is TH_USAGE_SCALE.
            //宏定义TH_USAGE_SCALE返回CPU处理总频率：
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE;
        }
    } // for each thread
    
    // 注意方法最后要调用 vm_deallocate，防止出现内存泄漏
    kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    assert(kr == KERN_SUCCESS);
    
    self.CPULabel.text = [NSString stringWithFormat:@"CPU：%.1f%%",tot_cpu * 100];
}

- (UILabel *)CPULabel {
    if (!_CPULabel) {
        _CPULabel = [[UILabel alloc] init];
        _CPULabel.textAlignment = NSTextAlignmentCenter;
        _CPULabel.textColor = [UIColor blackColor];
        _CPULabel.font = [UIFont systemFontOfSize:8];
        _CPULabel.adjustsFontSizeToFitWidth = YES;
        _CPULabel.text = @"loading";
    }
    return _CPULabel;
}

- (UILabel *)FPSLabel {
    if (!_FPSLabel) {
        _FPSLabel = [[UILabel alloc] init];
        _FPSLabel.textAlignment = NSTextAlignmentCenter;
        _FPSLabel.textColor = [UIColor blackColor];
        _FPSLabel.font = [UIFont systemFontOfSize:8];
        _FPSLabel.adjustsFontSizeToFitWidth = YES;
        _FPSLabel.text = @"60";
        _FPSLabel.layer.masksToBounds = YES;
    }
    return _FPSLabel;
}


@end
