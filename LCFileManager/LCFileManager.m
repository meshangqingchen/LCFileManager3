//
//  LCFileManager.m
//  关于本地一些操作
//
//  Created by 3D on 17/4/7.
//  Copyright © 2017年 3D. All rights reserved.
//

#import "LCFileManager.h"

@implementation LCFileManager
/// 在一个文件夹下创建文件夹
+ (BOOL)createDirectoryWith:(NSString *)directoryName atDirectoryPath:(NSString *)path{
    //第一个参数是条件,如果第一个参数不满足条件,就会记录并打印后面的字符串
    BOOL isDirectory ;
    NSString *directoryPath = [path stringByAppendingPathComponent:directoryName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:&isDirectory]) {
        if (isDirectory) {
            NSCAssert(NO, @"文件夹已存在");
        }else{
            NSCAssert(NO, @"当前目录下有和文件夹重名的文件");
        }
    }
    return [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
}

/// 在一个文件夹下创建文件
+ (BOOL)createFileWith:(NSString *)fileName atDirectoryPath:(NSString *)path andData:(NSData *)data{
    NSCAssert([[NSFileManager defaultManager] fileExistsAtPath:path],@"你要在这个文件夹里创建文件这个文件夹不存在啊老铁");
    BOOL isDirectory ;
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory]) {
        if (isDirectory) {
            NSCAssert(NO, @"当前目录下有和file文件重名的文件夹");
        }else{
            NSCAssert(NO, @"当前目录下有和file重名的文");
        }
    }
    return [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
}

/// 在一个存在的file下插入data (1如果文件不存在直接用插入的data创建file 如果插入的位置大于file的长度在file的最后面插入).
+ (void)insertData:(NSData *)data inFilePath:(NSString *)filePath atLocation:(unsigned long long)location{
    
    BOOL isDirectory ;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory]) {
        if (isDirectory) {
            NSCAssert(NO, @"文件夹怎嘛能在文件夹插入data呢..");
        }else{
            
            NSFileHandle *targetWriteHandle=[NSFileHandle fileHandleForWritingAtPath:filePath];
            [targetWriteHandle truncateFileAtOffset:10];
            long long sizeLong = [self getFileOrDirSizeWithPath:filePath];
            if (location >= sizeLong) {
                [targetWriteHandle seekToFileOffset:sizeLong];
            }else{
//                [targetWriteHandle seekToFileOffset:sizeLong]; //插入的位置会被代替掉
//                [targetWriteHandle seekToFileOffset:location]; //后面的data都会被去掉
            }
            [targetWriteHandle writeData:data];
        }
    }else{
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
    }
}

/// 在一个file中追加data
+ (void)addData:(NSData *)data inFilePath:(NSString *)filePath{
    BOOL isDirectory ;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory]) {
        if (isDirectory) {
            NSCAssert(NO, @"文件夹怎嘛能在文件夹插入data呢..");
        }else{
            NSFileHandle *handle=[NSFileHandle fileHandleForWritingAtPath:filePath];
            [handle seekToEndOfFile];
            [handle writeData:data];
            [handle synchronizeFile];
            [handle closeFile];
//                [targetWriteHandle seekToFileOffset:sizeLong]; //插入的位置会被代替掉
//                [targetWriteHandle seekToFileOffset:location]; //后面的data都会被去掉
            [handle writeData:data];
        }
    }else{
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
    }
}


