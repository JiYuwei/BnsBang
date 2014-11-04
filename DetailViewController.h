//
//  DetailViewController.h
//  BnSBang
//
//  Created by qianfeng on 14-11-3.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BnsModel.h"

@interface DetailViewController : UIViewController <UIWebViewDelegate>

@property(nonatomic,strong)BnsModel *model;

@end
