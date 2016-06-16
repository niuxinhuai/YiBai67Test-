//
//  PasswordViewController.h
//  YiBai67Test
//
//  Created by songxianxian on 16/2/16.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordViewController : UIViewController
{
    //存放密码图片的数组
    NSMutableArray *_pswImageArr;
    
    //记录密码正确的次数
    int _rightCount;
}
@end








