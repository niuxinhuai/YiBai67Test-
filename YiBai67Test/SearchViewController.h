//
//  SearchViewController.h
//  YiBai67Test
//
//  Created by songxianxian on 16/2/17.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController
{
    UIView *_redView; //小红条
    
    NSMutableArray *_btnArr; //存放按钮的数组
    
    UIButton *_previousBtn; //记录原来选中的按钮
    
    UIWebView *_webView;
    
    NSMutableArray *_urlArr;//存url的数组
}
@end







