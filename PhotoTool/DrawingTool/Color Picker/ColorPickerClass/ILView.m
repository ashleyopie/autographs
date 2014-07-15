//
//  ILView.m
//  Indystar Autograph
//
//  Created by Indystar on 6/30/14.
//  Copyright (c) 2014 ___Indystar___. All rights reserved.
//

#import "ILView.h"

@interface ILView(Private)

-(void)deviceRotated:(NSNotification *)notification;
-(void)forceStartupOrientation;

@end

@implementation ILView

#pragma mark - Initialization/Deallocation

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        [self setup];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

-(void)setup
{
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceRotated:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    // trigger the orientation change after the app has time to init
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(forceStartupOrientation) userInfo:nil repeats:NO];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

#pragma mark - Orientation

-(void)deviceDidRotate:(UIDeviceOrientation)newOrientation
{
}

-(void)deviceRotated:(NSNotification *)notification
{
    [self deviceDidRotate:[[UIDevice currentDevice] orientation]];
}

-(void)forceStartupOrientation
{
    [self deviceDidRotate:[UIApplication sharedApplication].statusBarOrientation];
}


@end
