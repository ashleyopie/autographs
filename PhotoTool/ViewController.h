//
//  ViewController.h
//  Indystar Autograph
//
//  Created by Indystar on 6/30/14.
//  Copyright (c) 2014 ___Indystar___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPopoverControllerDelegate>
{
    IBOutlet UIImageView *imgFullScreenPhoto;
    UIPopoverController *imgPopOverCntroller;  
}



                     
-(void)PassImage:(UIImage *)imgForFullScreen;
-(void)DismissImagePickerView:(UIImagePickerController *)aPicker;

-(IBAction)BtnEventClick:(id)sender;

@end
