//
//  SKNativeViewController.h
//  CacheControl
//
//  Created by UX on 3/6/13.
//  Copyright (c) 2013 UX. All rights reserved.
//

#import <UIKit/UIKit.h>

#define margin          5.0
#define imageHeight     90.0
#define imageWidth      90.0

@interface SKNativeViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *imageURL;
@property (weak, nonatomic) IBOutlet UITextField *intervalTime;
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;

- (IBAction)startInterval:(id)sender;
- (IBAction)stopInterval:(id)sender;
- (IBAction)clearImage:(id)sender;
- (IBAction)insertImage:(id)sender;

- (IBAction)hideKeyBoard:(id)sender;

@end