/// 从一个文件夹 赋值小file 到另一个文件夹 并给file命名
+ (void)fromSourceDirPath:(NSString *)sourceDirPath copyFileName:(NSString *)sourceFileName toTargetPathDirPath:(NSString *)targetDirPath targetFileName:(NSString *)targetFileName{
    
    if ([self isExist:[sourceDirPath stringByAppendingPathComponent:sourceFileName]]) {
        
        NSDictionary *attributesDic = [[NSFileManager defaultManager] attributesOfItemAtPath:[sourceDirPath stringByAppendingPathComponent:sourceFileName] error:nil];
       
        if (![attributesDic.fileType isEqualToString:NSFileTypeDirectory]) {
            //1 读出控制器
            NSFileHandle *sourceReadHandle=[NSFileHandle fileHandleForReadingAtPath:[sourceDirPath stringByAppendingPathComponent:sourceFileName]];
            //读取文件数据一直到结尾,即读出所有内容
            NSData *sourceData=[sourceReadHandle readDataToEndOfFile];
            //目标文件 是否存在
            if ([self isExist:[targetDirPath stringByAppendingPathComponent:targetFileName]]) {
                NSDictionary *attributesDic = [[NSFileManager defaultManager] attributesOfItemAtPath:[targetDirPath stringByAppendingPathComponent:targetFileName] error:nil];
                
                if (![attributesDic.fileType isEqualToString:NSFileTypeDirectory]) {
                    NSFileHandle *targetWriteHandle=[NSFileHandle fileHandleForWritingAtPath:[targetDirPath stringByAppendingPathComponent:targetFileName]];
                    //目标文件为file
                    [targetWriteHandle truncateFileAtOffset:0];
                    [targetWriteHandle writeData:sourceData];
                    [targetWriteHandle closeFile];
                    [sourceReadHandle closeFile];
                }else{
                    //目标文件为文件夹
                    NSLog(@"目标文件为文件夹");
                }
            }else{
                [self createFileWith:targetFileName atDirectoryPath:targetDirPath andData:nil];
                //目标文件不存在
                NSFileHandle *targetWriteHandle=[NSFileHandle fileHandleForWritingAtPath:[targetDirPath stringByAppendingPathComponent:targetFileName]];
                [targetWriteHandle truncateFileAtOffset:0];
                [targetWriteHandle writeData:sourceData];
                [targetWriteHandle closeFile];
                [sourceReadHandle closeFile];
            }
        }else{
            NSLog(@"copy源是文件夹不是file");
        }
    }else{
        NSLog(@"copy源不存在");
    }
}

/// 从一个文件夹 赋值小file 到另一个文件夹 并给file命名
+ (void)copyFormFilePath:(NSString *)fromFilePath toFilePath:(NSString *)toFilePath{
    
    BOOL isDirectory = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:fromFilePath isDirectory:&isDirectory]) {
        if (isDirectory) {
            NSLog(@"copy源是文件夹不是文件夹");
        }else{
            
            //1 读出控制器
            NSFileHandle *sourceReadHandle=[NSFileHandle fileHandleForReadingAtPath:fromFilePath];
            //读取文件数据一直到结尾,即读出所有内容
            NSData *sourceData=[sourceReadHandle readDataToEndOfFile];
            //2 写入目标文件
            BOOL isDirectory = NO;
            if ([[NSFileManager defaultManager] fileExistsAtPath:toFilePath isDirectory:&isDirectory]) {
                if (isDirectory) {
                    // 目标是文件夹
                }else{
                    // 目标是fiel
                    NSFileHandle *targetWriteHandle=[NSFileHandle fileHandleForWritingAtPath:toFilePath];
                    [targetWriteHandle truncateFileAtOffset:0];
                    [targetWriteHandle writeData:sourceData];
                    [targetWriteHandle closeFile];
                    [sourceReadHandle closeFile];
                }
            }else{
                //目标 不存在
                NSFileHandle *targetWriteHandle=[NSFileHandle fileHandleForWritingAtPath:toFilePath];
                [[NSFileManager defaultManager] createFileAtPath:toFilePath contents:nil attributes:nil];
                [targetWriteHandle truncateFileAtOffset:0];
                [targetWriteHandle writeData:sourceData];
                [targetWriteHandle closeFile];
                [sourceReadHandle closeFile];
            }
        }
    }else{
        NSLog(@"copy源不存在");
    }
}


/// 删除一个文件夹下的文件夹或文件 removeItemAtPath
+ (BOOL)removeDirectoryOrFileWith:(NSString *)directoryOrfileName atDirectoryPath:(NSString *)path{
    NSString *directoryOrfilePath = [path stringByAppendingPathComponent:directoryOrfileName];
    NSCAssert([[NSFileManager defaultManager] fileExistsAtPath:directoryOrfilePath],@"你要删除的文件夹不存在");
    return [[NSFileManager defaultManager] removeItemAtPath:directoryOrfilePath error:nil];
}

/// 得到一个文件夹下包括子文件夹所有的 Dirctory和file的绝对路径
+ (NSArray<NSString *> *)getDeepAllFileOrDirctoryPathAtDirectoryPath:(NSString *)path{
    NSMutableArray<NSString *> *arr = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:path error:nil].mutableCopy;
    NSMutableArray *deepAllPathArr = @[].mutableCopy;
    for (NSString *subPath in arr) {
        if (![subPath containsString:@".DS_Store"]) {
            [deepAllPathArr addObject:[path stringByAppendingPathComponent:subPath]];
        }
    }
    return deepAllPathArr.copy;
}

