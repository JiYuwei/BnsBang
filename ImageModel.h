//
//  ImageModel.h
//  剑灵帮帮
//
//  Created by qianfeng on 14-11-10.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "BaseModel.h"

@interface ImageModel : BaseModel

@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *cover_url;

@property(nonatomic,strong)UIImage *image;
@property (nonatomic,assign)CGFloat cellHeight;

@end
