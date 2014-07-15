//
//  ILColorPickerExampleViewController.h
//  Indystar Autograph
//
//  Created by Indystar on 6/30/14.
//  Copyright (c) 2014 ___Indystar___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ILSaturationBrightnessPickerView.h"
#import "ILHuePickerView.h"

@interface ILColorPickerDualExampleController : UIViewController<ILSaturationBrightnessPickerViewDelegate> 
{
    IBOutlet UIView *colorChip;
    IBOutlet ILSaturationBrightnessPickerView *colorPicker;
    IBOutlet ILHuePickerView *huePicker;
    UIColor *ColorSave;
}

@property(nonatomic,retain)UIColor *ColorSave;

-(void)SetBorder:(UIView *)viewForBorder;

-(IBAction)SaveNewColor:(id)sender;

@end
