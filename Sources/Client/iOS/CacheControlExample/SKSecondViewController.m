//
//  SKSecondViewController.m
//  CacheControlExample
//
//  Created by Blithe Xu on 3/20/13.
//  Copyright (c) 2013 Shaoke Xu. All rights reserved.
//

#import "SKSecondViewController.h"
#import "UIImageView+Cache.h"

@interface SKSecondViewController ()

@end

@implementation SKSecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //[self setImageViews];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setImageViews) name:@"update_cache_image" object:nil];
}

- (void)setImageViews{
    [self.imgView1 imageViewWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.106/cache/img1.png"]] placeHolder:[UIImage imageNamed:@"placeholder.png"]];
    [self.imgView2 imageViewWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.106/cache/img2.png"]] placeHolder:[UIImage imageNamed:@"placeholder"]];
    [self.imgView3 imageViewWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.106/cache/img3.png"]] placeHolder:[UIImage imageNamed:@"placeholder"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
