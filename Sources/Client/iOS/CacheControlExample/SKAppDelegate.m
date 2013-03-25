//
//  SKAppDelegate.m
//  CacheControlExample
//
//  Created by Blithe Xu on 3/20/13.
//  Copyright (c) 2013 Shaoke Xu. All rights reserved.
//

#import "SKAppDelegate.h"
#import "SKFirstViewController.h"
#import "SKSecondViewController.h"
#import "SKURLCacheUpdate.h"
#import "SKURLCache.h"

#if ENABLE_PONYDEBUGGER
#import <PonyDebugger/PonyDebugger.h>
#endif

@implementation SKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
#if ENABLE_PONYDEBUGGER
    PDDebugger *debugger = [PDDebugger defaultInstance];
    // Enable Network debugging, and automatically track network traffic that comes through any classes that NSURLConnectionDelegate methods.
    [debugger enableNetworkTrafficDebugging];
    [debugger forwardAllNetworkTraffic];
    
    // Enable Core Data debugging, and broadcast the main managed object context.
    [debugger enableCoreDataDebugging];
    
    // Enable View Hierarchy debugging. This will swizzle UIView methods to monitor changes in the hierarchy
    // Choose a few UIView key paths to display as attributes of the dom nodes
    [debugger enableViewHierarchyDebugging];
    [debugger setDisplayedViewAttributeKeyPaths:@[@"frame", @"hidden", @"alpha", @"opaque"]];
    
    // Connect to a specific host
    [debugger connectToURL:[NSURL URLWithString:@"ws://192.168.1.103:9000/device"]];
    // Or auto connect via bonjour discovery
    //[debugger autoConnect];
    // Or to a specific ponyd bonjour service
    //[debugger autoConnectToBonjourServiceNamed:@"MY PONY"];
#endif
    
    // Set cache
    SKURLCache *shareCache = [[SKURLCache alloc] initWithMemoryCapacity:20*1024*1024 diskCapacity:200*1024*1024 diskPath:kShareCachePath];
    [SKURLCache setSharedURLCache:shareCache];
    
    NSLog(@"%@", [NSURL URLWithString:@"/cache/index.php/api/dynamic/update_resources?timestemp=1221212" relativeToURL:[NSURL URLWithString:kEndpoint]]);
    
    SKURLCacheUpdate *urlCacheUpdate = [[SKURLCacheUpdate alloc] initWithRequest:[NSURLRequest requestWithURL: [NSURL URLWithString:@"/cache/index.php/api/dynamic/update_resources?timestemp=1221212"relativeToURL:[NSURL URLWithString:kEndpoint]] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60]];
    
    [urlCacheUpdate start];
    
    NSLog(@"urlCacheUpdate %@", urlCacheUpdate);
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController *viewController1 = [[SKFirstViewController alloc] initWithNibName:@"SKFirstViewController" bundle:nil];
    UIViewController *viewController2 = [[SKSecondViewController alloc] initWithNibName:@"SKSecondViewController" bundle:nil];
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[viewController1, viewController2];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
