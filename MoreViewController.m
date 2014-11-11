//
//  MoreViewController.m
//  剑灵帮帮
//
//  Created by qianfeng on 14-11-11.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "MoreViewController.h"
#import "UIImageView+WebCache.h"
#import "ImageModel.h"

@interface MoreViewController ()
{
    CGSize _cSize;
    UIScrollView *_mainView;
}
@end

@implementation MoreViewController

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
    _cSize=[[UIScreen mainScreen]bounds].size;
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor blackColor];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(backClick)];
    // Do any additional setup after loading the view.
    NSLog(@"%@",_dataArray);
    [self createTopView];
    [self createMainView];
}

-(void)backClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)createTopView
{
    
}

-(void)createMainView
{
    _mainView=[[UIScrollView alloc] initWithFrame:self.view.bounds];
    _mainView.pagingEnabled=YES;
    _mainView.delegate=self;
    _mainView.showsVerticalScrollIndicator=NO;
    _mainView.showsHorizontalScrollIndicator=NO;
    
    _mainView.contentSize=CGSizeMake(_cSize.width*_dataArray.count, _cSize.height);
    _mainView.contentOffset=CGPointMake(_cSize.width*_imgNum, 0);
    [self.view addSubview:_mainView];
    
    for (NSInteger i=0; i<_dataArray.count; i++) {
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(_cSize.width*i, 0, _cSize.width, _cSize.height)];
        //imgView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgimg"]];
        imgView.userInteractionEnabled=YES;
        imgView.contentMode=UIViewContentModeScaleAspectFit;
        [imgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backOnClick:)]];
        [_mainView addSubview:imgView];
        [imgView setImageWithURL:[_dataArray[i] url] placeholderImage:[UIImage imageNamed:@"bgimg"]];
    }
}

- (void)backOnClick:(UITapGestureRecognizer *)recognizer
{
    BOOL isHidden=self.navigationController.navigationBarHidden;
    
    [self.navigationController setNavigationBarHidden:isHidden?NO:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:isHidden?YES:NO withAnimation:UIStatusBarAnimationFade];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"OKOKOKOK");
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
