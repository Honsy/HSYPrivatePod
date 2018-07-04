//
//  HSYDataBase.m
//  AFNetworking
//
//  Created by 烽行意志 on 2018/5/22.
//

#import "HSYDataBase.h"

@implementation HSYDataBase

#pragma mark 根据对象创建表
+ (BOOL)createDataTableWithObject:(id)object{
    
    //    __block BOOL res = NO;
    //    __weak typeof(self)weak_self = self;
    //    //获取队列
    //    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:ddcb_sqlite_path];
    //    [queue inDatabase:^(FMDatabase *db) {
    //        __strong typeof(weak_self)strong_self = weak_self;
    //        res = [strong_self insert:dic intoTable:name error:nil db:db];
    //    }];
    //
    //    return res;
    return YES;
}
#pragma mark 插入某张表一条数据
+ (BOOL)insertTableWithTableName:(NSString *)name modelDic:(NSDictionary *)dic{
    __block BOOL res = NO;
    __weak typeof(self)weak_self = self;
    //获取队列
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:Sqlite_Path];
    [queue inDatabase:^(FMDatabase *db) {
        __strong typeof(weak_self)strong_self = weak_self;
        res = [strong_self insert:dic intoTable:name error:nil db:db];
    }];
    return res;
    
}

#pragma mark 插入某张表多条数据
+ (BOOL)insertTableWithTableName:(NSString *)name modelArray:(NSArray *)array{
    __block BOOL res = NO;
    __weak typeof(self)weak_self = self;
    //获取队列
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:Sqlite_Path];
    [queue inDatabase:^(FMDatabase *db) {
        __strong typeof(weak_self)strong_self = weak_self;
        res = [strong_self insertWithArray:array intoTable:name error:nil db:db];
    }];
    return res;
}

#pragma mark 查找某张表数据
+(NSMutableArray *)selectTableWithtableName:(NSString *)name{
    __block NSMutableArray * res = [NSMutableArray array];
    __weak typeof(self)weak_self = self;
    //获取队列
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:Sqlite_Path];
    [queue inDatabase:^(FMDatabase *db) {
        __strong typeof(weak_self)strong_self = weak_self;
        res = [strong_self selectTableName:name db:db];
    }];
    return res;
}

//+(BOOL)create:(id)object{
//    BOOL res = NO;
//
//
//
//    return res;
//}

//插入字典 单条数据使用
+ (BOOL)insert:(NSDictionary *)dictionary intoTable:(NSString *)tableName error:(NSError * __autoreleasing *)error db:(FMDatabase *)db
{
    BOOL res = NO;
    NSMutableString *clounmStr = [NSMutableString string];
    NSMutableString *placeholdStr = [NSMutableString string];
    NSMutableArray *values = [NSMutableArray array];
    
    int i = 0;
    
    for (NSString *key in dictionary.allKeys) {
        
        if (![db columnExists:key inTableWithName:tableName]) {
            i++;
            continue;
        }
        [clounmStr appendFormat:@"%@",key];
        [placeholdStr appendString:@"?"];
        
        [values addObject:dictionary[key]];
        
        if (i < dictionary.allKeys.count - 1) {
            [clounmStr appendString:@","];
            [placeholdStr appendString:@","];
        }
        i++;
    }
    
    if (values.count > 0 && clounmStr.length) {
        NSString *sql = [NSString stringWithFormat:@"insert into %@ (%@) values (%@);",tableName,clounmStr,placeholdStr];
        res = [db executeUpdate:sql values:values error:error];
    }
    return res;
}

//插入数组 多条数据使用
+ (BOOL)insertWithArray:(NSArray<NSDictionary *> *)modelDictArray intoTable:(NSString *)tableName error:(NSError * __autoreleasing *)error db:(FMDatabase *)db{
    
    static NSString * insertAllSql;
    
    BOOL res = NO;
    
    int j = 0;
    
    
    //1 对Model数组进行循环
    for (NSDictionary * dict in modelDictArray) {
        
        NSMutableString *clounmStr = [NSMutableString string];
        NSMutableString *placeholdStr = [NSMutableString string];
        int i = 0;
        //2 对Model字典进行Key循环
        for (NSString *key in dict.allKeys) {
            
            if (![db columnExists:key inTableWithName:tableName]) {
                i++;
                continue;
            }
            [clounmStr appendFormat:@"%@",key];
            [placeholdStr appendString:[NSString stringWithFormat:@"'%@'",dict[key]]];
            
            if (i < dict.allKeys.count - 1) {
                
                
                [clounmStr appendString:@","];
                [placeholdStr appendString:@","];
            }
            i++;
        }
        
        if (j==0) {
            if (clounmStr.length) {
                NSString *sql = [NSString stringWithFormat:@"insert into %@ (%@) values (%@)",tableName,clounmStr,placeholdStr];
                insertAllSql = sql;
            }
        }else{
            insertAllSql = [NSString stringWithFormat:@"%@,(%@)",insertAllSql,placeholdStr];
        }
        
        
        j++;
        
    }
    
    res = [db executeUpdate:insertAllSql];
    
    
    return res;
}


//查找某张表
+(NSMutableArray *)selectTableName:(NSString *)name db:(FMDatabase *)db{
    NSMutableArray * resultArr = [NSMutableArray array];
    
    if ([db open]) {
        // 根据请求参数查询数据
        FMResultSet *resultSet = nil;
        
        resultSet = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@",name]];
        //遍历
        while ([resultSet next]) {
            [resultArr addObject:[resultSet resultDictionary]];
        }
        
    }
    
    return resultArr;
    
}
@end
