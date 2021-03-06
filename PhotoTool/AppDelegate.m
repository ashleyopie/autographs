//
//  AppDelegate.m
//  Indystar Autograph
//
//  Created by Indystar on 6/30/14.
//  Copyright (c) 2014 ___Indystar___. All rights reserved.
//


#import "AppDelegate.h"

#import "ViewController.h"


@implementation AppDelegate

@synthesize NavigationControllerObj;

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [NSThread sleepForTimeInterval:2]; //add 5 seconds longer.
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];//Compalsary for ios 6
    self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    self.NavigationControllerObj = [[[UINavigationController alloc] initWithRootViewController:self.viewController] autorelease];
    
    //Set NSUserDefault For Tips For DrawingTool
    [[NSUserDefaults standardUserDefaults]setObject:@"Yes" forKey:@"Tips"];
    
    self.window.rootViewController = self.NavigationControllerObj;
    self.NavigationControllerObj.navigationBarHidden=TRUE;
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - Orientation Method

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - Other Method

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

@end
