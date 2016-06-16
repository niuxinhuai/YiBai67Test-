//
//  MainViewController.m
//  YiBai67Test
//
//  Created by songxianxian on 16/2/16.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#define ANGLE_2_RADIAN(x)  ((x)/180.0*M_PI)
#import "MainViewController.h"
#import"ZYButton.h"
#import "WeatherViewController.h"
#import "CityViewController.h"
#import "NewsViewController.h"
#import "SearchViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    //隐藏导航条  怎么让导航条隐藏的就怎么让它出现，两种方式不要混着用
    //隐藏方式一
    self.navigationController.navigationBarHidden =YES;
    //隐藏方式二
   // self.navigationController.navigationBar.hidden=YES;
    
    //背景图
    UIImageView *bgImageView =[[UIImageView alloc]initWithFrame:self.view.frame];
    bgImageView.image =[UIImage imageNamed:@"bg2.jpg"];
    [self.view addSubview:bgImageView];

    
    //for 创建圆上的4个按钮
    //创建存放4个按钮的数组，是为了将来在定时器绑定的方法中可以拿到所有的按钮
    _btnArr =[[NSMutableArray alloc]initWithCapacity:0];
    for (int i=0; i<4; i++) {
        
        ZYButton *btn =[ZYButton buttonWithType:UIButtonTypeCustom];
        // x = 圆中心点x +半径*cos@
        // y = 圆中心点y +半径*sin@
        btn.angle =i*90;
        float x =self.view.center.x +100*cos(ANGLE_2_RADIAN(btn.angle));
        float y =self.view.center.y +100*sin(ANGLE_2_RADIAN(btn.angle));
        btn.center =CGPointMake(x, y);
        btn.bounds =CGRectMake(0, 0, 60, 60);
        //按钮图片
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"m_item%d.png",i+1]] forState:UIControlStateNormal];
        //按钮的方法
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag =i+1;
        [self.view addSubview:btn];
        
        //将按钮放入数组
        [_btnArr addObject:btn];
 
    }
  
}

-(void)btnClick:(ZYButton*)btn{
   
    //首先判断点击的按钮是不是正上方的按钮?
    //   正上方的btn--->直接push到对应的界面
    //   其它位置的btn-->让所有的btn都旋转，旋转到点击的按钮运动到正上方时停止旋转，并且push
    
    //怎么判断点击的按钮 是否在正上方？1.angle 2.坐标 中心点y=self.view.center-半径
    
    if (btn.angle%360==270) { //正上方  push到下一界面
        
        NSLog(@"push到下一个界面");
        [self goToNextVCWithTag:btn.tag];                                                                           
        
    }else{  //其它位置  旋转
       
        //是为了避免连续点击按钮，开启多个定时器
        if (_timer==nil) {
           _timer=  [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(onTimer:) userInfo:btn repeats:YES];
        }
      
    }
    
}

//定时器绑定的方法带参数，是将定时器本身传过来
-(void)onTimer:(NSTimer*)aTimer{
    
    //1.怎么拿到点击的按钮？a.定时器将btn传过来 b.全局的指针记录一下点击的那个btn
    ZYButton *clickedBtn = aTimer.userInfo;
    
    //2.让所有的按钮旋转
    // 怎么拿到所有按钮？a. 4个按钮放到数组中 b. viewWithTag
    for (ZYButton *btn in _btnArr) {
        
        btn.angle += 5;
        float x =self.view.center.x +100*cos(ANGLE_2_RADIAN(btn.angle));
        float y =self.view.center.y +100*sin(ANGLE_2_RADIAN(btn.angle));
        btn.center =CGPointMake(x, y);
        
        //点击的按钮在正上方，并且遍历的按钮就是点击的按钮
        //clickedBtn.angle%360==270&&btn==clickedBtn
        
       /* if (clickedBtn.angle%360==270) {
            //只是将定时器损毁，此次onTimer:方法仍要执行完毕,for循环会继续执行
            [aTimer invalidate];
            aTimer =nil;
            _timer =nil;
            
            [self goToNextVCWithTag:clickedBtn.tag];
            
            //点击的按钮旋转到正上方 即终止遍历
            break;
            
        }*/

    }
    
    //3.点击的按钮运动到正上方的时候停止  270或者n*360+270
    if (clickedBtn.angle%360==270) {
        
        [aTimer invalidate];
        aTimer =nil;
        _timer =nil;
        
        [self goToNextVCWithTag:clickedBtn.tag];
        
    }

    
//方法2 通过坐标判断是否在 正上方
//    if (clickedBtn.center.y==self.view.center.y-100) {
//        NSLog(@"旋转到正上方");
//        [aTimer invalidate];
//        aTimer =nil;
//        
//        
//        [self goToNextVCWithTag:clickedBtn.tag];
//
//    }
    

}

//进入到下一界面
-(void)goToNextVCWithTag:(int)aTag{
    
    switch (aTag) {
        case 1:
        {
            WeatherViewController *weather =[[WeatherViewController alloc]init];
            [self.navigationController pushViewController:weather animated:YES];
            
        }
            break;
        case 2:
        {
            SearchViewController *search =[[SearchViewController alloc]init];
            [self.navigationController pushViewController:search animated:YES];
        }
            break;
        case 3:
        {
            CityViewController *city =[[CityViewController alloc]init];
            [self.navigationController pushViewController:city animated:YES];
        }
            break;
        case 4:
        {
            NewsViewController *news =[[NewsViewController alloc]init];
            [self.navigationController pushViewController:news animated:YES];
        }
            break;
            
        default:
            break;
    }
 
}

@end





