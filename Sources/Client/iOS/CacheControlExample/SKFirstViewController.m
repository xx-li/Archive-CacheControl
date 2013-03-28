//
//  SKFirstViewController.m
//  CacheControlExample
//
//  Created by Blithe Xu on 3/20/13.
//  Copyright (c) 2013 Shaoke Xu. All rights reserved.
//

#import "SKFirstViewController.h"
#import "SKURLCacheUpdate.h"

@interface SKFirstViewController ()

@end

@implementation SKFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [self.webview loadRequest:request];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateImages) name:SKFINISHEDUPDATECACHENOTIFICATION object:nil];
}

- (void)updateImages{
    NSLog(@"webview updateImages");
    [self.webview stringByEvaluatingJavaScriptFromString:@"updateImages();"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"shouldStartLoadWithRequest, url = %@", [[request URL] description]);
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"window.endpoint='%@'",kEndpoint]];
    [self.webview stringByEvaluatingJavaScriptFromString:@"initImages()"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
}

@end
