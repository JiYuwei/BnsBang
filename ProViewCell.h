//
//  ProViewCell.h
//  BnSBang
//
//  Created by qianfeng on 14-11-6.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProModel.h"

@interface ProViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *zzView;
@property (weak, nonatomic) IBOutlet UIImageView *zyView;

@property(nonatomic,strong)ProModel *model;

- (IBAction)onClick:(UIButton *)sender;

@end
