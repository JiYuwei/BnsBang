//
//  BBSDetailViewCell.h
//  剑灵帮帮
//
//  Created by qianfeng on 14-11-13.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBSDetailModel.h"

@interface BBSDetailViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIImageView *headerView;

@property(nonatomic,strong)BBSDetailModel *model;

@end
