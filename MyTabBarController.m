//
//  MyTabBarController.m
//  BnSBang
//
//  Created by qianfeng on 14-10-20.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "MyTabBarController.h"
#import "BnsViewController.h"
#import "MainViewController.h"
#import "BaguaViewController.h"
#import "SrcViewController.h"

@interface MyTabBarController ()
{
    BnsViewController *_bnsVC;
    MainViewController *_weaponVC;
    MainViewController *_jewelryVC;
    BaguaViewController *_baguaVC;
    SrcViewController *_srcVC;
}
@end

@implementation MyTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BOOL)shouldAutorotate
{
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.tabBar.selectedImageTintColor=TOPCOLOR;
    // Do any additional setup after loading the view.
    
    _bnsVC=[[BnsViewController alloc] init];
    _bnsVC.title=@"剑灵";
    _bnsVC.edgesForExtendedLayout=UIRectEdgeNone;
    UINavigationController *bnsCtrl=[[UINavigationController alloc] initWithRootViewController:_bnsVC];
    bnsCtrl.navigationBar.barStyle=UIBarStyleBlack;
    bnsCtrl.navigationBar.barTintColor=TOPCOLOR;
    bnsCtrl.navigationBar.tintColor=[UIColor whiteColor];
    bnsCtrl.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"剑灵" image:[UIImage imageNamed:@"main"] selectedImage:[UIImage imageNamed:@"main"]];
    
    _weaponVC=[[MainViewController alloc] init];
    _weaponVC.title=@"武器";
    _weaponVC.edgesForExtendedLayout=UIRectEdgeNone;
    UINavigationController *weaponCtrl=[[UINavigationController alloc] initWithRootViewController:_weaponVC];
    weaponCtrl.navigationBar.barStyle=UIBarStyleBlack;
    weaponCtrl.navigationBar.barTintColor=TOPCOLOR;
    weaponCtrl.navigationBar.tintColor=[UIColor whiteColor];
    weaponCtrl.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"武器" image:[UIImage imageNamed:@"weapon"] selectedImage:[UIImage imageNamed:@"weaponx"]];
    
    _jewelryVC=[[MainViewController alloc] init];
    _jewelryVC.title=@"首饰";
    _jewelryVC.edgesForExtendedLayout=UIRectEdgeNone;
    UINavigationController *jewelryCtrl=[[UINavigationController alloc] initWithRootViewController:_jewelryVC];
    jewelryCtrl.navigationBar.barStyle=UIBarStyleBlack;
    jewelryCtrl.navigationBar.barTintColor=TOPCOLOR;
    jewelryCtrl.navigationBar.tintColor=[UIColor whiteColor];
    jewelryCtrl.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"首饰" image:[UIImage imageNamed:@"jewelry"] selectedImage:[UIImage imageNamed:@"jewelry"]];
    
    _baguaVC=[[BaguaViewController alloc] init];
    _baguaVC.title=@"八卦牌";
    _baguaVC.edgesForExtendedLayout=UIRectEdgeNone;
    UINavigationController *baguaCtrl=[[UINavigationController alloc] initWithRootViewController:_baguaVC];
    baguaCtrl.navigationBar.barStyle=UIBarStyleBlack;
    baguaCtrl.navigationBar.barTintColor=TOPCOLOR;
    baguaCtrl.navigationBar.tintColor=[UIColor whiteColor];
    baguaCtrl.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"八卦牌" image:[UIImage imageNamed:@"baguax"] selectedImage:[UIImage imageNamed:@"baguax"]];
    
    _srcVC=[[SrcViewController alloc] initWithTable:@"srcdata"];
    _srcVC.title=@"成长树";
    _srcVC.edgesForExtendedLayout=UIRectEdgeNone;
    UINavigationController *srcCtrl=[[UINavigationController alloc] initWithRootViewController:_srcVC];
    srcCtrl.navigationBar.barStyle=UIBarStyleBlack;
    srcCtrl.navigationBar.barTintColor=TOPCOLOR;
    srcCtrl.navigationBar.tintColor=[UIColor whiteColor];
    srcCtrl.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"成长树" image:[UIImage imageNamed:@"sourcex"] selectedImage:[UIImage imageNamed:@"sourcex"]];
    
    NSArray *controllers=@[bnsCtrl,weaponCtrl,jewelryCtrl,baguaCtrl,srcCtrl];
    self.viewControllers=controllers;
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
