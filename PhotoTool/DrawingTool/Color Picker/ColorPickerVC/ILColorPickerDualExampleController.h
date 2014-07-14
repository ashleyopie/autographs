
/********************************************************************************\
 *
 * File Name       ILColorPickerExampleViewController.h
 *
 \********************************************************************************/


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
