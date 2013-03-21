//
//  SKURLCacheUpdate.h
//  CacheControlExample
//
//  Created by Blithe Xu on 3/20/13.
//  Copyright (c) 2013 Shaoke Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKURLCacheUpdate : NSObject

@property (nonatomic, retain) NSArray *updateList;
@property (nonatomic, retain) NSURLRequest *request;
@property (nonatomic, retain) NSTimer *timer;


- (SKURLCacheUpdate *)initWithRequest:(NSURLRequest *)request;
- (void)start;
- (void)stop;

@end
