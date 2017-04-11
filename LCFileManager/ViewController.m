//
//  ViewController.m
//  关于本地一些操作
//
//  Created by 3D on 17/4/7.
//  Copyright © 2017年 3D. All rights reserved.
//

#import "ViewController.h"
#import "LCFileManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    

    /*
     path
     A path string identifying the directory to create. You may specify a full path or a path that is relative to the current working directory. This parameter must not be nil.
     参数1:path 一个要创建的文件夹的路径的字符串，这个字符串必须是全路径，这个参数必须不能为nil。
     createIntermediates
     If YES, this method creates any non-existent parent directories as part of creating the directory in path. If NO, this method fails if any of the intermediate parent directories does not exist. This method also fails if any of the intermediate path elements corresponds to a file and not a directory.
     参数2:如果YES，这个方法会自动创建你提供的路径中不存在的文件夹部分。如果为NO，则路径中存在不存在的文件夹，创建会失败。如果路径同名或者路径不是文件夹也会失败.
     ~/Documents/ttt/test,由于ttt不存在的。 如果你填YES 那么会自动创建ttt， 填NO，则报错
     参数3:文件的属性，例如 创建时间，权限，可读 等等（了解）。传nil 表示使用默认的文件夹属性
     */
    
//    NSString *imageViewsPath = [[self getCachePath] stringByAppendingPathComponent:@"imageViews"];
//    
//    
//    [@"asd" dataUsingEncoding:NSUTF8StringEncoding];
//    if( [fileManager createFileAtPath:imageViewsPath contents:[@"asd" dataUsingEncoding:NSUTF8StringEncoding] attributes:nil]){
//
//        NSLog(@"创建文件成功");
//    }
    
    
//
//    NSLog(@"++  %@",arr);
//    NSLog(@"++  %@",[self getDocumentPath]);
    
//    [LCFileManager createDirectoryWith:@"imageViews" andPath:[LCFileManager getCachePath]];
    
//    contentsOfDirectoryAtPath
    
    
    
    /*
     /// 得到一个文件夹下包括子文件夹所有的 Dirctory和file的绝对路径
     + (NSArray<NSString *> *)getDeepAllFileOrDirctoryPathatAtDirectoryPath:(NSString *)path;
     /// 得到一个文件夹下包括子文件夹所有的 Dirctory
     + (NSArray<NSString *> *)getDeepAllDirctoryPathatAtDirectoryPath:(NSString *)path;
     /// 得到一个文件夹下包括子文件夹所有的 file
     + (NSArray<NSString *> *)getDeepAllFilePathatAtDirectoryPath:(NSString *)path;
     
     /// 得到一个文件夹下不包括子文件夹所有的 Dirctory和file的绝对路径
     + (NSArray<NSString *> *)getShallowAllFileOrDirctoryPathatAtDirectoryPath:(NSString *)path;
     /// 得到一个文件夹下不包括子文件夹所有的 Dirctory
     + (NSArray<NSString *> *)getShallowAllDirctoryPathatAtDirectoryPath:(NSString *)path;
     /// 得到一个文件夹下不包括子文件夹所有的 file
     + (NSArray<NSString *> *)getShallowAllFilePathatAtDirectoryPath:(NSString *)path;
     */
    
    
    
    NSArray *arr = [LCFileManager getDeepAllFileOrDirctoryPathAtDirectoryPath:[LCFileManager getCachePath]];
    NSLog(@"!!+ %ld",arr.count);
    
    NSArray *arr1 = [LCFileManager getDeepAllDirctoryPathAtDirectoryPath:[LCFileManager getCachePath]];
    NSLog(@"!!= %ld",arr1.count);
    
    NSArray *arr2 = [LCFileManager getDeepAllFilePathAtDirectoryPath:[LCFileManager getCachePath]];
    NSLog(@"!!- %ld",arr2.count);
    
    NSArray *arr3 = [LCFileManager getShallowAllFileOrDirctoryPathAtDirectoryPath:[LCFileManager getCachePath]];
//    NSLog(@"%@",arr3);
    
    NSArray *arr4 = [LCFileManager getShallowAllDirctoryPathAtDirectoryPath:[LCFileManager getCachePath]];
//    NSLog(@"%@",arr4);
    
    
    
    NSArray *arr5 = [LCFileManager getShallowAllFilePathAtDirectoryPath:[LCFileManager getCachePath]];
//    NSLog(@"%@",arr5);

    NSArray *arr6 = [LCFileManager getDeepAllFileOrDirctoryNameAtDirectoryPath:[LCFileManager getCachePath]];
    NSLog(@" == = %ld",arr6.count);

    NSString *aa = [LCFileManager getDirectoryOrFileNameWithPath:[LCFileManager getCachePath]];
//    NSLog(@"__%@",aa);
    
    NSArray *arr7 = [LCFileManager getDeepAllDirctoryNameAtDirectoryPath:[LCFileManager getCachePath]];
    NSLog(@"%ld",arr7.count);
    NSArray *arr8 = [LCFileManager getDeepAllFileNameAtDirectoryPath:[LCFileManager getCachePath]];
    NSLog(@"%ld",arr8.count);
    
    
    NSArray *arr9 = [LCFileManager getShallowAllFileOrDirctoryNameAtDirectoryPath:[LCFileManager getCachePath]];
    NSLog(@"+++%@",arr9);
    NSArray *arr10 = [LCFileManager getShallowAllDirctoryNameAtDirectoryPath:[LCFileManager getCachePath]];
    NSLog(@"%@",arr10);
    
    NSArray *arr11 = [LCFileManager getShallowAllFileNameAtDirectoryPath:[LCFileManager getCachePath]];
    NSLog(@"%@",arr11);
    
    NSDictionary *dic = [fileManager attributesOfItemAtPath:[[LCFileManager getCachePath] stringByAppendingPathComponent:@"qwe"]error:nil];
    NSLog(@"%@",dic);
    
    NSLog(@"%@",[LCFileManager getCachePath]);
    
//    [LCFileManager removeDirectoryOrFileWith:@"" atDirectoryPath:[LCFileManager getCachePath]];
    
//    [LCFileManager createDirectoryWith:@"qwr" atDirectoryPath:[LCFileManager getCachePath]];
//    [LCFileManager createFileWith:@"asd" atDirectoryPath:[LCFileManager getCachePath] andData:nil];
    
//    NSData *data = [@"abc" dataUsingEncoding:NSUTF8StringEncoding];
//    [LCFileManager copyFormFilePath:[[LCFileManager getCachePath] stringByAppendingPathComponent:@"asd"] toFilePath:[[LCFileManager getCachePath] stringByAppendingPathComponent:@"abc"]];
    
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    lable.layer.backgroundColor = [UIColor redColor].CGColor;
    lable.backgroundColor = [UIColor redColor];
    lable.layer.cornerRadius = 50;
    lable.layer.masksToBounds = YES;
    [self.view addSubview:lable];
    
    
    
    /*
     imageViews  4
     aa.png      180347
     */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/// 提供获取document路径
- (NSString *)getDocumentPath {
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return filePaths.firstObject;
}

/// 获取cache缓存路径
- (NSString *)getCachePath {
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return filePaths.firstObject;
}

/// 获取temp路径
- (NSString *)getTempPath {
    return NSTemporaryDirectory();
}


@end
