//
//  DrawingToolVC.h
//  Indystar Autograph
//
//  Created by Mary Ashley Opie on 6/30/14.
//  Copyright (c) 2014 ___Ashleyopie___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface DrawingToolVC : UIViewController<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    //Main FullScreen ImageView
    IBOutlet UIImageView *imgViewPhoto;
  
    //Add LableView
    IBOutlet UITextView *txtViewAddText;
    IBOutlet UIView *viewAddTool;
    UILabel *lblAddText;
    int intTag;
    BOOL boolTextView;
    BOOL boolLableTouch;
        
    //Add UpDownView Animation
    IBOutlet UIScrollView *scrViewTool;
    IBOutlet UISlider *sliderLineWidth;
    IBOutlet UIImageView *imgViewWidth;
    IBOutlet UIButton *btnUpdown;
    BOOL boolText;
    BOOL boolDraw;
    
    //DropDownBox
    IBOutlet UILabel *lblFontStyle;
    UITableView *tblViewDropDown,*tblViewStyle;
    NSMutableArray *arrFont;
    NSMutableArray *arrStyle;
    NSString *strDropDown;
    NSString *strFontStyle;
    float floatFont;
    int intIPadFrame;
    
    //Tips Screen
    IBOutlet UIView *viewTips;
    IBOutlet UIButton *btnDoNotShowTips;
    UILongPressGestureRecognizer *LongPressGestureRecognizerObj;
    BOOL boolCheckUnCheck;
    
    IBOutlet UIButton *btnText,*btnDraw,*btnUndo,*btnRedo;
    BOOL boolFontSize;
    BOOL boolFontStyle;
    
    //IOS7
    int intIOS7;
    int intIPhone5;
    BOOL boolDrawShow;
}

@property (nonatomic,retain)UIImage *imgFromPicker; 

//Draw Line
@property (nonatomic,retain) UIView *drawScreen;
-(IBAction)BtnEventClick:(id)sender;

//Color Picker
@property(nonatomic,retain)UIColor *colorpick;

//Add LableView
-(void)getLabel:(id)aLblText;
-(void)RemoveTextview;
-(void)panPiece:(UIPanGestureRecognizer *)gestureRecognizer;
-(void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;
-(void)RemoveLableLongPress:(UILongPressGestureRecognizer *) gesture;
-(void)AddLableTapGestureClick;

//Add UpDownView Animation
-(void)UpDownViewClick:(BOOL)boolTextDraw;
-(IBAction)ViewUpDownClick:(id)sender;
-(IBAction)BtnEraseLineClick:(id)sender;

//DropDownBox For Font
@property(nonatomic,retain)NSString *strFontStyle;
-(void)RemoveFontStyleTableview;
-(IBAction)BtnDropDownClick:(id)sender;

//Tips Screen
-(IBAction)BtnCancelTipsClick:(id)sender;

@end
