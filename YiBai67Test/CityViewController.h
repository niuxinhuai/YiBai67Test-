//
//  CityViewController.h
//  YiBai67Test
//
//  Created by songxianxian on 16/2/17.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityViewController : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *_smallScrollView;
    UIPageControl *_pageControl;
    
    int _speed;
    
    NSTimer *_timer;
    
    CGPoint _settingBtnCenter; //记录设置按钮中心点坐标
    
    BOOL _isOpen;
    
    NSMutableArray *_bigBtnArr; //存放大按钮的数组
}
@end






