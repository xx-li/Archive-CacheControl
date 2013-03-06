//
//  SKNativeViewController.m
//  CacheControl
//
//  Created by UX on 3/6/13.
//  Copyright (c) 2013 UX. All rights reserved.
//

#import "SKNativeViewController.h"

@interface SKNativeViewController (){
    CGFloat nextX;
    CGFloat nextY;
}

- (void)caculteNextPosition;

@end

@implementation SKNativeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Native", @"Native");
        self.tabBarItem.image = [UIImage imageNamed:@"ipod"];
        nextX = margin;
        nextY = margin;
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

- (void)viewDidUnload {
    [self setImageURL:nil];
    [self setIntervalTime:nil];
    [self setImageScrollView:nil];
    [super viewDidUnload];
}
- (IBAction)startInterval:(id)sender {
    [self hideKeyBoard:nil];
}

- (IBAction)stopInterval:(id)sender {
    [self hideKeyBoard:nil];
}

- (IBAction)clearImage:(id)sender {
    [self hideKeyBoard:nil];
    for( UIView* view in self.imageScrollView.subviews ){
        [view removeFromSuperview];
    }
    nextX = margin;
    nextY = margin;
}

- (void)caculteNextPosition{
    nextY = floor((1 + floor(nextX/100))/3.0)*100.0+nextY;
    nextX = ((int)(1 + floor(nextX/100)) % 3)*100+margin;
    
    NSLog(@"nextX = %f", nextX);
    NSLog(@"nextY = %f", nextY);
}

- (IBAction)insertImage:(id)sender {
    [self hideKeyBoard:nil];
    NSString *imageURL = self.imageURL.text;
    if (!imageURL || [imageURL length] == 0) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"You must specify image url" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(nextX, nextY, imageWidth, imageHeight)];
    [self caculteNextPosition];
}

- (IBAction)hideKeyBoard:(id)sender {
    [self.imageURL resignFirstResponder];
    [self.intervalTime resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self hideKeyBoard:nil];
    return YES;
}

@end
