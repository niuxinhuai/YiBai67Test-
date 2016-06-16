//
//  RainView.m
//  YiBaiTest
//
//  Created by ZY on 15-10-9.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

#import "RainView.h"

@implementation RainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //超出父视图的不显示
        self.clipsToBounds = YES ;
        
        //创建雨数组，存放雨滴，便于重用
        _rainArray = [[NSMutableArray alloc]init];
        for (int i = 0 ; i < 100; i++)
        {
            UIImageView * rain = [[UIImageView alloc]init];
            rain.frame = CGRectMake(arc4random()%(280-15), -15, 15, 15);
            rain.image = [UIImage imageNamed:@"w_rain.png"];
            [self addSubview:rain];
            [_rainArray addObject:rain];
        }

    }
    return self;
}


-(void)setWeekButtonTag:(int)tag
{
    //清屏 操作;每当点击button时，先把屏幕上所有的雨都清除，定时器关闭；
    if (_timer != nil)
    {
        [_timer invalidate];
        _timer = nil;
    }
    //把所有雨的tag值改为0，位置改为屏幕外
    for(UIImageView * rain in _rainArray)
    {
        rain.frame =CGRectMake(arc4random()%(280-15), -15, 15, 15);
        rain.tag = 0 ;
    }
    
    
    //当为周四时，下雨
    if (tag == 4)
    {
        //下雨
        if (_timer == nil)
        {
            //调用scheduled创建的定时器是加入到NSDefaultRunLoopMode下
            _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
            //Mode
            //默认  NSDefaultRunLoopMode
            
            //滚动scrollView的时候 切换UITrackingRunLoopMode
            
            //通常在主线程中使用nstimer 滑动界面时，系统为了更好的处理UI事件和滚动显示 主线程run loop会暂时停止处理一些其他事件，这时主线程中运行的NSTimer会被暂停 。解决办法就是改变ranloop运行的mode  mode可以看成事件类型  不使用默认的  而是使用NSRunLoopCommonModes [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes]默认类型即缺省类型为NSDefaultRunLoopMode
            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        }
    }
}

//重用版本的雪花下落
-(void)onTimer
{
    _count ++ ;
    if (_count > 10)
    {
        _count = 0 ;
        [self findRain];
    }
    [self rainMove];
}
-(void)findRain
{
    for (UIImageView * rain in _rainArray)
    {
        if (rain.tag == 0)
        {
            rain.tag = 1 ;
            //重设rain的frame，避免每次重用的雨下落的线不变
            rain.frame = CGRectMake(arc4random()%(280-15), -15, 15, 15);
            break ;
        }
    }
}
-(void)rainMove
{
    for (UIImageView * rain in _rainArray)
    {
        if (rain.tag == 1)
        {
            rain.frame = CGRectMake(rain.frame.origin.x,rain.frame.origin.y+3 , 15, 15);
            if (rain.frame.origin.y>290)
            {
                rain.tag = 0 ;
            }
        }
    }
}


@end
