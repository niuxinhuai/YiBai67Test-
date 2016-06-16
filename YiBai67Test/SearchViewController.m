//
//  SearchViewController.m
//  YiBai67Test
//
//  Created by songxianxian on 16/2/17.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

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
    
    
    UIScrollView *scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    scrollView.backgroundColor =[UIColor lightGrayColor];
    scrollView.contentSize =CGSizeMake(800, 44);
    [self.view addSubview:scrollView];
    
    NSArray *titleArr =@[@"百度",@"淘宝",@"京东",@"智游",@"163",@"hao123",@"新浪",@"腾讯"];
    _btnArr =[[NSMutableArray alloc]initWithCapacity:0];
    for (int i=0; i<8; i++) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame =CGRectMake(10+i*(80+10), 0, 80, 42);
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //slected状态是 selected属性值为YES的时候
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        btn.titleLabel.font=[UIFont systemFontOfSize:16];
        if (i==0) {
            btn.selected =YES;
            //记录选中的按钮
            _previousBtn=btn;
        }
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag =i;
        [scrollView addSubview:btn];
        [_btnArr addObject:btn];
        
    }
    
    //小红条
    _redView =[[UIView alloc]init];
    _redView.center =CGPointMake(50, 43);
  CGSize size=  [titleArr[0] sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]}];
    _redView.bounds =CGRectMake(0, 0, size.width, 2);
    _redView.backgroundColor =[UIColor redColor];
    [scrollView addSubview:_redView];
    
    
    //@"百度",@"淘宝",@"京东",@"智游",@"163",@"hao123",@"新浪",@"腾讯"
    _urlArr =[[NSMutableArray alloc]initWithObjects:@"http://www.baidu.com",@"http://www.taobao.com",@"http://www.JD.com",@"http://www.zhiyou100.com",@"http://www.163.com",@"http://www.hao123.com",@"http://www.sina.com",@"http://www.qq.com", nil];
    //webView
    _webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 44, 320, 480-64-44)];
    [self.view addSubview:_webView];
    NSURL *url =[NSURL URLWithString:_urlArr[0]];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    
}

-(void)btnClick:(UIButton*)btn{
    
    //方法1. 先将所有的按钮的颜色都变黑色，然后再让点击的按钮的颜色变为蓝色
    /*for (UIButton *btn1 in _btnArr) {
        btn1.selected =NO;
    }
    btn.selected =YES;*/
    
    //方法2:找个变量记录一下原来选中的是哪个按钮，让原来选中的按钮颜色变黑，当前点击的按钮的颜色变蓝
    if (btn==_previousBtn) {
        return;
    }
    _previousBtn.selected=NO;
    btn.selected =YES;
    _previousBtn =btn;
    
    //小红条移动
 CGSize size=   [btn.currentTitle sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]}];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    _redView.center =CGPointMake(btn.center.x, _redView.center.y);
    _redView.bounds =CGRectMake(0, 0, size.width, 2);
    [UIView commitAnimations];
    
    //webView
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_urlArr[btn.tag]]];
    [_webView loadRequest:request];
}

//将对导航条的设置封装成一个方法
-(void)settingNavigationBar{
    self.navigationController.navigationBarHidden=NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"s_bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    
    self.navigationItem.leftBarButtonItem =backItem;
}


//返回
-(void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
