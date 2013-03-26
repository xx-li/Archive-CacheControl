//
//  SKURLCache.m
//  CacheControl
//
//  Created by Blithe Xu on 3/17/13.
//  Copyright (c) 2013 UX. All rights reserved.
//

#import "SKURLCache.h"

@interface SKURLCache(){
    NSDictionary *_supportFileTypeList;         //A NSDictionary instance that contains the information in _supportFileType                
}

@property (nonatomic, readwrite, copy) NSString *urlIndetification;         //The URL Indetification that means this url just can use local cache
@property (nonatomic, readwrite, copy) NSString *supportFileTypePath;           //The file name that contains support file type information
@property (nonatomic, readwrite, copy) NSString *diskCachedPath;                  //The path to cache file in desk

@end

@implementation SKURLCache
@synthesize urlIndetification = _urlIndetification;
@synthesize supportFileTypePath = _supportFileTypePath;
@synthesize diskCachedPath = _diskCachedPath;

// Initial a SKURLCache. Use default value
- (id)initWithMemoryCapacity{
    if (self = [self initWithMemoryCapacity:SKDEFAULTCACHEMEMORYCAPACITY diskCapacity:SKDEFAULTCACHEDISKCAPACITY diskPath:SKDEFAULTCACHEFILEDISKPATH urlIndentification:SKFORCEUSECACHEFILEINDENTIFICATION supportFileTypePath:SKDEFAULTSUPPORTCACHEDFILETYPEWITHDEFAULTFILE]) {
    }
    
    return self;
}

// Initial a SKURLCache. Custom memory capacity, disk capacity and disk path. Use default indentification and support file
- (id)initWithMemoryCapacity:(NSUInteger)memoryCapacity diskCapacity:(NSUInteger)diskCapacity diskPath:(NSString *)path{
    if (self = [self initWithMemoryCapacity:memoryCapacity diskCapacity:diskCapacity diskPath:path urlIndentification:SKFORCEUSECACHEFILEINDENTIFICATION supportFileTypePath:SKDEFAULTSUPPORTCACHEDFILETYPEWITHDEFAULTFILE]) {
    }
    
    return self;
}

// Initial a SKURLCache. custom all value
- (id)initWithMemoryCapacity:(NSUInteger)memoryCapacity diskCapacity:(NSUInteger)diskCapacity diskPath:(NSString *)path urlIndentification:(NSString *)indentification supportFileTypePath:(NSString *)supportFileTypePath{
    
    if (self = [super initWithMemoryCapacity:memoryCapacity diskCapacity:diskCapacity diskPath:path]) {
        self.memoryCapacity = memoryCapacity;
        self.diskCapacity = diskCapacity;
        self.diskCachedPath = path;
        self.urlIndetification = indentification;
        self.supportFileTypePath = supportFileTypePath;
        _supportFileTypeList = [NSDictionary dictionaryWithContentsOfFile:supportFileTypePath];
    }
    
    return self;
}

// Pass type name(maybe, png, jpg...), and it will return the default file for this type.
- (NSString *)getDefaultFilePathByType:(NSString *)type{
    if (_supportFileTypeList) {
        return [_supportFileTypeList objectForKey:type];
    }
    
    return nil;
}

// Whether this url contains SKFORCEUSECACHEFILEINDENTIFICATION
- (BOOL)isForceUseCacheFile:(NSString *)url{
    NSRange range = [url rangeOfString:SKFORCEUSECACHEFILEINDENTIFICATION];
    if (range.length == [SKFORCEUSECACHEFILEINDENTIFICATION length]) {    //Find
        return YES;
    }
    return NO;
}

// Get the url used in Cache. All the text begin from SKFORCEUSECACHEFILEINDENTIFICATION will be remove
// For example: http://example.com/cache/image.png#SKFORCEUSECACHEFILEINDENTIFICATION?1364018346471
// The url used in cahce is http://example.com/cache/image.png 
// In UIWebview, sometime force img to refresh, we will add timestap to the end of this url. This timestap isn't used in cache.
// 
- (NSString *)getURLUsedInCached:(NSString *)url{
    NSRange range = [url rangeOfString:SKFORCEUSECACHEFILEINDENTIFICATION];
    if (range.length == [SKFORCEUSECACHEFILEINDENTIFICATION length]) {      //Find
        NSString *newUrl = [url substringToIndex:range.location];           //The url that
        return newUrl;
    }
    return url;
}


#pragma mark
#pragma mark NSURLCache
- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request{
    NSString *url = [[request URL] absoluteString];
    NSURLRequest *theRequest;
    NSString *newUrl = [self getURLUsedInCached:url];
    
    theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:newUrl]];
    NSLog(@"url = %@", url);
    NSLog(@"newUrl = %@", newUrl);
    NSCachedURLResponse *response = [super cachedResponseForRequest:theRequest];
    
    return response;
}

- (void)storeCachedResponse:(NSCachedURLResponse *)cachedResponse forRequest:(NSURLRequest *)request{
    NSString *url = [[request URL] absoluteString];
    if ([self isForceUseCacheFile:url]) {   //If this url has SKFORCEUSECACHEFILEINDENTIFICATION, don't need to cache this url
        return;
    }else {                                 //Otherwise, need to cache this url
        [super storeCachedResponse:cachedResponse forRequest:request];
    }
}

@end
