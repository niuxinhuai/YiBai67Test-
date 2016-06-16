//
//  NewsViewController.m
//  YiBai67Test
//
//  Created by songxianxian on 16/2/17.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#import "NewsViewController.h"
#import "DetailNewsView.h"
@interface NewsViewController ()

@end

@implementation NewsViewController

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
    
    //背景图片
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    bgImageView.image =[UIImage imageNamed:@"n_background.png"];
    [self.view addSubview:bgImageView];
    
    //半透明条
    _maskView =[[UIView alloc]initWithFrame:CGRectMake(0, 45, 320, 55)];
    _maskView.backgroundColor =[UIColor lightGrayColor];
    _maskView.alpha=0.3;
    [self.view addSubview:_maskView];
    
    
    //创建6个按钮
    for (int i=0; i<6; i++) {
        
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame =CGRectMake(0, 45+i*(55+10), 320, 55);
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i+1;
        [self.view addSubview:btn];
    }
    
    
    
    //返回按钮
    UIButton *backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame =CGRectMake(10, 450, 25, 20);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    

    //新闻详细内容
    _detailView =[[DetailNewsView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_detailView];
    
    
    
}

//6个按钮绑定的方法
-(void)btnClick:(UIButton*)btn{
    
    //点击不同的按钮，新闻详细界面改变不同的内容
    [_detailView changeContentWithTag:btn.tag];
    
    //半透明条坐标变化
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    _maskView.frame =btn.frame;
    [UIView commitAnimations];
    
    
}

//返回
-(void)backBtnClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
                 
                 
                 
                 
                 
                 
                 
                 