/// 得到一个文件夹下包括子文件夹所有的 Dirctory
+ (NSArray<NSString *> *)getDeepAllDirctoryPathAtDirectoryPath:(NSString *)path{
    NSMutableArray<NSString *> *arr = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:path error:nil].mutableCopy;
    NSMutableArray *deepDirPathsArr = @[].mutableCopy;
    for (NSString *subPath in arr) {
        
        NSString *itemPath = [path stringByAppendingPathComponent:subPath];
        
        NSDictionary *attributesDic = [[NSFileManager defaultManager] attributesOfItemAtPath:itemPath error:nil];
        if ([attributesDic.fileType isEqualToString:NSFileTypeDirectory]) {
            [deepDirPathsArr addObject:itemPath];
        }
    }
    return deepDirPathsArr.copy;
}

/// 得到一个文件夹下包括子文件夹所有的 file
+ (NSArray<NSString *> *)getDeepAllFilePathAtDirectoryPath:(NSString *)path{
    NSMutableArray<NSString *> *arr = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:path error:nil].mutableCopy;
    NSMutableArray *deepfilePathsArr = @[].mutableCopy;
    for (NSString *subPath in arr) {
        if (![subPath containsString:@".DS_Store"]){
            NSString *itemPath = [path stringByAppendingPathComponent:subPath];
            NSDictionary *attributesDic = [[NSFileManager defaultManager] attributesOfItemAtPath:itemPath error:nil];
            if (![attributesDic.fileType isEqualToString:NSFileTypeDirectory]) {
                [deepfilePathsArr addObject:itemPath];
            }
        }
    }
    return deepfilePathsArr.copy;
}

/// 得到一个文件夹下不包括子文件夹所有的 Dirctory和file的绝对路径
+ (NSArray<NSString *> *)getShallowAllFileOrDirctoryPathAtDirectoryPath:(NSString *)path{
    NSMutableArray<NSString *> *arr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil].mutableCopy;
    NSMutableArray *shallowAllPathArr = @[].mutableCopy;
    for (NSString *subPath in arr) {
        if (![subPath containsString:@".DS_Store"]){
            [shallowAllPathArr addObject:[path stringByAppendingPathComponent:subPath]];
        }
    }
    return shallowAllPathArr.copy;
}

/// 得到一个文件夹下不包括子文件夹所有的 Dirctory
+ (NSArray<NSString *> *)getShallowAllDirctoryPathAtDirectoryPath:(NSString *)path{
    NSMutableArray<NSString *> *arr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil].mutableCopy;
    NSMutableArray *deepDirPathsArr = @[].mutableCopy;
    for (NSString *subPath in arr) {
        NSString *itemPath = [path stringByAppendingPathComponent:subPath];
        NSDictionary *attributesDic = [[NSFileManager defaultManager] attributesOfItemAtPath:itemPath error:nil];
        if ([attributesDic.fileType isEqualToString:NSFileTypeDirectory]) {
            [deepDirPathsArr addObject:itemPath];
        }
    }
    return deepDirPathsArr.copy;
}

/// 得到一个文件夹下不包括子文件夹所有的 file
+ (NSArray<NSString *> *)getShallowAllFilePathAtDirectoryPath:(NSString *)path{
    NSMutableArray<NSString *> *arr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil].mutableCopy;
    NSMutableArray *deepFilePathsArr = @[].mutableCopy;
    for (NSString *subPath in arr) {
        if (![subPath containsString:@".DS_Store"]){
            NSString *itemPath = [path stringByAppendingPathComponent:subPath];
            NSDictionary *attributesDic = [[NSFileManager defaultManager] attributesOfItemAtPath:itemPath error:nil];
            if (![attributesDic.fileType isEqualToString:NSFileTypeDirectory]) {
                [deepFilePathsArr addObject:itemPath];
            }
        }
    }
    return deepFilePathsArr.copy;

}

/// 根据路径得到dir或者file的名字
+ (NSString *)getDirectoryOrFileNameWithPath:(NSString *)path{
    return [[NSFileManager defaultManager] displayNameAtPath:path];
}

