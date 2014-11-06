//
//  EquipViewController.m
//  BnSBang
//
//  Created by qianfeng on 14-11-5.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "EquipViewController.h"
#import "MainViewController.h"
#import "JewelryViewController.h"
#import "BaguaViewController.h"

@interface EquipViewController ()
{
    UIButton *_weaponBtn;
    UIButton *_jewelryBtn;
    UIButton *_baguaBtn;
}
@end

@implementation EquipViewController

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
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgimg"]];
    // Do any additional setup after loading the view.
    [self createBgLogo];
    [self configBtns];
}

- (void)createBgLogo
{
    UIImageView *logoView=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-120, 0, 120, 60)];
    logoView.image=[UIImage imageNamed:@"bglogoblack"];
    [self.view addSubview:logoView];
}

- (void)configBtns
{
    CGFloat height1,height2,height3;
    CGFloat screenWidth=self.view.bounds.size.width;
    CGFloat screenHeight=self.view.bounds.size.height;
    BOOL is4_inch=screenHeight==568;
    NSLog(@"%.2f %d",screenHeight,is4_inch);
    
    height1=is4_inch?60:16.5;
    height2=is4_inch?192:133;
    height3=is4_inch?324:249.5;
    
    [self createBtns:_weaponBtn withFrame:CGRectMake(-screenWidth, height1, screenWidth, 100) angImage:@"weaponimg" Tag:300 Delay:0];
    [self createBtns:_jewelryBtn withFrame:CGRectMake(screenWidth, height2, screenWidth, 100) angImage:@"jewelryimg" Tag:301 Delay:0.3];
    [self createBtns:_baguaBtn withFrame:CGRectMake(-screenWidth, height3, screenWidth, 100) angImage:@"baguaimg" Tag:302 Delay:0.6];
    
}

- (void)createBtns:(UIButton *)button withFrame:(CGRect)frame angImage:(NSString *)imgName Tag:(NSInteger)tag Delay:(NSTimeInterval)delay
{
    button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    button.tag=tag;
    [button setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [UIView animateWithDuration:1.2 delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
        button.frame=CGRectMake(0, button.frame.origin.y, button.frame.size.width, button.frame.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.8 animations:^{
            button.alpha=0.85;
        }];
    }];
}

- (void)clickAction:(UIButton *)sender
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        sender.frame=CGRectMake(self.view.bounds.size.width, sender.frame.origin.y, sender.frame.size.width, sender.frame.size.height);
    } completion:^(BOOL finished) {
        if (sender.tag==300) {
            MainViewController *mainVC=[[MainViewController alloc] init];
            mainVC.title=@"武器";
            mainVC.edgesForExtendedLayout=UIRectEdgeNone;
            [self.navigationController pushViewController:mainVC animated:YES];
        }
        else if(sender.tag==301){
            JewelryViewController *jewelVC=[[JewelryViewController alloc] init];
            jewelVC.title=@"首饰";
            jewelVC.edgesForExtendedLayout=UIRectEdgeNone;
            [self.navigationController pushViewController:jewelVC animated:YES];
        }
        else if(sender.tag==302){
            BaguaViewController *baguaVC=[[BaguaViewController alloc] init];
            baguaVC.title=@"八卦牌";
            baguaVC.edgesForExtendedLayout=UIRectEdgeNone;
            [self.navigationController pushViewController:baguaVC animated:YES];
        }
        [UIView animateWithDuration:0.8 animations:^{
            sender.frame=CGRectMake(0, sender.frame.origin.y, sender.frame.size.width, sender.frame.size.height);
        }];
    }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
