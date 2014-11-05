//
//  BnsViewController.m
//  BnSBang
//
//  Created by qianfeng on 14-10-30.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "BnsViewController.h"
#import "HttpRequestManager.h"
#import "BnsModel.h"
#import "BnsViewCell.h"
#import "UIImageView+WebCache.h"
#import "DetailViewController.h"
#import "RefreshView.h"
static NSInteger _viewStatus=0;

@interface BnsViewController () <RefreshViewDelegate>
{
    CGSize _screenSize;
    UIView *_topView;
    UIView *_selectedView;
    UITableView *_tableView;
    UIActivityIndicatorView *_loadView;
    UILabel *_noMoreLabel;
    RefreshView *_refreshView;
    
    NSMutableArray *_dataArray;
}
@end

@implementation BnsViewController

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
    _screenSize=self.view.bounds.size;
    self.view.window.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    // Do any additional setup after loading the view.
    [self prepareData];
    [self uiconfig];
}

- (void)getUrlWithBody:(NSString *)body cachePolicy:(NSURLRequestCachePolicy)policy
{
    [[HttpRequestManager sharedManager]POSTUrl:[NSURL URLWithString:POST_URL] WithBody:body cachePolicy:policy completed:^(NSData *data) {
        NSArray *array=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (_dataArray.count!=0 && [[_dataArray[0] uid] isEqualToString:array[0][@"id"]]) {
            NSLog(@"%@ %@",[_dataArray[0] uid],array[0][@"id"]);
        }
        else{
            [_dataArray removeAllObjects];
            for (NSDictionary *dic in array) {
                BnsModel *bnsModel=[[BnsModel alloc] init];
                [bnsModel setValuesForKeysWithDictionary:dic];
                bnsModel.uid=dic[@"id"];
                [_dataArray addObject:bnsModel];
                [_tableView reloadData];
                _tableView.tableFooterView=_noMoreLabel;
            }
        }
        [self stopLoading];
        //NSLog(@"%@",_dataArray);
    } failed:^{
        NSLog(@"load failed");
        [_loadView stopAnimating];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"哎呀!" message:@"您的网络有些问题，请稍后再试。" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
        [self stopLoading];
    }];
}


- (void)prepareData
{
    _dataArray=[[NSMutableArray alloc] init];
    [self getUrlWithBody:BODY_1 cachePolicy:NSURLRequestReturnCacheDataElseLoad];
}

- (void)uiconfig
{
    _topView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, _screenSize.width, 40)];
    //_topView.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:_topView];
    
    _selectedView=[[UIView alloc] initWithFrame:CGRectMake(0, 37, _screenSize.width/5, 3)];
    _selectedView.backgroundColor=TOPCOLOR;
    [_topView addSubview:_selectedView];
    
    [self createTopItems];
    [self createTableView];
    
    _noMoreLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    _noMoreLabel.font=[UIFont systemFontOfSize:15];
    _noMoreLabel.textAlignment=NSTextAlignmentCenter;
    _noMoreLabel.textColor=[UIColor grayColor];
    _noMoreLabel.text=@"已经是最后一条了";
    
//    _loadView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    _loadView.frame=CGRectMake(0, 0, 40, 40);
//    _tableView.tableFooterView=_loadView;
//    [_loadView startAnimating];
}

- (void)createTopItems
{
    NSArray *titleArr=@[@"新闻",@"活动",@"公告",@"韩服",@"更多"];
    for (int i=0; i<5; i++) {
        UIButton *topBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        topBtn.tag=20+i;
        topBtn.highlighted=NO;
        topBtn.frame=CGRectMake(i*_screenSize.width/5, 0, _screenSize.width/5, 40);
        topBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        [topBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        topBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        [topBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [topBtn setTitleColor:TOPCOLOR forState:UIControlStateSelected];
        [topBtn addTarget:self action:@selector(topBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:topBtn];
        
        if (i==0) {
            [topBtn setSelected:YES];
        }
    }
}

-(void)topBtnAction:(UIButton *)sender
{
//    [_dataArray removeAllObjects];
//    [_tableView reloadData];
//    [_refreshView setupWithOwner:_tableView delegate:self];
//    _tableView.tableFooterView=_loadView;
//    [_loadView startAnimating];
    [self startLoading];
    NSArray *bodyArr=@[BODY_1,BODY_2,BODY_3,BODY_4,BODY_5];
    _viewStatus=sender.tag-20;

    [self getUrlWithBody:bodyArr[_viewStatus] cachePolicy:NSURLRequestReturnCacheDataElseLoad];
    
    for (int i=0; i<5; i++) {
        UIButton *btn=(UIButton *)[self.view viewWithTag:20+i];
        btn.selected=NO;
    }
    sender.selected=YES;
    [UIView animateWithDuration:0.4 animations:^{
        _selectedView.frame=CGRectMake((sender.tag-20)*_screenSize.width/5, 37, _screenSize.width/5, 3);
    }];
}


- (void)createTableView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height-40-64-49) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
    NSArray *nils=[[NSBundle mainBundle] loadNibNamed:@"RefreshView" owner:self options:nil];
    _refreshView=[nils firstObject];
    _refreshView.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [_refreshView setupWithOwner:_tableView delegate:self];
    [self startLoading];
}

- (void)startLoading
{
    [_refreshView startLoading];
}

- (void)stopLoading
{
    [_refreshView stopLoading];
}

#pragma mark - RefreshViewDelegate:
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_refreshView scrollViewWillBeginDragging:scrollView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshView scrollViewDidScroll:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //if ([_refreshView.refreshStatusLabel.text isEqualToString:REFRESH_RELEASED_STATUS]) {
    [_refreshView scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
        //[self startLoading];
    //}
}

-(void)refreshViewDidCallBack
{
    NSLog(@"call back");
    [self startLoading];
    NSArray *bodyArr=@[BODY_1,BODY_2,BODY_3,BODY_4,BODY_5];
    [self getUrlWithBody:bodyArr[_viewStatus] cachePolicy:NSURLRequestReloadIgnoringCacheData];
}

#pragma mark - UITableViewDataSource & Delegate:
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    BnsViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"BnsViewCell" owner:self options:nil]firstObject];
    }
    
    if (_dataArray.count!=0) {
        cell.model=_dataArray[indexPath.row];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *detailVC=[[DetailViewController alloc] init];
    detailVC.model=_dataArray[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
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