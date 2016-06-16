//
//  DetailNewsView.m
//  YiBai67Test
//
//  Created by songxianxian on 16/2/18.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#import "DetailNewsView.h"

@implementation DetailNewsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
   
    //self 其实就是一个视图
  //相关控件的控件可以写在初始化方法中
        
        //NSLog(@"self==%@",self);
        //self.backgroundColor =[UIColor grayColor];
        
        self.clipsToBounds =YES;
        
  //假的导航条imageView
        UIImageView *navImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        navImageView.image =[UIImage imageNamed:@"commonNavBar.png"];
        [self addSubview:navImageView];
        
  //展示标题label
        _titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(110, 0, 100, 44)];
        _titleLabel.text =@"头条";
        _titleLabel.textAlignment =NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
 //左边按钮
        UIButton *leftBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame =CGRectMake(10, 5, 25, 25);
        leftBtn.tag =100;
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"n_menu.png"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(leftBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftBtn];
        
//展示新闻内容的imageView
        _contentImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 44, 320, 480-44)];
        _contentImageView.image =[UIImage imageNamed:@"news_1.png"];
        [self addSubview:_contentImageView];
        
        
        
    }
    return self;
}

//左边小按钮绑定的方法
//新闻详细界面变小 并且左侧按钮不可点击
-(void)leftBtn:(UIButton*)btn{
    //大-->小
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    self.frame =CGRectMake(150, 200, 320, 200);
    [UIView commitAnimations];
    
    _titleLabel.textAlignment =NSTextAlignmentLeft;
    
    //左侧btn不可点击
    btn.enabled=NO;

}

//改变内容
-(void)changeContentWithTag:(int)aTag{
    //需要的时候才创建
    if (!_titleArr) { //_titleArr==nil
        _titleArr =[[NSArray alloc]initWithObjects:@"头条",@"娱乐",@"体育",@"科技",@"财经",@"时尚", nil];
        
    }
   
    //标题label和新闻内容image要改变
    _titleLabel.text =_titleArr[aTag-1];
    _titleLabel.textAlignment=NSTextAlignmentCenter;
    _contentImageView.image =[UIImage imageNamed:[NSString stringWithFormat:@"news_%d.png",aTag]];
    
    //再次变大
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    self.frame =CGRectMake(0, 0, 320, 480);
    [UIView commitAnimations];
    
    //找到左边按钮，让其变为可点击
    UIButton *leftBtn =(UIButton*)[self viewWithTag:100];
    leftBtn.enabled=YES;
    
    
}
@end
                
                
                
                
                
                
                
                
