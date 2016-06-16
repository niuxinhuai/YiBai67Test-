//
//  CloudView.m
//  YiBaiTest
//
//  Created by ZY on 15-10-9.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

#import "CloudView.h"

@implementation CloudView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //超出父视图不显示
        self.clipsToBounds = YES ;
        
        _cloudArray = [[NSMutableArray alloc]init];
        //创建多个云
        for (int i = 0 ; i < 50; i++)
        {
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(-118, arc4random()%(290-57-57), 118, 57)];
            imageView.image = [UIImage imageNamed:@"w_cloud.png"];
            [self addSubview:imageView];
            [_cloudArray addObject:imageView];
        }
    }
    return self;
}
-(void)changeCloudView:(int)tag{
    
    //清屏操作 ；
    if (_timer != nil)
    {
        [_timer invalidate];
        _timer = nil;
    }
    for (UIImageView *  cloud in _cloudArray)
    {
        cloud.frame = CGRectMake(-118, arc4random()%(290-57-57), 118, 57);
        //所有的云都变为可以重用
        cloud.tag = 0 ;
    }
    
    //周二有云彩
    if (tag == 2)
    {
        if (_timer == nil)
        {
            _timer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
            //通常在主线程中使用nstimer 滑动界面时，系统为了更好的处理UI时间和滚动显示 主线程run loop会暂时停止处理一些其他事件，这时主线程中运行的NSTimer会被暂停 。解决办法就是改变ranloop运行的mode  mode可以看成事件类型  不使用默认的  而是使用NSRunLoopCommonModes [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes]默认类型即缺省类型为NSDefaultRunLoopMode
            //[[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
            
        }
    }

   
}
-(void)onTimer
{
    //调频，定时器方法执行多次，才执行一次找云彩的方法；
    _count ++ ;
    if (_count > 30)
    {
        [self findCloud];
        _count = 0 ;
    }
    [self cloudMove];
}

-(void)findCloud
{
    for(UIImageView * cloud in _cloudArray)
    {
        if (cloud.tag == 0)
        {
            cloud.tag = 1 ;
            //重置初始位置
            cloud.frame =CGRectMake(-118, arc4random()%(290-57-57), 118, 57);
            //只有找到一朵云彩才结束for循环
            break ;
        }
    }
}

-(void)cloudMove
{
    for (UIImageView * cloud in _cloudArray)
    {
        if (cloud.tag == 1)
        {
            cloud.frame = CGRectMake(cloud.frame.origin.x + 5 , cloud.frame.origin.y, cloud.frame.size.width, cloud.frame.size.height);
            if (cloud.frame.origin.x > 280)
            {
                cloud.tag = 0 ;
            }
        }
    }
}


@end
