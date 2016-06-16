//
//  WeatherViewController.h
//  YiBai67Test
//
//  Created by songxianxian on 16/2/17.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherView.h"
@interface WeatherViewController : UIViewController
{
    BOOL _isNight;  //记录是白天 还是晚上
    UIImageView *_sanJiao; //三角图片
    
    UIButton *_previousBtn; //记录原来选中的是哪个按钮
    
    WeatherView *_weatherView; //展示天气情况的view
    
    int _currentBtnTag; //记录当前选中的按钮的tag值
}
@end








