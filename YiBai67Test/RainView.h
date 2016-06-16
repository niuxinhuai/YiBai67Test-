//
//  RainView.h
//  YiBaiTest
//
//  Created by ZY on 15-10-9.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RainView : UIView
{
    NSMutableArray * _rainArray ;
    NSTimer  * _timer ;
    int _count ;
}
//雨只和“星期几”有关
-(void)setWeekButtonTag:(int)tag;
@end
