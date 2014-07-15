//
//  AppDelegate.h
//  Indystar Autograph
//
//  Created by Indystar on 6/30/14.
//  Copyright (c) 2014 ___Indystar___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (nonatomic,retain)UINavigationController *NavigationControllerObj;

@end
