//
//  SKNativeViewController.m
//  CacheControl
//
//  Created by UX on 3/6/13.
//  Copyright (c) 2013 UX. All rights reserved.
//

#import "SKNativeViewController.h"

@interface SKNativeViewController ()

@end

@implementation SKNativeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Native", @"Native");
        self.tabBarItem.image = [UIImage imageNamed:@"ipod"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
