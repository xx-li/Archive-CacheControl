//
//  SKURLCache.h
//  CacheControl
//
//  Created by Blithe Xu on 3/17/13.
//  Copyright (c) 2013 UX. All rights reserved.
//

#import <Foundation/Foundation.h>

//This property file is used to 
#define SKDEFAULTSUPPORTCACHEDFILETYPEWITHDEFAULTFILE                          @"SKSupportCachedFileTypeWithDefaultFile.plist"
#define SKFORCEUSECACHEFILEINDENTIFICATION                                     @"?SKFORCEUSECACHEFILEINDENTIFICATION"
#define SKDEFAULTCACHEFILEDISKPATH                                             @"SKSharedCache.db"
#define SKDEFAULTCACHEMEMORYCAPACITY                                           20*1024*1024
#define SKDEFAULTCACHEDISKCAPACITY                                             200*1024*1024

@interface SKURLCache : NSURLCache

@property (nonatomic, readonly, copy) NSString *urlIndetification;
@property (nonatomic, readonly, copy) NSString *supportFileTypePath;
@property (nonatomic, readonly, copy) NSString *diskCachedPath;

- (id)initWithMemoryCapacity;

- (id)initWithMemoryCapacity:(NSUInteger)memoryCapacity
                diskCapacity:(NSUInteger)diskCapacity
                    diskPath:(NSString *)path;

- (id)initWithMemoryCapacity:(NSUInteger)memoryCapacity
                diskCapacity:(NSUInteger)diskCapacity
                    diskPath:(NSString *)path
          urlIndentification:(NSString *)indentification
         supportFileTypePath:(NSString *)supportFileTypePath;

- (BOOL)isForceUseCacheFile:(NSString *)url;

- (NSString *)getDefaultFilePathByType:(NSString *)type;


@end
