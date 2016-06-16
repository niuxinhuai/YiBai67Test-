//
//  CityViewController.m
//  YiBai67Test
//
//  Created by songxianxian on 16/2/17.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#define BIG_BUTTON_WIDTH 70
#define BIG_DISTANCE 70
#define SMALL_DISTANCE 60

#import "CityViewController.h"
#import"ZYButton.h"
@interface CityViewController ()

@end

@implementation CityViewController

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
    
    //设置scrollView
    [self settingScrollView];
    
    _timer=  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    _speed =1;
    
    
    //创建4个红色小按钮
    for (int i =0 ; i<4; i++) {
        
        ZYButton *redBtn =[ZYButton buttonWithType:UIButtonTypeCustom];
        redBtn.frame =CGRectMake(320-40-20, 480-40-20-64, 40, 40);
        //记录设置按钮中心点坐标
        _settingBtnCenter =redBtn.center;
        // i    0 1 2 3
        // i+1  1 2 3 4
        //图片名 1 2 3 0  (i+1)%4
        [redBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"c_setting%d.png",(i+1)%4]] forState:UIControlStateNormal];
        redBtn.tag =i+1; //1~4 交通1 美食2 酒店3 设置4
        //通过扩充的属性，交通 美食 酒店分别记录自己的偏移单位
        if (i<3) {
            switch (i) {
                case 0: //交通
                    redBtn.offSet =CGPointMake(1, 0);
                    break;
                case 1: //美食
                    redBtn.offSet=CGPointMake(1, 1);
                    break;
                case 2: //酒店
                    redBtn.offSet=CGPointMake(0, 1);
                    break;
                default:
                    break;
            }
            
        }
        [redBtn addTarget:self action:@selector(redBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:redBtn];
      
    }
 
}

//点击红色按钮，执行的都是放大的操作，放大结束之后是缩回一点点还是缩回到设置按钮，是由是展开还是闭合状态决定的
 
-(void)redBtnClick:(ZYButton*)clickedBtn{
    
    //放大
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    for (int i =1; i<=3; i++) {
        ZYButton *btn =(ZYButton*)[self.view viewWithTag:i];
        btn.center =CGPointMake(_settingBtnCenter.x-btn.offSet.x*BIG_DISTANCE, _settingBtnCenter.y-btn.offSet.y*BIG_DISTANCE);
    }
    
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    
    //交通tag1   111 112 113
    //美食tag2   112 113
    //酒店tag3   113
    for (UIButton *bigBtn in _bigBtnArr) {
        bigBtn.hidden =NO;
        if (bigBtn.tag-110>=clickedBtn.tag) {
            bigBtn.hidden =YES;
        }
    }
}

//动画结束后方法
-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    
    //1.找到 酒店 美食 交通 三个按钮？ a. 将三按钮放入数组 b. viewWithTag
   
    
    //是缩小一点点 还是 缩回到设置按钮 是由展开还是闭合状态决定的
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    
    for (int i =1; i<=3; i++) {
        ZYButton *btn =(ZYButton*)[self.view viewWithTag:i];
        
        if (_isOpen==NO) { //闭合状态 ，缩回一点点
             btn.center =CGPointMake(_settingBtnCenter.x-btn.offSet.x*SMALL_DISTANCE, _settingBtnCenter.y-btn.offSet.y*SMALL_DISTANCE);
            
        }else{ //展开状态 ，缩回到设置按钮
            
            btn.center =_settingBtnCenter;
        }
    }

    [UIView commitAnimations];
    
    //每次点过红按钮之后，最终所有动画结束后状态都发生改变
    _isOpen =!_isOpen;
    
    
}

