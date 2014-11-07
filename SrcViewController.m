//
//  SrcViewController.m
//  BnSBang
//
//  Created by qianfeng on 14-10-20.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "SrcViewController.h"
#import "SecViewController.h"

@interface SrcViewController ()

@end

@implementation SrcViewController

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
    
}

-(void)configBtns
{
    CGSize screenSize=CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    CGPoint middlePoint=CGPointMake(self.view.bounds.size.width/2, (self.view.bounds.size.height-64-49)/2);
    //NSLog(@"%.2f,%.2f",middlePoint.x,middlePoint.y);
    UIButton *baseBtn;
    [self createBtns:baseBtn withFrame:CGRectMake(screenSize.width, middlePoint.y-40, screenSize.width, 40) angImage:@"shuiyue" Tag:0 Delay:0 Enabled:NO];
    [self createBtns:baseBtn withFrame:CGRectMake(-screenSize.width, middlePoint.y, screenSize.width, 40) angImage:@"baiqing" Tag:0 Delay:0 Enabled:NO];
    //水月
    [self createBtns:baseBtn withFrame:CGRectMake(-screenSize.width, 0, screenSize.width/2, 187.5) angImage:nil Tag:0 Delay:1 Enabled:YES];
    [self createBtns:baseBtn withFrame:CGRectMake(screenSize.width, 0, screenSize.width/2, 187.5) angImage:nil Tag:0 Delay:1 Enabled:YES];
    //白青
    [self createBtns:baseBtn withFrame:CGRectMake(-screenSize.width, middlePoint.y+40, screenSize.width/2, 187.5) angImage:nil Tag:0 Delay:1 Enabled:YES];
    [self createBtns:baseBtn withFrame:CGRectMake(screenSize.width, middlePoint.y+40, screenSize.width/2, 187.5) angImage:nil Tag:0 Delay:1 Enabled:YES];
    
}

-(void)clickAction:(UIButton *)sender
{
    NSLog(@"clickRewrite");
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
