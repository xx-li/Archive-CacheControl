//
//  SKURLCacheUpdate.h
//  CacheControlExample
//
//  Created by Blithe Xu on 3/20/13.
//  Copyright (c) 2013 Shaoke Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KFINISHEDUPDATECACHENOTIFICATION    @"sk_finished_update_cache_notification"
#define SKDEFAULTTIMEINTERVAL               30.0

@interface SKURLCacheUpdate : NSObject{
    NSTimer *_timer;
}

@property (nonatomic, retain) NSArray *updateList;
@property (nonatomic, retain) NSURLRequest *request;
@property (nonatomic) NSTimeInterval timeInterval;


- (SKURLCacheUpdate *)initWithRequest:(NSURLRequest *)urlRequest;
- (void)start;
- (void)start:(NSTimeInterval)interval;
- (void)stop;

@end
