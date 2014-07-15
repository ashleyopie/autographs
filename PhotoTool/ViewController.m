//
//  ViewController.m
//  Indystar Autograph
//
//  Created by Indystar on 6/30/14.
//  Copyright (c) 2014 ___Indystar___. All rights reserved.
//

#import "ViewController.h"
#import "DrawingToolVC.h"

@interface ViewController ()
@end

@implementation ViewController

#pragma mark - View lifecycle

- (void)dealloc
{
    [imgFullScreenPhoto release];
    imgFullScreenPhoto=nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    @try
    {
        [super viewWillAppear:animated];
        
        //Get Image From Document Directory
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:@"DrawTool.png"];
        
        UIImage *img = [UIImage imageWithContentsOfFile:getImagePath];
        if(img)
        {
            imgFullScreenPhoto.image=img;
        }
        else
        {
            imgFullScreenPhoto.image=[UIImage imageNamed:@"MainBG.png"];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"viewWillAppear(ViewController) :%@",exception);
    }
    @finally {
    }
}

#pragma mark - Event Method

-(IBAction)BtnEventClick:(id)sender
{
    @try
    {
        UIButton *btnRef=sender;
        NSArray *versionCompatibility = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
        if([btnRef tag]==0)//Share Photo in ios 6
        {
            int nVersion = [[versionCompatibility objectAtIndex:0] intValue];
            if ( nVersion < 6)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"IndyStar Autographs" message:@"Sharing Option Workes Only in iOS 6." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [alert show];
                [alert release];
                return;
            }
            NSURL *recipients = [NSURL URLWithString:@"www.goole.com"];
            //NSArray *activityItems = @[@"Indystar Autograph App", recipients]; //Only Msg
            NSArray *activityItems = @[imgFullScreenPhoto.image, @"Checkout my Indystar Colts Autographs", recipients]; //Msg With Image
            
            UIActivityViewController *activityController =[[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
            
            //Remove Any Item From Toolbar
            activityController.excludedActivityTypes=[NSArray arrayWithObjects:UIActivityTypeCopyToPasteboard,UIActivityTypePostToWeibo, nil];
            
            [self presentViewController:activityController animated:YES completion:nil];
            [activityController release];
        }
        if([btnRef tag]==1)//Camera
        {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                UIImagePickerController *imgPickerController = [[UIImagePickerController alloc] init];
                imgPickerController.delegate = self;
                imgPickerController.allowsEditing=NO;
                imgPickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
                imgPickerController.showsCameraControls=YES;
                [self presentViewController:imgPickerController animated:YES completion:nil];
            }
        }
        if([btnRef tag]==3)//Photo library
        {
            UIImagePickerController *imgPickerController = [[UIImagePickerController alloc] init];
            imgPickerController.delegate = self;
            imgPickerController.allowsEditing=NO;
            imgPickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            if (![[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)//iPad
            {
                imgPopOverCntroller = [[UIPopoverController alloc]initWithContentViewController:imgPickerController];
                imgPopOverCntroller.delegate=self;
                [imgPopOverCntroller presentPopoverFromRect:CGRectMake(-20,250,768,500)
                                                     inView:self.view
                                   permittedArrowDirections:NO
                                                   animated:YES];
            }
            else
            {
                if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
                {
                    [self presentViewController:imgPickerController animated:YES completion:nil];
                }
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"BtnEventClick :%@",exception);
    }
    @finally {
    }
}

#pragma mark - PickerView Method

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self DismissImagePickerView:picker];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    @try
    {
        UIImage *img =  [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [self PassImage:img];
        [self DismissImagePickerView:picker];
    }
    @catch (NSException *exception) {
        NSLog(@"imagePickerController :%@",exception);
    }
    @finally {
    }
}

-(void)DismissImagePickerView:(UIImagePickerController *)aPicker
{
    @try
    {
        if(imgPopOverCntroller.popoverVisible)
        {
            [imgPopOverCntroller dismissPopoverAnimated:YES];
            [imgPopOverCntroller release];
            imgPopOverCntroller=nil;
        }
        else
        {
            [aPicker dismissViewControllerAnimated:YES completion:nil];
            [aPicker release];
            aPicker=nil;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"DismissImagePickerView :%@",exception);
    }
    @finally {
    }
}

#pragma mark - Custom Method

-(void)PassImage:(UIImage *)imgForFullScreen
{
    @try
    {
        DrawingToolVC *DrawingToolVCObj=[[DrawingToolVC alloc]initWithNibName:@"DrawingToolVC" bundle:nil];
        DrawingToolVCObj.imgFromPicker = imgForFullScreen;
        [self.navigationController pushViewController:DrawingToolVCObj animated:YES];
        [DrawingToolVCObj release];
    }
    @catch (NSException *exception) {
        NSLog(@"PassImage :%@",exception);
    }
    @finally {
    }
}

#pragma mark - Set StatusBar Style

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Other Method

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
