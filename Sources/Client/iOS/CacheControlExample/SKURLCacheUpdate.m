//
//  SKURLCacheUpdate.m
//  CacheControlExample
//
//  Created by Blithe Xu on 3/20/13.
//  Copyright (c) 2013 Shaoke Xu. All rights reserved.
//

#import "SKURLCacheUpdate.h"
#import "SKURLConnection.h"
#import <Foundation/NSJSONSerialization.h>

@interface SKURLCacheUpdate(){
    
}

- (void)updateCache;
- (void)notification;
- (void)successUpdateSpecificURL:(NSString *)url data:(NSData *)data;
- (void)failUpdateSpecificURL:(NSString *)url error:(NSError *)error;
- (void)finishUpdateCache:(NSMutableArray *)successList failList:(NSMutableArray *)failList;

@end

@implementation SKURLCacheUpdate
@synthesize updateList;
@synthesize request;
@synthesize timeInterval;

- (SKURLCacheUpdate *)initWithRequest:(NSURLRequest *)urlRequest{
    self.request = urlRequest;
    return self;
}

- (void)getUpdateList{
    SKURLConnection *connection = [[SKURLConnection alloc] initWithRequest:self.request success:^(NSURLConnection *connection, NSData *data){
        self.updateList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@", self.updateList);
        [self updateCache];
    } error:^(NSURLConnection *connection, NSError *error){
        NSLog(@"error");
    }];
    
    NSLog(@"%@", [connection description]);
}

// Start check update cache. each SKDEFAULTTIMEINTERVAL second will update cache
- (void)start{
    [self start:SKDEFAULTTIMEINTERVAL];
}

- (void)start:(NSTimeInterval)interval{
    self.timeInterval = interval;
    _timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(getUpdateList) userInfo:nil repeats:YES];
}

- (void)stop{
    [_timer invalidate];
}

- (void)updateCache{
    __block NSMutableArray *successList = [NSMutableArray array];
    __block NSMutableArray *failList = [NSMutableArray array];
    SKURLConnection *connection;
    __block int updateNumber =0;
    if (self.updateList) {
        NSURLCache *urlCache = [NSURLCache sharedURLCache];
        for(int i =0; i<self.updateList.count; i++){
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.updateList[i]]];
            [urlCache removeCachedResponseForRequest:urlRequest];
            connection = [[SKURLConnection alloc] initWithRequest:urlRequest success:^(NSURLConnection *connection, NSData *data){
                NSLog(@"success");
                [successList addObject:self.updateList[i]];
                [self successUpdateSpecificURL:self.updateList[i] data:data];
                updateNumber++;
                if (updateNumber == self.updateList.count) {
                    [self finishUpdateCache:successList failList:failList];
                }
            } error:^(NSURLConnection *connection, NSError *error){
                NSLog(@"error");
                [failList addObject:self.updateList[i]];
                updateNumber++;
                [self failUpdateSpecificURL:self.updateList[i] error:error];
                if (updateNumber == self.updateList.count) {
                    [self finishUpdateCache:successList failList:failList];
                }
            }];
        }
    }
}

- (void)finishUpdateCache:(NSMutableArray *)successList failList:(NSMutableArray *)failList{
    [self notification];
}

- (void)notification{
    NSLog(@"notification");
    [[NSNotificationCenter defaultCenter] postNotificationName:SKFINISHEDUPDATECACHENOTIFICATION object:self];
}

// If update a url success, will post a notification. Notification format:
// Name: url
// object: self
// userInfo: {data: NSData}
- (void)successUpdateSpecificURL:(NSString *)url data:(NSData *)data{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:data, @"data", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:url object:self userInfo:dic];
}

// If update a url fail, will post a notification. Notification format:
// Name: url
// object: self
// userInfo: {error: NSError}
- (void)failUpdateSpecificURL:(NSString *)url error:(NSError *)error{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:error, @"error", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:url object:self userInfo:dic];
}

@end
