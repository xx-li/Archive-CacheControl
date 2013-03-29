//
//  UIImageView+Cache.m
//  CacheControlExample
//
//  Created by Blithe Xu on 3/20/13.
//  Copyright (c) 2013 Shaoke Xu. All rights reserved.
//

#import "UIImageView+Cache.h"
#import "SKURLConnection.h"

@implementation UIImageView (Cache)

- (void)imageViewWithCache:(NSString *)url placeHolder:(UIImage *)image{
    [[NSNotificationCenter defaultCenter] removeObserver:url];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateImageByData:) name:url object:nil];
    
    NSURLCache *urlCache = [NSURLCache sharedURLCache];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    
    NSCachedURLResponse *cachedResponse = [urlCache cachedResponseForRequest:request];
    
    if(cachedResponse){
        self.image = [UIImage imageWithData:cachedResponse.data];
    }else{
        self.image = image;
    }
}

- (void)imageViewWithRequest:(NSURLRequest *)request placeHolder:(UIImage *)image{
    self.image = image;
    
    [[NSNotificationCenter defaultCenter] removeObserver:[[request URL] absoluteString]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateImageByData:) name:[[request URL] absoluteString] object:nil];
    
    SKURLConnection *connection = [[SKURLConnection alloc] initWithRequest:request success:^(NSURLConnection *connection, NSData *data){
        self.image = [UIImage imageWithData:data];
    } error:^(NSURLConnection *connection, NSError *error){
        NSLog(@"error");
    }];
    NSLog(@"%@", [connection description]);
}

- (void)updateImageByData:(NSNotification *)notification{
    NSData *data = [notification.userInfo objectForKey:@"data"];
    if (data) {
        self.image = [UIImage imageWithData:data];
    }
}

@end
