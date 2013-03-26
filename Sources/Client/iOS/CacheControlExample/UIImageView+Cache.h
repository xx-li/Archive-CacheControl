//
//  UIImageView+Cache.h
//  CacheControlExample
//
//  Created by Blithe Xu on 3/20/13.
//  Copyright (c) 2013 Shaoke Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Cache)

//- (void)imageViewWithCache:(NSString *)url;

- (void)imageViewWithCache:(NSString *)url placeHolder:(UIImage *)image;

// Initial a UIImageView use reomote request
- (void)imageViewWithRequest:(NSURLRequest *)request placeHolder:(UIImage *)image;

@end
