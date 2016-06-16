//
//  WeatherView.h
//  YiBai67Test
//
//  Created by songxianxian on 16/2/22.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SunOrMoonView.h"
#import "RainView.h"
#import "CloudView.h"
@interface WeatherView : UIView
{
    UIImageView *_bgImageView; //天气背景图
    
    SunOrMoonView *_sunOrMoonView; //太阳月亮动画效果view
    
    CloudView *_cloudView; //展示云的视图
    
    RainView *_rainView;//展示雨的视图
}

//改变天气情况   天气只和两个因素有关:1.星期几 2.白天还是晚上
-(void)changeWeatherWithTag:(int)aTag withNight:(BOOL)aNight;
@end





