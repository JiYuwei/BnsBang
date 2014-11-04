//
//  MainViewCell.m
//  BnSBang
//
//  Created by qianfeng on 14-11-4.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "MainViewCell.h"

@implementation MainViewCell

- (void)awakeFromNib
{
    // Initialization code
}

-(void)setModel:(MainModel *)model
{
    if (_model!=model) {
        _model=model;
    }
    _imgView.image=[UIImage imageNamed:_model.imgName];
    _nameLabel.text=_model.name;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
