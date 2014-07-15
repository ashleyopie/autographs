//
//  ILSaturationBrightnessPicker.h
//  Indystar Autograph
//
//  Created by Indystar on 6/30/14.
//  Copyright (c) 2014 ___Indystar___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ILView.h"
#import "ILHuePickerView.h"

@class ILSaturationBrightnessPickerView;

/**
 * Delegate for ILSaturationBrightnessPicker
 */
@protocol ILSaturationBrightnessPickerViewDelegate

/**
 * Called when the color changes.
 *
 * @param newColor The new color
 * @param picker The picker whose color changed
 */
-(void)colorPicked:(UIColor *)newColor forPicker:(ILSaturationBrightnessPickerView *)picker;

@end

/**
 * View for picking the color's saturation and brightness
 */
@interface ILSaturationBrightnessPickerView : ILView<ILHuePickerViewDelegate> {
    id<ILSaturationBrightnessPickerViewDelegate> delegate;
    
    float hue;
    float saturation;
    float brightness;
    BOOL boolSetColor;
}

/**
 * Delegate
 */
@property (assign, nonatomic) IBOutlet id<ILSaturationBrightnessPickerViewDelegate> delegate;

/**
 * Get/Set the current hue
 */
@property (assign, nonatomic) float hue;

/**
 * Get/Set the current saturation
 */
@property (assign, nonatomic) float saturation;

/**
 * Get/Set the current brightness
 */
@property (assign, nonatomic) float brightness;

/**
 * The current color
 */
@property (assign, nonatomic) UIColor *color;


@end
