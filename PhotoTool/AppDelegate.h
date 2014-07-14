//
//  AppDelegate.h
//  DrawingTool
//
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (nonatomic,retain)UINavigationController *NavigationControllerObj;

@end
