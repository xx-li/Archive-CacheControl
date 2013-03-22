//
//  SKURLCache.h
//  CacheControl
//
//  Created by Blithe Xu on 3/17/13.
//  Copyright (c) 2013 UX. All rights reserved.
//

#import <Foundation/Foundation.h>

//This property file is used to 
#define SUPPORTCACHEDFILETYPEWITHDEFAULTFILE                                   @"SKSupportCachedFileTypeWithDefaultFile.plist"
#define SKFORCEUSECACHEFILEINDENTIFICATION                                     @"#SKFORCEUSECACHEFILEINDENTIFICATION"

@interface SKURLCache : NSURLCache


- (BOOL)isForceUseCacheFile:(NSString *)url;

@end
