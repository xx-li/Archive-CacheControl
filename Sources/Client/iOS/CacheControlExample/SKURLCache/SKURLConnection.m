//
//  SKURLConnection.m
//  CacheControlExample
//
//  Created by Blithe Xu on 3/20/13.
//  Copyright (c) 2013 Shaoke Xu. All rights reserved.
//

#import "SKURLConnection.h"

typedef void(^SKURLConnectionSuccessBlock)(NSURLConnection *connection, NSData *data);

typedef void(^SKURLConnectionErrorBlock)(NSURLConnection *connection, NSError *error);

@interface SKURLConnection(){
    NSMutableData *_tempData;
}

@property (readwrite, nonatomic, strong) NSURLConnection *connection;
@property (readwrite, nonatomic, strong) NSURLRequest *request;
@property (readwrite, nonatomic, strong) NSURLResponse *response;
@property (readwrite, nonatomic, strong) NSError *error;
@property (readwrite, nonatomic, strong) NSData *responseData;
@property (readwrite, nonatomic, strong) SKURLConnectionSuccessBlock successBlcok;
@property (readwrite, nonatomic, strong) SKURLConnectionErrorBlock errorBlock;

@end

@implementation SKURLConnection

@synthesize request = _request;
@synthesize response = _response;
@synthesize error = _error;
@synthesize responseData = _responseData;
@synthesize connection = _connection;

- (SKURLConnection *)initWithRequest:(NSURLRequest *)urlRequest{
    return [self initWithRequest:urlRequest success:nil error:nil];
}

- (SKURLConnection *)initWithRequest:(NSURLRequest *)urlRequest success:(void(^)(NSURLConnection *connection, NSData *data))successBlock error:(void(^)(NSURLConnection *connection, NSError *error))errorBlock{
    _connection=[[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    
    if(_connection){
        _tempData = [NSMutableData data];
    }
    
    if(successBlock)
        self.successBlcok = successBlock;
    if(errorBlock)
        self.errorBlock = errorBlock;
    
    return self;
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [_tempData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [_tempData appendData:data];
}

- (void)connection:(NSURLConnection *)connection  didFailWithError:(NSError *)error{
    NSLog(@"Connection failed! Error - %@ %@", [error localizedDescription], [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    self.error = error;
    
    if (self.errorBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.errorBlock(connection, error);
        });
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    self.responseData = _tempData;
    
    if (self.successBlcok) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.successBlcok(connection, _tempData);
        });
    }
}

@end