/*
//方法2
//红色按钮绑定的方法
-(void)redBtnClick{
    
    //放大
    //1.找到 酒店 美食 交通 三个按钮？ a. 将三按钮放入数组 b. viewWithTag
    UIButton *traffic = (UIButton*)[self.view viewWithTag:1];
    UIButton *food = (UIButton*)[self.view viewWithTag:2];
    UIButton *hotel = (UIButton*)[self.view viewWithTag:3];
    
    //2. 改变3个按钮的坐标
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    //(1,0)
    traffic.center =CGPointMake(_settingBtnCenter.x-BIG_DISTANCE, traffic.center.y);
    //(1,1)
    food.center =CGPointMake(_settingBtnCenter.x-BIG_DISTANCE, _settingBtnCenter.y-BIG_DISTANCE);
    //(0,1)
    hotel.center =CGPointMake(hotel.center.x, _settingBtnCenter.y-BIG_DISTANCE);
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    
    
    
}

//动画结束后方法
-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    
    //1.找到 酒店 美食 交通 三个按钮？ a. 将三按钮放入数组 b. viewWithTag
    UIButton *traffic = (UIButton*)[self.view viewWithTag:1];
    UIButton *food = (UIButton*)[self.view viewWithTag:2];
    UIButton *hotel = (UIButton*)[self.view viewWithTag:3];
    
    //是缩小一点点 还是 缩回到设置按钮 是由展开还是闭合状态决定的
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    if (_isOpen==NO) { //闭合状态 ，缩回一点点
        traffic.center =CGPointMake(_settingBtnCenter.x-SMALL_DISTANCE, traffic.center.y);
        food.center =CGPointMake(_settingBtnCenter.x-SMALL_DISTANCE, _settingBtnCenter.y-SMALL_DISTANCE);
        hotel.center =CGPointMake(hotel.center.x, _settingBtnCenter.y-SMALL_DISTANCE);
        
    }else{ //展开状态 ，缩回到设置按钮
        
        traffic.center =_settingBtnCenter;
        food.center =_settingBtnCenter;
        hotel.center =_settingBtnCenter;
        
    }
    [UIView commitAnimations];
    
    //每次点过红按钮之后，最终所有动画结束后状态都发生改变
    _isOpen =!_isOpen;
    
    
}
*/

-(void)settingScrollView{
    //大滚动视图
    UIScrollView *bigScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320,480-64)];
    bigScrollView.contentSize =CGSizeMake(320, 700);
    bigScrollView.backgroundColor =[UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:1];
    [self.view addSubview:bigScrollView];
    
    //小滚动视图
    _smallScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
    _smallScrollView.contentSize =CGSizeMake(5*320, 150);
    _smallScrollView.delegate =self;
    _smallScrollView.pagingEnabled =YES;
    [bigScrollView addSubview:_smallScrollView];
    //给小滚动视图添加图片
    for (int i=0; i<5; i++) {
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*320, 0, 320, 150)];
        imageView.image =[UIImage imageNamed:[NSString stringWithFormat:@"c_item%d.jpg",i]];
        [_smallScrollView addSubview:imageView];
    }
    _pageControl =[[UIPageControl alloc]initWithFrame:CGRectMake(60, 130, 200, 20)];
    _pageControl.numberOfPages=5;
    [_pageControl addTarget:self action:@selector(pageControlClick:) forControlEvents:UIControlEventValueChanged];
    [bigScrollView addSubview:_pageControl];
    
    
    //创建13个大按钮
    _bigBtnArr =[[NSMutableArray alloc]initWithCapacity:0];
    float interval = (320-3*BIG_BUTTON_WIDTH)/4.0;
    for (int i=0; i<13; i++) {
        int col =i%3;
        int row =i/3;
        float x =interval +col*(BIG_BUTTON_WIDTH+interval);
        float y = 170 +row*(BIG_BUTTON_WIDTH+interval);
        UIButton *bigBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        bigBtn.frame =CGRectMake(x, y, BIG_BUTTON_WIDTH, BIG_BUTTON_WIDTH);
        bigBtn.tag =i+101; //101~113
        // i 0 1 2 3 4 5 6 7 8 9 10 11 12
        //图片名    1 2 3 4 5 6 7 8 9 10 11 12 1  i%12+1
        //         0 1 2 3 4 5 6 7 8 9  10 11 0  i%12
        [bigBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"c_%d.png",i%12+1]] forState:UIControlStateNormal];
        [bigScrollView addSubview:bigBtn];
        [_bigBtnArr addObject:bigBtn];
    }
}



//pageControl绑定的方法
-(void)pageControlClick:(UIPageControl*)pageControl{
    NSLog(@"kkkk===%d",pageControl.currentPage);
    
    //根据pageControl的currentPage计算小scrollView的偏移量
    [_smallScrollView setContentOffset:CGPointMake(pageControl.currentPage*320, 0) animated:YES];
    
}

//scrollView结束减速的协议方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //根据小scrollView的偏移量，计算当前的页号
    int page =scrollView.contentOffset.x/320;
    _pageControl.currentPage =page;
    
}
-(void)onTimer{
    
    _pageControl.currentPage += _speed;
   // NSLog(@"这是定时器绑定的方法==%d",_pageControl.currentPage);
    
    //走到边的时候，对速度进行取反
    if (_pageControl.currentPage>=4||_pageControl.currentPage<=0) {
        _speed =-_speed;
    }
    //让scrollView也跟着变
    [self pageControlClick:_pageControl];
    
}

//将对导航条的设置封装成一个方法
-(void)settingNavigationBar{
    self.navigationController.navigationBarHidden=NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"c_bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    self.navigationItem.leftBarButtonItem =backItem;
}


//返回
-(void)backClick{
    
    [_timer invalidate];
    _timer =nil;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
