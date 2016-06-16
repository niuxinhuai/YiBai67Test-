//
//  SunOrMoonView.m
//  YiBai67Test
//
//  Created by songxianxian on 16/2/22.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#import "SunOrMoonView.h"

@implementation SunOrMoonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       // self.backgroundColor =[UIColor yellowColor];
        
        //做太阳月亮帧动画的imageView
        _sunOrMoonImageView =[[UIImageView alloc]initWithFrame:CGRectMake(160, 100, 100, 100)];
        [self addSubview:_sunOrMoonImageView];
        
        //创建20个星星
        _starImageViewArr =[[NSMutableArray alloc]initWithCapacity:0];
        for (int i=0; i<20; i++) {
            UIImageView *starImageView =[[UIImageView alloc]initWithFrame:CGRectMake(arc4random()%(280-20+1), arc4random()%160, 20, 20)];
            [self addSubview:starImageView];
            [_starImageViewArr addObject:starImageView];
        }
     
        //太阳、月亮、星星 帧动画数组
        _sunImageArr =[[NSArray alloc]initWithObjects:[UIImage imageNamed:@"w_sun1.png"],[UIImage imageNamed:@"w_sun2.png"], nil];
        _moonImageArr =[[NSArray alloc]initWithObjects:[UIImage imageNamed:@"w_moon1.png"],[UIImage imageNamed:@"w_moon2.png"], nil];
        _starImageArr =[[NSArray alloc]initWithObjects:[UIImage imageNamed:@"xx1.png"],[UIImage imageNamed:@"xx2.png"], nil];
        
        
    }
    return self;
}

-(void)changeSunOrMoonWithTag:(int)aTag withNight:(BOOL)aNight{
    
    //清屏，将动画效果清除掉
    //a.太阳月亮帧动画清除
    _sunOrMoonImageView.animationImages=nil;
    [_sunOrMoonImageView stopAnimating];
    //b.星星帧动画清除
    for (UIImageView *starImageView in _starImageViewArr) {
        starImageView.animationImages =nil;
        [starImageView stopAnimating];
    }
    
    
    
    //周一或者周二，并且是白天  做太阳帧动画
    if ((aTag==1||aTag==2)&&aNight==NO) { //太阳
        
        _sunOrMoonImageView.animationImages =_sunImageArr;
        _sunOrMoonImageView.animationDuration =_sunImageArr.count*0.1;
        [_sunOrMoonImageView startAnimating];
    }
    
    //周一或者周二，并且是晚上  做月亮星星帧动画
    if ((aTag==1||aTag==2)&&aNight==YES) { //月亮星星
        
        
        _sunOrMoonImageView.animationImages =_moonImageArr;
        _sunOrMoonImageView.animationDuration =_sunImageArr.count*0.1;
        [_sunOrMoonImageView startAnimating];
        
        //星星
        for (UIImageView *starImageView in _starImageViewArr) {
            starImageView.animationImages=_starImageArr;
            starImageView.animationDuration=_starImageArr.count*0.1;
            [starImageView startAnimating];
        }

    }

    
}
@end
