                      //
//  WeatherView.m
//  YiBai67Test
//
//  Created by songxianxian on 16/2/22.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#import "WeatherView.h"
#import"SunOrMoonView.h"
@implementation WeatherView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor =[UIColor redColor];
    
        //背景图
        _bgImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 280, 280)];
        _bgImageView.image =[UIImage imageNamed:@"w_qing.png"];
        [self addSubview:_bgImageView];
        
        
        //太阳月亮帧动画view
        _sunOrMoonView =[[SunOrMoonView alloc]initWithFrame:CGRectMake(0, 0, 280, 280)];
        [self addSubview:_sunOrMoonView];
        
        //创建云的view
        _cloudView =[[CloudView alloc]initWithFrame:CGRectMake(0, 0, 280, 290)];
        [self addSubview:_cloudView];
        
        //创建雨的view
        _rainView =[[RainView alloc]initWithFrame:CGRectMake(0, 0, 280, 290)];
        [self addSubview:_rainView];
        
        
    }
    return self;
}

//改变天气情况
-(void)changeWeatherWithTag:(int)aTag withNight:(BOOL)aNight{
    
    //周五~周日，展示成周一的天气情况
    if (aTag>=5) {
        aTag=1;
    }
    
    //改变太阳月亮动画效果
    [_sunOrMoonView changeSunOrMoonWithTag:aTag withNight:aNight];
    
    //云彩的展示只和“星期几”有关
    [_cloudView changeCloudView:aTag];
    
    //雨的展示只和“星期几”有关
    [_rainView setWeekButtonTag:aTag];
    
    
    //创建背景图片名字数组 ，保证数组只被创建一次
    static  NSArray *bgNameArr;
    if (bgNameArr==nil) {
        bgNameArr =[[NSArray alloc]initWithObjects:@"w_qing.png",@"w_duoyun.png",@"w_yin",@"w_yu.png", nil];
        
    }

    //背景图
    //首先判断是白天 还是晚上？
    if (aNight==NO) { //白天
        //根据 星期几(tag) 展示不同的图片
        
        _bgImageView.image =[UIImage imageNamed:bgNameArr[aTag-1]];
        
    }else{ //晚上
       
        _bgImageView.image =[UIImage imageNamed:@"w_night.png"];
    }
    
    
    
    
    
}

@end
