//
//  TheTimer.h
//  CCLIOT
//
//  Created by Mac on 16/11/4.
//  Copyright © 2016年 CCLL. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^timerBlcok)(void);
@interface TheTimer : NSObject
@property (nonatomic ,copy) timerBlcok timerBlcok;
+(TheTimer *)getInstance;
-(void)starTheTimerForBeginSeconds:(int)beginSecond intervalSeconds:(int)intervalSecond timers:(int)timers codeBlcok:(timerBlcok)blcok;
@end
