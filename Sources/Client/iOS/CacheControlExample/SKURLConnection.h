//
//  SKURLConnection.h
//  CacheControlExample
//
//  Created by Blithe Xu on 3/20/13.
//  Copyright (c) 2013 Shaoke Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKURLConnection : NSObject<NSURLConnectionDataDelegate>

@property (readonly, nonatomic, strong) NSURLRequest *request;

@property (readonly, nonatomic, strong) NSURLResponse *response;

@property (readonly, nonatomic, strong) NSError *error;

@property (readonly, nonatomic, strong) NSData *responseData;

- (SKURLConnection *)initWithRequest:(NSURLRequest *)urlRequest;

- (SKURLConnection *)initWithRequest:(NSURLRequest *)urlRequest success:(void(^)(NSURLConnection *connection, NSData *data))successBlock error:(void(^)(NSURLConnection *connection, NSError *error))errorBlock;


@end
