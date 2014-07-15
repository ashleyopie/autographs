//
//  ILColorPickerExampleViewController.m
//  Indystar Autograph
//
//  Created by Indystar on 6/30/14.
//  Copyright (c) 2014 ___Indystar___. All rights reserved.
//

#import "ILColorPickerDualExampleController.h"
#import "DrawingToolVC.h"
#include <QuartzCore/CoreAnimation.h>

@implementation ILColorPickerDualExampleController
@synthesize ColorSave;

#pragma mark - View lifecycle

- (void)dealloc 
{
    [ColorSave release];
    ColorSave=nil;
    
    if([huePicker superview])
    {
        [huePicker removeFromSuperview];
        [huePicker release];
        huePicker=nil;
    }
    
    if([colorPicker superview])
    {
        [colorPicker removeFromSuperview];
        [colorPicker release];
        colorPicker=nil;
    }
    
    if([colorChip superview])
    {
        [colorChip removeFromSuperview];
        [colorChip release];
        colorChip=nil;
    }
    
    [super dealloc];
}

- (void)viewDidLoad
{
    @try
    {
        [super viewDidLoad];
        
        // Build a random color to show off setting the color on the pickers
        UIColor *colorRandom=[UIColor colorWithRed:(arc4random()%100)/100.0f
                                             green:(arc4random()%100)/100.0f
                                              blue:(arc4random()%100)/100.0f
                                             alpha:1.0];
        
        colorChip.backgroundColor=colorRandom;
        colorPicker.color=colorRandom;
        huePicker.color=colorRandom;
        
        [self SetBorder:colorChip];
        [self SetBorder:huePicker];
    }
    @catch (NSException *exception) {
        NSLog(@"viewDidLoad(ILColorPickerDualExampleController) :%@",exception);
    }
    @finally {
    }
}

#pragma mark - ILSaturationBrightnessPickerDelegate implementation

-(void)colorPicked:(UIColor *)newColor forPicker:(ILSaturationBrightnessPickerView *)picker
{
    @try
    {
        colorChip.backgroundColor=newColor;
        self.ColorSave=newColor;
    }
    @catch (NSException *exception) {
        NSLog(@"colorPicked :%@",exception);
    }
    @finally {
    }
}

-(IBAction)SaveNewColor:(id)sender
{
    @try
    {
        DrawingToolVC * DrawingToolVCObj=[[self.navigationController viewControllers] objectAtIndex:[[self.navigationController viewControllers] count]-2];
        if(!self.ColorSave)
        {
            DrawingToolVCObj.colorpick=[UIColor grayColor];
        }
        else
        {
            DrawingToolVCObj.colorpick=self.ColorSave;
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    @catch (NSException *exception) {
        NSLog(@"SaveNewColor :%@",exception);
    }
    @finally {
    }
}

#pragma mark - Other Method

-(void)SetBorder:(UIView *)viewForBorder
{
    @try
    {
        viewForBorder.layer.borderColor=[[UIColor whiteColor]CGColor];
        [viewForBorder.layer setBorderWidth:2.0];
    }
    @catch (NSException *exception) {
        NSLog(@"SetBorder :%@",exception);
    }
    @finally {
    }
}

#pragma mark - Set StatusBar Style

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end
