//
//  SrcViewController.m
//  BnSBang
//
//  Created by qianfeng on 14-10-20.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "SrcViewController.h"
#import "DBManager.h"
#import "SecViewController.h"

@interface SrcViewController ()
{
    UITableView *_tableView;
    NSMutableArray *_srcDataArr;
}
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

-(id)initWithTable:(NSString *)table
{
    if (self=[super init]) {
        _tableName=table;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgimg"]];
    //[self loadPrepareData];
    //[self createUI];
}

- (void)loadPrepareData
{
    _srcDataArr=[[DBManager sharedManager] fetchAllWithTable:_tableName];
}

- (void)createUI
{
    _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
}


#pragma mark - UITableViewDataSource:
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _srcDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell=[_tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.textLabel.text=[_srcDataArr[indexPath.row] title];
    cell.imageView.image=[UIImage imageNamed:[_srcDataArr[indexPath.row] imgName]];
    
    return cell;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 80;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *strPath=[[NSBundle mainBundle] pathForResource:@"PropertyList" ofType:@"plist"];
    NSDictionary *srcDict=[[NSDictionary alloc] initWithContentsOfFile:strPath];
    
    SrcViewController *srcVC=[[SrcViewController alloc] initWithTable:srcDict[_tableName][indexPath.row]];
    [self.navigationController pushViewController:srcVC animated:YES];
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
