//
//  DBManager.m
//  Demo
//
//  Created by qianfeng on 14-10-13.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"

@implementation DBManager
{
    FMDatabase *_fmDb;
}

+(id)sharedManager
{
    static DBManager *_dbM=nil;
    if (_dbM==nil) {
        _dbM=[[DBManager alloc] init];
    }
    
    return _dbM;
}

-(id)init
{
    if (self=[super init]) {
        NSString *strPath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/src.db"];
        _fmDb=[[FMDatabase alloc] initWithPath:strPath];
        NSLog(@"%@",strPath);
        BOOL isSuccess=[_fmDb open];
        if (!isSuccess) {
            NSLog(@"open failed:%@",_fmDb.lastErrorMessage);
        }
        else{
            NSString *createSql=@"create table if not exists srcdata(serial integer primary key autoincrement, title varchar(20), imgname varchar(20))";
            BOOL success=[_fmDb executeUpdate:createSql];
            if (!success) {
                NSLog(@"create failed:%@",_fmDb.lastErrorMessage);
            }
        }
    }
    return self;
}

-(void)insertItem:(SrcModel *)model
{
    //防止sql注入
    NSString *insertSql=@"insert into srcdata(title, imgname) values(?,?)";
    //所有数据不可是基本数据类型
    BOOL success=[_fmDb executeUpdate:insertSql,model.title,model.imgName];
    if (!success) {
        NSLog(@"add error:%@",_fmDb.lastErrorMessage);
    }
}

-(void)deleteItem:(SrcModel *)model
{
    NSString *deleteSql=@"delete from user where srcid=?";
    BOOL success=[_fmDb executeUpdate:deleteSql,@(model.srcId)];
    if (!success) {
        NSLog(@"delete failed:%@",_fmDb.lastErrorMessage);
    }
}

-(void)updateItem:(SrcModel *)model
{
    NSString *updateSql=@"update srcdata set title = ? ,imgname = ? where srcid = ?";
    BOOL success=[_fmDb executeUpdate:updateSql,model.title,model.imgName,@(model.srcId)];
    if (!success) {
        NSLog(@"update failed:%@",_fmDb.lastErrorMessage);
    }
}

-(NSMutableArray *)fetchAllWithTable:(NSString *)table
{
    NSString *selectSql=[NSString stringWithFormat:@"select * from %@",table];
    FMResultSet *set=[_fmDb executeQuery:selectSql];
    NSMutableArray *myArr=[[NSMutableArray alloc] init];
    
    while ([set next]) {
        SrcModel *model=[[SrcModel alloc] init];
        model.srcId=[set intForColumn:@"serial"];
        model.title=[set stringForColumn:@"title"];
        model.imgName=[set stringForColumn:@"imgname"];
        
        [myArr addObject:model];
    }
    
    return myArr;
}

-(NSArray *)searchWithStr:(NSString *)str
{
    
    return nil;
}

@end
