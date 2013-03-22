//
//  SKURLCache.m
//  CacheControl
//
//  Created by Blithe Xu on 3/17/13.
//  Copyright (c) 2013 UX. All rights reserved.
//

#import "SKURLCache.h"

@implementation SKURLCache

// Whether need to do "Force use cache file"
- (BOOL)isForceUseCacheFile:(NSString *)url{
    NSRange range = [url rangeOfString:SKFORCEUSECACHEFILEINDENTIFICATION];
    if (range.length == [SKFORCEUSECACHEFILEINDENTIFICATION length]) {    //Find, this mean
        return YES;
    }
    return NO;
}

- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request{
    
    NSString *url = [[request URL] absoluteString];
    if ([self isForceUseCacheFile:url]) {   //Force use cache file
        
    }
    
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[request URL]];
    NSCachedURLResponse *response = [super cachedResponseForRequest:theRequest];
    return response;
}

@end
