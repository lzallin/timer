//
//  TheTimer.m
//  CCLIOT
//
//  Created by Mac on 16/11/4.
//  Copyright © 2016年 CCLL. All rights reserved.
//

#import "TheTimer.h"

@interface TheTimer ()
@property (nonatomic, strong)dispatch_source_t time;
@property (nonatomic ,assign) int count;
@end
@implementation TheTimer
+(TheTimer *)getInstance
{
    static TheTimer *timer=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timer=[[TheTimer alloc] init];
    });
    return timer;
}
-(void)starTheTimerForBeginSeconds:(int)beginSecond intervalSeconds:(int)intervalSecond timers:(int)timers codeBlcok:(timerBlcok)blcok;
{
    __block int count=0;
    //获得队列
    dispatch_queue_t queue =dispatch_queue_create("timerQue", DISPATCH_QUEUE_CONCURRENT);
    //创建一个定时器
    dispatch_source_t time = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //设置开始时间
    dispatch_time_t start = dispatch_time(beginSecond* NSEC_PER_SEC, (int64_t)(0.0 * NSEC_PER_SEC));
    //设置时间间隔
    uint64_t interval = (uint64_t)(intervalSecond* NSEC_PER_SEC);
    //设置定时器
    dispatch_source_set_timer(time, start, interval, 0);
    //设置回调
    dispatch_source_set_event_handler(time, ^{
        count++;
        //定时器执行的次数
        if (timers==count&&timers!=0) {
            dispatch_cancel(time);
        }
        blcok();
    });
    //由于定时器默认是暂停的所以我们启动一下
    //启动定时器
    dispatch_resume(time);
}
@end
