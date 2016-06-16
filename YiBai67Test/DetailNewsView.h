//
//  DetailNewsView.h
//  YiBai67Test
//
//  Created by songxianxian on 16/2/18.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailNewsView : UIView
{
    UILabel *_titleLabel; //标题label
    
    UIImageView *_contentImageView; //展示具体的新闻内容
    
    NSArray *_titleArr; //存放新闻标题数组
}

//改变成什么内容，与点击的是头条、科技等中的哪个按钮有关，需要带参数，将点击的btn的的tag值传过来
-(void)changeContentWithTag:(int)aTag;


@end



