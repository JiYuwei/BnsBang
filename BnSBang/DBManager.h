//
//  DBManager.h
//  Demo
//
//  Created by qianfeng on 14-10-13.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SrcModel.h"

@interface DBManager : NSObject

+(id)sharedManager;

-(void)insertItem:(SrcModel *)model;
-(void)deleteItem:(SrcModel *)model;
-(void)updateItem:(SrcModel *)model;
-(NSMutableArray *)fetchAllWithTable:(NSString *)table;
-(NSArray *)searchWithStr:(NSString *)str;

@end
