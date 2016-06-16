//
//  CloudView.h
//  YiBaiTest
//
//  Created by ZY on 15-10-9.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CloudView : UIView
{
    //数组存放多个云视图 ；重用实现云的运动
    NSMutableArray * _cloudArray ;
    NSTimer * _timer ;
    int  _count ;
}
//根据当前是星期几判断是不是有云彩；
-(void)changeCloudView:(int)tag;
@end





