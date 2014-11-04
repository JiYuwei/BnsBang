//
//  SrcViewController.h
//  BnSBang
//
//  Created by qianfeng on 14-10-20.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SrcViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,copy)NSString *tableName;

-(id)initWithTable:(NSString *)table;

@end
