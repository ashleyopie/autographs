//
//  ILView.h
//  Indystar Autograph
//
//  Created by Indystar on 6/30/14.
//  Copyright (c) 2014 ___Indystar___. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Base view that handles orientation notification and a setup method that
 * is called regardless of which of the many ways the view was instantiated.
 */
@interface ILView : UIView {
    
}

/** 
 * Override in subclasses to do your setup code
 */
-(void)setup;

/**
 * Override in subclasses to handle device orientation changes.
 *
 * @param newOrientation The new device orientation
 */
-(void)deviceDidRotate:(UIDeviceOrientation)newOrientation;

@end
