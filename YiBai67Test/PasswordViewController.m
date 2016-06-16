//
//  PasswordViewController.m
//  YiBai67Test
//
//  Created by songxianxian on 16/2/16.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#import "PasswordViewController.h"
#import "ZYButton.h"
#import "ZYImageView.h"
#import "MainViewController.h"
@interface PasswordViewController ()

@end

@implementation PasswordViewController

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
    UIImageView *bgImageView =[[UIImageView alloc]initWithFrame:self.view.frame];
    //添加图片
    bgImageView.image=[UIImage imageNamed:@"bg.jpg"];
   //保存到view
    [self.view addSubview:bgImageView];
    
    //创建10个小按钮
    [self createTenSmallBtn];
    
    //创建密码图片
    [self createPswImageView];
    
   
    
}

//创建密码图片
-(void)createPswImageView{
    
    //生成0~9范围内四个不同的随机数？
    //1.创建1个包含0~9的数字数组 2.随机从数字数组中取出一个数据，为了保证下次从数字数组中再也取不到该数据，我们将这个数据从数组中删除
    
    //a.准备数据数组
    NSMutableArray *numberArr =[[NSMutableArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    //b.for循环，从数据数组中随机四个数字,并创建相应的密码图片
    //inteval间隔
    float inteval=(320-4*50)/5.0;
    //创建密码图片数组是为了将来在btnClick:方法中可以获取所有的密码图片
    _pswImageArr =[[NSMutableArray alloc]initWithCapacity:0];
    for (int i=0; i<4; i++) {
        
        //随机一个索引
        //注意：数组中的元素个数在不断改变，随机索引时注意不要数组越界
        int index =arc4random()%numberArr.count;
        
        //random随机 取出该索引下的数字对象
        int random =[numberArr[index] intValue];
        
        //为了保证下次再也取不到该数字，将这个数字从数组中删除
        [numberArr removeObjectAtIndex:index];
      
        
        //创建密码图片imageView
        ZYImageView *pswImageView =[[ZYImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"b_%d.png",random]]];
        //刚创建好的密码图片上面是 没有按钮的
        pswImageView.isHaveBtn=NO;
        
        //将密码图片的tag值设置为与它所展示的数字相同，是为了将来方便判断输入的密码是否正确
        pswImageView.tag =random;
        
        pswImageView.frame =CGRectMake(inteval+i*(inteval+50), 100, 50, 50);
        [self.view addSubview:pswImageView];
        //将密码图片放入数组
        [_pswImageArr addObject:pswImageView];
        
        
    }
 
}


//创建10个小按钮
-(void)createTenSmallBtn{
    //创建10个小按钮
    float interval =(320-5*40)/6.0;
    for (int i=0; i<10; i++) {
        int rank =i%5;
        int row =i/5;
        float x =interval +rank*(40+interval);
        float y =300 +row*(40+interval);
        ZYButton *btn =[ZYButton buttonWithType:UIButtonTypeCustom];
        //frame框架
        btn.frame =CGRectMake(x, y, 40, 40);
        
        
        //自定义Button类扩充的属性
        //刚创建好的btn是在下面的
        btn.isAtTop=NO;
        
        //记录btn初始的中心点坐标，是为了将来btn下去的时候可以回到原来的位置，不用重新计算了
        btn.originCenter =btn.center;
        
        
        //i      0123456789
        //i+1    12345678910  (i+1)%10
        //图片名字 1234567890
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"s_%d.png",(i+1)%10]] forState:UIControlStateNormal];
        //将btn的tag值设置为与其展示的数字相同
        btn.tag =(i+1)%10;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        
    }
}

//10个小按钮绑定的方法
-(void)btnClick:(ZYButton*)btn{
    
    //第一件事  btn是应该上去还是下来？
    
    if (btn.isAtTop==NO) { //btn是在下面的，执行上去的逻辑
        
        //拿到4个密码图片，从最左边的开始找，找到1个上面没有按钮的密码图片为止
        for (ZYImageView *pswImageView in _pswImageArr) {
            
            if (pswImageView.isHaveBtn==NO) {//密码图片上没有按钮，是我们想找的
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                btn.center =pswImageView.center;
                [UIView commitAnimations];
                
                //按钮上去之后，相关的属性发生变化
                btn.isAtTop =YES;
                pswImageView.isHaveBtn=YES;
                
                //让上去的btn 记录一下与自己相配对的密码图片(也可以记录密码图片在数组中索引)
                btn.selectedPswImage =pswImageView;
                
                //判断密码是否正确
                if (btn.tag==pswImageView.tag)
                {
                    //密码正确
                    _rightCount++;
                    
                    //4次密码输入正确，进入主界面
                    if (_rightCount==1)
                    {
                        NSLog(@"进入主界面");
                        
                        [self performSelector:@selector(goToMainVC) withObject:nil afterDelay:1];
                        //Delay:延迟
                        
                    }
                   // NSLog(@"正确次数--%d",_rightCount);
                }
                //将子视图放在前面
                [self.view bringSubviewToFront:btn];
                //从索引为0的密码图片开始找，找到1个没有按钮的密码图片,终止遍历
                break;
            }
            
        }

    }else{ //btn是在上面的，要执行下去的逻辑
        
        //按钮回到原来的坐标位置
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        btn.center =btn.originCenter;
        [UIView commitAnimations];
        
        //按钮下来之后，相应的属性也要发生变化
        btn.isAtTop=NO;
        //获取该btn对应的密码图片，改其属性
        btn.selectedPswImage.isHaveBtn=NO;
        
        //下去时，如果按钮与密码图片数字一致，让正确次数再减1
        if (btn.tag==btn.selectedPswImage.tag)
        {
            
            _rightCount--;
            
        }
    }
}

//进入主界面
-(void)goToMainVC{
    
    //经分析，主界面应该是在导航控制器中
    MainViewController *mainVC =[[MainViewController alloc]init];
    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:mainVC];
    
    //找window
    UIWindow *window =[[[UIApplication sharedApplication]delegate]window];
    //翻页动画效果
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:window cache:YES];
    [UIView commitAnimations];
    //切换window的根视图控制器
    window.rootViewController =nav;
    
    
}



@end





