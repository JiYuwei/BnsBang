//
//  BnsViewController.h
//  BnSBang
//
//  Created by qianfeng on 14-10-30.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyScrollView.h"

@interface BnsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _viewStatus;
    UITableView *_tableView;
    CGSize _screenSize;
    NSArray *_titleArr;
    UIView *_selectedView;
    MyScrollView *_scrollView;
    NSMutableArray *_scrollArray;
}

@property(nonatomic,copy)NSArray *bodyArr;
@property(nonatomic,copy)NSString *scrollUrl;

-(void)titleSettings;
-(void)startLoading;
-(void)createTopItems;
-(void)createTableView;
-(void)createTableViewWithFrame:(CGRect)frame;
-(void)topBtnAction:(UIButton *)sender;
-(void)getUrlWithBody:(NSString *)body cachePolicy:(NSURLRequestCachePolicy)policy;

@end
