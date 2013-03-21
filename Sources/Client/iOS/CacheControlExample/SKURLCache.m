//
//  SKURLCache.m
//  CacheControl
//
//  Created by Blithe Xu on 3/17/13.
//  Copyright (c) 2013 UX. All rights reserved.
//

#import "SKURLCache.h"

@implementation SKURLCache

- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request{
    //return [super cachedResponseForRequest:request];
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[request URL]];
    NSCachedURLResponse *response = [super cachedResponseForRequest:theRequest];
    return response;
}
@end
