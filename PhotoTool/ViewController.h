//
//  ViewController.h
//  DrawingTool
//
//  
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
