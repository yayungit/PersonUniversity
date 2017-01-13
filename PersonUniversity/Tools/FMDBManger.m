//
//  FMDBManger.m
//  PersonUniversity
//
//  Created by 何亚运 on 2017/1/13.
//  Copyright © 2017年 YYStar. All rights reserved.
//

#import "FMDBManger.h"
#import <FMDB.h>
@interface FMDBManger ()
@property(nonatomic, strong) FMDatabase *db;
@end

@implementation FMDBManger
+ (instancetype)shareInstand {
    static FMDBManger *fmdbManger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fmdbManger = [[FMDBManger alloc] init];
        [fmdbManger initBase];
    });
    return fmdbManger;
}
- (void)initBase {
    NSString *documentsPayh = [NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentsPayh stringByAppendingPathComponent:@"test.sqlite"];
    _db = [FMDatabase databaseWithPath:filePath];
    [_db open];
}
@end
