//
//  CollectViewCell.m
//  剑灵帮帮
//
//  Created by qianfeng on 14-11-10.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "CollectViewCell.h"
#import "UIImageView+WebCache.h"

@implementation CollectViewCell
{
    UIImageView *_imgv;
    UILabel *_titleLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imgv=[[UIImageView alloc] init];
        [self.contentView addSubview:_imgv];
        
        _titleLabel=[[UILabel alloc] init];
        _titleLabel.backgroundColor=[UIColor blackColor];
        _titleLabel.font=[UIFont fontWithName:@"Arial" size:11];
        _titleLabel.numberOfLines=2;
        _titleLabel.textColor=[UIColor lightGrayColor];
        _titleLabel.alpha=0.8;
        [_imgv addSubview:_titleLabel];
    }
    return self;
}

-(void)setModel:(ImageModel *)model
{
    if (_model!=model) {
        _model=model;
    }
    
    _imgv.frame = CGRectMake(5, 5, 150, self.contentView.bounds.size.height-10);
    _imgv.image=_model.image;
    //[_imgv setImageWithURL:[NSURL URLWithString:_model.cover_url]];
    _titleLabel.frame=CGRectMake(0, _imgv.frame.size.height-30, 150, 30);
    _titleLabel.text=_model.title;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