/// 得到一个文件夹下包括子文件夹所有的 Dirctory和file的Name
+ (NSArray<NSString *> *)getDeepAllFileOrDirctoryNameAtDirectoryPath:(NSString *)path{
    NSArray *deepPaths = [self getDeepAllFileOrDirctoryPathAtDirectoryPath:path];
    NSMutableArray *deepNames = @[].mutableCopy;
    for (NSString *deepPath in deepPaths) {
        [deepNames addObject:[[NSFileManager defaultManager] displayNameAtPath:deepPath]];
    }
    return deepNames;
}

/// 得到一个文件夹下包括子文件夹所有的 Dirctory的Name
+ (NSArray<NSString *> *)getDeepAllDirctoryNameAtDirectoryPath:(NSString *)path{
    NSArray *deepPaths = [self getDeepAllDirctoryPathAtDirectoryPath:path];
    NSMutableArray *deepNames = @[].mutableCopy;
    for (NSString *deepPath in deepPaths) {
        [deepNames addObject:[[NSFileManager defaultManager] displayNameAtPath:deepPath]];
    }
    return deepNames;
}

/// 得到一个文件夹下包括子文件夹所有的 file的Name
+ (NSArray<NSString *> *)getDeepAllFileNameAtDirectoryPath:(NSString *)path{
    NSArray *deepPaths = [self getDeepAllFilePathAtDirectoryPath:path];
    NSMutableArray *deepNames = @[].mutableCopy;
    for (NSString *deepPath in deepPaths) {
        [deepNames addObject:[[NSFileManager defaultManager] displayNameAtPath:deepPath]];
    }
    return deepNames;
}

/// 得到一个文件夹下不包括子文件夹所有的 Dirctory和file的Name
+ (NSArray<NSString *> *)getShallowAllFileOrDirctoryNameAtDirectoryPath:(NSString *)path{
    NSArray *deepPaths = [self getShallowAllFileOrDirctoryPathAtDirectoryPath:path];
    NSMutableArray *deepNames = @[].mutableCopy;
    for (NSString *deepPath in deepPaths) {
        [deepNames addObject:[[NSFileManager defaultManager] displayNameAtPath:deepPath]];
    }
    return deepNames;
}
/// 得到一个文件夹下不包括子文件夹所有的 Dirctory的Name
+ (NSArray<NSString *> *)getShallowAllDirctoryNameAtDirectoryPath:(NSString *)path{
    NSArray *deepPaths = [self getShallowAllDirctoryPathAtDirectoryPath:path];
    NSMutableArray *deepNames = @[].mutableCopy;
    for (NSString *deepPath in deepPaths) {
        [deepNames addObject:[[NSFileManager defaultManager] displayNameAtPath:deepPath]];
    }
    return deepNames;
}

/// 得到一个文件夹下不包括子文件夹所有的 file的Name
+ (NSArray<NSString *> *)getShallowAllFileNameAtDirectoryPath:(NSString *)path{
    NSArray *deepPaths = [self getShallowAllFilePathAtDirectoryPath:path];
    NSMutableArray *deepNames = @[].mutableCopy;
    for (NSString *deepPath in deepPaths) {
        [deepNames addObject:[[NSFileManager defaultManager] displayNameAtPath:deepPath]];
    }
    return deepNames;

}

/// 得到一个文件夹的size或者一个file的size 单位是 字节.
+ (unsigned long long)getFileOrDirSizeWithPath:(NSString *)path{
    long long fileSize = 0;
    BOOL isDirectory = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory]) {
        if (isDirectory) {
            NSArray *filePaths = [self getDeepAllFilePathAtDirectoryPath:path];
            for (NSString *filePath in filePaths) {
                NSDictionary *attributesDic = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
                fileSize  = fileSize + attributesDic.fileSize;
            }
        }else{
            NSDictionary *attributesDic = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
            fileSize  = fileSize + attributesDic.fileSize;
        }
        return fileSize;
    }else{
        return 0;
    }
}

/// 判断一个file或者fir是否存在
+ (BOOL)isExist:(NSString *)filePath{
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

/// 提供获取document路径
+ (NSString *)getDocumentPath {
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return filePaths.firstObject;
}

/// 获取cache缓存路径
+ (NSString *)getCachePath {
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return filePaths.firstObject;
}

/// 获取temp路径
+ (NSString *)getTempPath {
    return NSTemporaryDirectory();
}


@end
