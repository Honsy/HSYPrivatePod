//
//  HSYDataBase.h
//  AFNetworking
//
//  Created by 烽行意志 on 2018/5/22.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

#define Sqlite_Path [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"ddcb.sqlite"]

@interface HSYDataBase : NSObject

/**
 根据对象创建数据库表
 
 @param object 对象
 @return 是否成功失败
 */
+ (BOOL)createDataTableWithObject:(id)object;
/**
 插入某张表 一条数据
 
 @param name 表名
 @param dic Model字典
 @return 是否成功
 */
+ (BOOL)insertTableWithTableName:(NSString *)name modelDic:(NSDictionary *)dic;
/**
 插入某张表 多条数据
 
 @param name 表名
 @param array 字典数组
 @return 是否成功
 */
+ (BOOL)insertTableWithTableName:(NSString *)name modelArray:(NSArray<NSObject *> *)array;


/**
 更新某张表的某个数据  以Id为比较标准修改
 
 @param name 表名
 @param dic 字典model
 @return 是否成功
 */
+(BOOL)updateTableWithTableName:(NSString *)name modelDic:(NSDictionary *)dic;
/**
 查找某张表
 
 @param name 表名
 @return 是否查找成功
 */
+(NSMutableArray *)selectTableWithtableName:(NSString *)name;
@end
