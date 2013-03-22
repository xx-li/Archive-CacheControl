//
//  SKURLCacheUpdate.h
//  CacheControlExample
//
//  Created by Blithe Xu on 3/20/13.
//  Copyright (c) 2013 Shaoke Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KFINISHEDUPDATECACHENOTIFICATION    @"sk_finished_update_cache_notification"


@interface SKURLCacheUpdate : NSObject

@property (nonatomic, retain) NSArray *updateList;
@property (nonatomic, retain) NSURLRequest *request;
@property (nonatomic, retain) NSTimer *timer;


- (SKURLCacheUpdate *)initWithRequest:(NSURLRequest *)request;
- (void)start;
- (void)stop;

@end
