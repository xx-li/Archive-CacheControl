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

@end

@implementation SKURLCacheUpdate

- (SKURLCacheUpdate *)initWithRequest:(NSURLRequest *)request{
    self.request = request;
    return self;
}

- (void)getUpdateList{
    SKURLConnection *connection = [[SKURLConnection alloc] initWithRequest:self.request success:^(NSURLConnection *connection, NSData *data){
        self.updateList = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
        NSLog(@"%@", self.updateList);
        [self updateCache];
    } error:^(NSURLConnection *connection, NSError *error){
        NSLog(@"error");
    }];
    
    NSLog(@"%@", [connection description]);
}

- (void)start{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(getUpdateList) userInfo:nil repeats:YES];
}

- (void)stop{
    [self.timer invalidate];
}

- (void)updateCache{
    __block NSMutableArray *successList = [NSMutableArray array];
    __block NSMutableArray *errorList = [NSMutableArray array];
    __block int updateNumber =0;
    if (self.updateList) {
        NSURLCache *urlCache = [NSURLCache sharedURLCache];
        for(int i =0; i<self.updateList.count; i++){
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.updateList[i]]];
            [urlCache removeCachedResponseForRequest:request];
            SKURLConnection *connection = [[SKURLConnection alloc] initWithRequest:request success:^(NSURLConnection *connection, NSData *data){
                NSLog(@"success");
                [successList addObject:self.updateList[i]];
                updateNumber++;
                if (updateNumber == self.updateList.count) {
                    [self notification];
                }
            } error:^(NSURLConnection *connection, NSError *error){
                NSLog(@"error");
                [errorList addObject:self.updateList[i]];
                updateNumber++;
                if (updateNumber == self.updateList.count) {
                    [self notification];
                }
            }];
            NSLog(@"%@", [connection description]);
        }
    }
}

- (void)notification{
    NSLog(@"notification");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"update_cache_image" object:self];
}

@end
