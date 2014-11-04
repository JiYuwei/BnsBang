//
//  BnsViewCell.m
//  BnSBang
//
//  Created by qianfeng on 14-11-3.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "BnsViewCell.h"
#import "UIImageView+WebCache.h"

@implementation BnsViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setModel:(BnsModel *)model
{
    if (_model!=model) {
        _model=model;
    }
    [_titleImg setImageWithURL:[NSURL URLWithString:_model.pictureUrl] placeholderImage:[UIImage imageNamed:@"image"]];
    _titleLabel.text=_model.title;
    _dateLabel.text=_model.publishTime;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
