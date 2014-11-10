//
//  PhotoViewController.m
//  剑灵帮帮
//
//  Created by qianfeng on 14-11-9.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "PhotoViewController.h"
#import "CollectLayOut.h"
#import "CollectViewCell.h"
#import "ImageModel.h"
#import "UIImageView+WebCache.h"
static NSInteger _imageStatus=0;

@interface PhotoViewController ()
{
    UICollectionView *_collectView;
    NSMutableArray *_dataArray;
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
    _dataArray=[[NSMutableArray alloc] init];
    [self loadImageViewForColumn:0 andPage:1];
}

-(void)loadImageViewForColumn:(NSInteger)column andPage:(NSInteger)page
{
    NSString *imgUrl=[NSString stringWithFormat:PHOTO_URL,column,page];
    [[HttpRequestManager sharedManager] GETUrl:[NSURL URLWithString:imgUrl] cachePolicy:NSURLRequestReturnCacheDataElseLoad completed:^(NSData *data) {
        NSArray *srcArray=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",srcArray);
        if (page==1) {
            [_dataArray removeAllObjects];
        }
        
        for (NSDictionary *dic in srcArray) {
            ImageModel *imgModel=[[ImageModel alloc] init];
            [imgModel setValuesForKeysWithDictionary:dic];
            imgModel.uid=dic[@"id"];
            //imgModel.cellHeight=200;
            [_dataArray addObject:imgModel];
        }
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            dispatch_apply(_dataArray.count, dispatch_get_global_queue(0, 0), ^(size_t n) {
                ImageModel *model = _dataArray[n];
                NSError *error=nil;
                NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:model.cover_url] options:NSDataReadingMappedIfSafe error:&error];
                if (error) {
                    NSLog(@"%@",error);
                }
                else{
                    UIImage *image=[UIImage imageWithData:data];
                    model.image=image;
                    model.cellHeight=image.size.height/image.size.width*150+10;
                }
            });
            dispatch_async(dispatch_get_main_queue(), ^{
                [_collectView reloadData];
                [self stopLoading];
            });
    });
        
        
    } failed:^{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"哎呀!" message:@"您的网络有些问题，请稍后再试。" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
        [self stopLoading];
    }];
}

-(void)createTableView
{
    CollectLayOut *layout=[[CollectLayOut alloc] init];
    layout.dataArray=_dataArray;
    
    _collectView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height-40-64-49) collectionViewLayout:layout];
    _collectView.backgroundColor=[UIColor clearColor];
    _collectView.dataSource=self;
    _collectView.delegate=self;
    
    [_collectView registerClass:[CollectViewCell class] forCellWithReuseIdentifier:@"collectid"];
    [self.view addSubview:_collectView];
    
    NSArray *nils=[[NSBundle mainBundle] loadNibNamed:@"RefreshView" owner:self options:nil];
    _refreshView=[nils firstObject];
    //_refreshView.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [_refreshView setupWithOwner:_collectView delegate:self];
    [self startLoading];
}

-(void)topBtnAction:(UIButton *)sender
{
    [self startLoading];
    _imageStatus=sender.tag-20;
    
    [self loadImageViewForColumn:_imageStatus andPage:1];
    
    for (int i=0; i<5; i++) {
        UIButton *btn=(UIButton *)[self.view viewWithTag:20+i];
        btn.selected=NO;
    }
    sender.selected=YES;
    [UIView animateWithDuration:0.4 animations:^{
        _selectedView.frame=CGRectMake((sender.tag-20)*_screenSize.width/5, 37, _screenSize.width/5, 3);
    }];
}



#pragma mark - UICollectionViewDataSource:
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"collectid" forIndexPath:indexPath];
    cell.model=_dataArray[indexPath.row];
    
    return cell;
}


-(void)refreshViewDidCallBack
{
    NSLog(@"call");
    [self startLoading];
    [self loadImageViewForColumn:_imageStatus andPage:1];
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
