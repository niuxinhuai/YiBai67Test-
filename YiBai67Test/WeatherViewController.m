//
//  WeatherViewController.m
//  YiBai67Test
//
//  Created by songxianxian on 16/2/17.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#import "WeatherViewController.h"
#import "WeatherView.h"
@interface WeatherViewController ()

@end

@implementation WeatherViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置导航条
    [self settingNavigationBar];
    
    //背景图片
    UIImageView *bgImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, -44, 320, 480-20)];
    bgImageView.image =[UIImage imageNamed:@"w_bg.png"];
    [self.view addSubview:bgImageView];
    
    //创建scrollView
    UIScrollView *scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 480-70-64-10, 320, 70)];
    scrollView.contentSize =CGSizeMake(7*105, 70);
    [self.view addSubview:scrollView];
    NSArray *btnTitleArr =@[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    for (int i=0; i<7; i++) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame =CGRectMake(10+i*(90+10), 20, 90, 50);
        //按钮的名子
        [btn setTitle:btnTitleArr[i] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"w_xq1.png"] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"w_xq2.png"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn.tag =i+1; //1~7
        if (i==0) {
            btn.selected =YES;
            //记录原来选中的是哪个按钮
            _previousBtn =btn;
            
            //记录当前选中btn的tag值
            _currentBtnTag =1;
        }
        [btn addTarget:self action:@selector(weekBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:btn];
        
    }
    
    //创建三角图片
    _sanJiao =[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 90, 20)];
    _sanJiao.image =[UIImage imageNamed:@"w_tip.png"];
    [scrollView addSubview:_sanJiao];
    
    
    //创建展示天气情况的view
    _weatherView =[[WeatherView alloc]initWithFrame:CGRectMake(20, 35, 280, 280)];
    [self.view addSubview:_weatherView];
    
    [_weatherView changeWeatherWithTag:_currentBtnTag withNight:_isNight];
  
}

//周一~周日按钮绑定的方法
-(void)weekBtnClick:(UIButton*)btn{
    if (btn==_previousBtn) {
        return;
    }
    _previousBtn.selected =NO;
    btn.selected =YES;
    _previousBtn =btn;
    
    //记录当前选中的btn的tag值
    _currentBtnTag =btn.tag;
    
    //三角图片坐标改变
    _sanJiao.center =CGPointMake(btn.center.x, _sanJiao.center.y);
    

    //天气情况发生改变
    [_weatherView changeWeatherWithTag:_currentBtnTag withNight:_isNight];
    
}

//将对导航条的设置封装成一个方法
-(void)settingNavigationBar{
    self.navigationController.navigationBarHidden=NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"w_bg2.png"] forBarMetrics:UIBarMetricsDefault];
    
    //隐藏返回按钮， 防止出现bug 
    self.navigationItem.hidesBackButton =YES;
    
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    self.navigationItem.leftBarButtonItem =backItem;
    
    //返回按钮
    UIButton *dayOrNightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    dayOrNightBtn.bounds =CGRectMake(0, 0, 44, 44);
    [dayOrNightBtn setTitle:@"白天" forState:UIControlStateNormal];
    [dayOrNightBtn addTarget:self action:@selector(dayOrNightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc]initWithCustomView:dayOrNightBtn];
    self.navigationItem.rightBarButtonItem =rightItem;
    
    
    
}

//切换白天黑夜按钮 绑定的方法
-(void)dayOrNightBtnClick:(UIButton*)btn{
    //1. btn标题的改变
    if (_isNight==NO) { //白天--->晚上
        [btn setTitle:@"晚上" forState:UIControlStateNormal];
    }else{
        [btn setTitle:@"白天" forState:UIControlStateNormal];
    }
    _isNight =!_isNight;
    
    
    //2.白天黑夜切换之后 ，天气情况也要发生变化
    [_weatherView changeWeatherWithTag:_currentBtnTag withNight:_isNight];
    
}


//返回
-(void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
