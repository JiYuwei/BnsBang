//
//  PhotoViewController.m
//  剑灵帮帮
//
//  Created by qianfeng on 14-11-9.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()
{
    UICollectionView *_collectView;
}
@end

@implementation PhotoViewController

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

- (void)titleSettings
{
    _titleArr=@[@"最新",@"捏脸",@"截图",@"COS",@"手绘"];
}

-(void)prepareData
{
    NSLog(@"prepare nil");
}

-(void)createTableView
{
    UICollectionViewLayout *layout=[[UICollectionViewLayout alloc] init];
    _collectView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height-40-64-49) collectionViewLayout:layout];
    _collectView.dataSource=self;
    _collectView.delegate=self;
    [self.view addSubview:_collectView];
}

#pragma mark - UICollectionViewDataSource:
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
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
