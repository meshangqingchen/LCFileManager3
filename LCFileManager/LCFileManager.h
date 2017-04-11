//
//  LCFileManager.h
//  关于本地一些操作
//
//  Created by 3D on 17/4/7.
//  Copyright © 2017年 3D. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCFileManager : NSObject
/// 在一个文件夹下创建文件夹
+ (BOOL)createDirectoryWith:(NSString *)directoryName atDirectoryPath:(NSString *)path;

/// 在一个文件夹下创建文件
+ (BOOL)createFileWith:(NSString *)fileName atDirectoryPath:(NSString *)path andData:(NSData *)data;

/// 在一个存在的file下插入data (1如果文件不存在直接用插入的data创建file 如果插入的位置大于file的长度在file的最后面插入).
+ (void)insertData:(NSData *)data inFilePath:(NSString *)filePath atLocation:(unsigned long long)location;

/// 在一个file中追加data
+ (void)addData:(NSData *)data inFilePath:(NSString *)filePath;

/// 从一个文件夹 copy小file 到另一个文件夹 并给file命名
+ (void)fromSourceDirPath:(NSString *)sourceDirPath copyFileName:(NSString *)sourceFileName toTargetPathDirPath:(NSString *)targetDirPath targetFileName:(NSString *)targetFileName;

+ (void)copyFormFilePath:(NSString *)fromFilePath toFilePath:(NSString *)toFilePath;

/// 从一个文件夹 下copy大file 到另一个文件夹 并给file命名
/*
 copy 一个file 到另一个 file
 copy 一个文件夹 到 另一个文件夹...
 */



/// 删除一个文件夹下的文件夹或文件 removeItemAtPath
+ (BOOL)removeDirectoryOrFileWith:(NSString *)directoryOrfileName atDirectoryPath:(NSString *)path;

/// 得到一个文件夹下包括子文件夹所有的 Dirctory和file的绝对路径
+ (NSArray<NSString *> *)getDeepAllFileOrDirctoryPathAtDirectoryPath:(NSString *)path;
/// 得到一个文件夹下包括子文件夹所有的 Dirctory的路径
+ (NSArray<NSString *> *)getDeepAllDirctoryPathAtDirectoryPath:(NSString *)path;
/// 得到一个文件夹下包括子文件夹所有的 file的路径
+ (NSArray<NSString *> *)getDeepAllFilePathAtDirectoryPath:(NSString *)path;

/// 得到一个文件夹下不包括子文件夹所有的 Dirctory和file的绝对路径
+ (NSArray<NSString *> *)getShallowAllFileOrDirctoryPathAtDirectoryPath:(NSString *)path;
/// 得到一个文件夹下不包括子文件夹所有的 Dirctory的路径
+ (NSArray<NSString *> *)getShallowAllDirctoryPathAtDirectoryPath:(NSString *)path;
/// 得到一个文件夹下不包括子文件夹所有的 file的路径
+ (NSArray<NSString *> *)getShallowAllFilePathAtDirectoryPath:(NSString *)path;

/// 根据路径得到dir或者file的名字
+ (NSString *)getDirectoryOrFileNameWithPath:(NSString *)path;

/// 得到一个文件夹下包括子文件夹所有的 Dirctory和file的Name
+ (NSArray<NSString *> *)getDeepAllFileOrDirctoryNameAtDirectoryPath:(NSString *)path;
/// 得到一个文件夹下包括子文件夹所有的 Dirctory的Name
+ (NSArray<NSString *> *)getDeepAllDirctoryNameAtDirectoryPath:(NSString *)path;
/// 得到一个文件夹下包括子文件夹所有的 file的Name
+ (NSArray<NSString *> *)getDeepAllFileNameAtDirectoryPath:(NSString *)path;

/// 得到一个文件夹下不包括子文件夹所有的 Dirctory和file的Name
+ (NSArray<NSString *> *)getShallowAllFileOrDirctoryNameAtDirectoryPath:(NSString *)path;
/// 得到一个文件夹下不包括子文件夹所有的 Dirctory的Name
+ (NSArray<NSString *> *)getShallowAllDirctoryNameAtDirectoryPath:(NSString *)path;
/// 得到一个文件夹下不包括子文件夹所有的 file的Name
+ (NSArray<NSString *> *)getShallowAllFileNameAtDirectoryPath:(NSString *)path;

/// 得到一个文件夹的size或者一个file的size 单位是 字节.
+ (unsigned long long)getFileOrDirSizeWithPath:(NSString *)path;



/*
 从一个文件夹 拷贝file或者dir 到另一个 文件夹
 读取file
 */


/// 判断一个file或者fir是否存在
+ (BOOL)isExist:(NSString *)filePath;

/// 提供获取document路径
+ (NSString *)getDocumentPath ;
/// 获取cache缓存路径
+ (NSString *)getCachePath;
/// 获取temp路径
+ (NSString *)getTempPath;
@end
