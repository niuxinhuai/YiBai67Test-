//
//  ZYButton.h
//  YiBai67Test
//
//  Created by songxianxian on 16/2/16.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYImageView.h"
@interface ZYButton : UIButton

//给Button类扩充一个属性  记录btn是在上面还是下面
@property(nonatomic,assign) BOOL isAtTop;

//记录按钮初始的坐标位置
@property(nonatomic,assign) CGPoint originCenter;

//记录与按钮相配对的密码图片
@property(nonatomic,retain) ZYImageView *selectedPswImage;

//记录按钮的角度
@property(nonatomic,assign) int angle;

//记录按钮 偏移的单位
@property(nonatomic,assign) CGPoint offSet;

@end





