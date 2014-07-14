//
//  Constant.h
//  Autographs
//
//

#ifndef DrawingTool_Constant_h
#define DrawingTool_Constant_h

#define isIphone5()                         (([[UIScreen mainScreen] bounds].size.height <= 480.0) ? 0 : 1)
#define isIphone()                          (([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) ? 1 : 0)
#define isIOS7()                            (([[[UIDevice currentDevice] systemVersion]doubleValue] >= 7.0) ? 1 : 0)


#endif
