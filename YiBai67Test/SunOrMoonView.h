//
//  SunOrMoonView.h
//  YiBai67Test
//
//  Created by songxianxian on 16/2/22.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SunOrMoonView : UIView
{
    //做太阳月亮帧动画的imageView
    UIImageView *_sunOrMoonImageView;
    
    NSArray *_sunImageArr; //太阳帧动画数组
    NSArray *_moonImageArr;//月亮帧动画数组
    NSArray *_starImageArr;//星星帧动画数组
    
    NSMutableArray *_starImageViewArr;//存放星星imageView的数组
    
}

//做太阳、月亮帧动画与两个因素有关:1.星期几 2.白天还是晚上
-(void)changeSunOrMoonWithTag:(int)aTag withNight:(BOOL)aNight;

@end






