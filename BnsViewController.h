//
//  BnsViewController.h
//  BnSBang
//
//  Created by qianfeng on 14-10-30.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BnsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _viewStatus;
    CGSize _screenSize;
    NSArray *_titleArr;
    UIView *_selectedView;
}

@property(nonatomic,copy)NSArray *bodyArr;

-(void)titleSettings;
-(void)startLoading;
-(void)topBtnAction:(UIButton *)sender;
- (void)getUrlWithBody:(NSString *)body cachePolicy:(NSURLRequestCachePolicy)policy;

@end
