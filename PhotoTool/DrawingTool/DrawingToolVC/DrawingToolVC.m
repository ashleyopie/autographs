
/********************************************************************************\
 *
 * File Name       DrawingToolVC.m
 *
 \********************************************************************************/

#import "DrawingToolVC.h"
#import "DrawLineView.h"
#include <QuartzCore/CoreAnimation.h>
#import "ILColorPickerDualExampleController.h"

@implementation DrawingToolVC
@synthesize drawScreen;
@synthesize colorpick,imgFromPicker,strFontStyle;


#pragma mark - View lifecycle

- (void)dealloc
{
    [imgViewPhoto release];
    imgViewPhoto=nil;
    [imgViewWidth release];
    imgViewWidth=nil;
    
    [imgFromPicker release];
    imgFromPicker=nil;
    
    [imgViewWidth release];
    imgViewWidth=nil;
    [colorpick release];
    colorpick=nil;
    
    [txtViewAddText release];
    txtViewAddText=nil;
    
    [lblFontStyle release];
    lblFontStyle=nil;
    [btnUpdown release];
    btnUpdown=nil;
    
    [strDropDown release];
    strDropDown=nil;
    [strFontStyle release];
    strFontStyle=nil;
    
    [sliderLineWidth release];
    sliderLineWidth=nil;
    
    if(tblViewDropDown)
    {
        [tblViewDropDown release];
        tblViewDropDown=nil;
    }
    if(tblViewStyle)
    {
        [tblViewStyle release];
        tblViewStyle=nil;
    }
    if([viewAddTool superview])
    {
        [viewAddTool removeFromSuperview];
        [viewAddTool release];
        viewAddTool=nil;
    }
    if([viewTips superview])
    {
        [viewTips removeFromSuperview];
        [viewTips release];
        viewTips=nil;
    }
    
    if([drawScreen superview])
    {
        [drawScreen removeFromSuperview];
        [drawScreen release];
        drawScreen=nil;
    }
    if(scrViewTool)
    {
        [scrViewTool setDelegate:nil];
        [scrViewTool release];
        scrViewTool=nil;
    }
    
    if(arrFont)
    {
        [arrFont release];
        arrFont=nil;
    }
    if(arrStyle)
    {
        [arrStyle release];
        arrStyle=nil;
    }
    
    [super dealloc];
}

- (void)viewDidLoad
{
    @try
    {
        [super viewDidLoad];
        
        boolDrawShow=TRUE;
        boolFontSize=TRUE;
        boolFontStyle=TRUE;
        btnUndo.enabled=NO;
        btnRedo.enabled=NO;
        
        
        intIOS7=0;
        if(isIOS7())
            intIOS7=20;
        
        
        intIPhone5=0;
        if(isIphone5())
            intIPhone5=88;
        
        //Set NSUserDefault For Tips For DrawingTool
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"Tips"] isEqualToString:@"Yes"])
        {
            [self.view addSubview:viewTips];
        }
        boolCheckUnCheck=TRUE;
        boolText = TRUE;
        boolDraw = TRUE;
        intTag=200;
        
        if(!self.imgFromPicker)
        {
            self.imgFromPicker=[UIImage imageNamed:@"MainBG.png"];
        }
        imgViewPhoto.image=self.imgFromPicker;
        colorpick=[UIColor whiteColor];
        
        //Draw Line
        int intImgHeight=0;
        if(isIphone())
            intImgHeight=460+intIPhone5;
        else
            intImgHeight=imgViewPhoto.frame.size.height;
        
        self.drawScreen = [[[DrawLineView alloc] initWithFrame:CGRectMake(imgViewPhoto.frame.origin.x, imgViewPhoto.frame.origin.y-intIOS7, imgViewPhoto.frame.size.width, intImgHeight)]autorelease];
        self.drawScreen.backgroundColor = [UIColor clearColor];
        self.drawScreen.userInteractionEnabled = YES ;
        self.drawScreen.multipleTouchEnabled = YES ;
        
        //ToolView
        [imgViewPhoto addSubview:viewAddTool];
        
        floatFont=14;
        if (!isIphone())//iPad
        {
            intIPadFrame=2;
            floatFont=floatFont*intIPadFrame;
            [viewAddTool setFrame:CGRectMake(0, 855, viewAddTool.frame.size.width, 250)];
            [scrViewTool setFrame:CGRectMake(0, 73*2, scrViewTool.frame.size.width*2, scrViewTool.frame.size.height*2)];
            [self iPadKeyBoardHideBtnClick];
        }
        else
        {
            intIPadFrame=1;
            [viewAddTool setFrame:CGRectMake(0, 385+intIPhone5, viewAddTool.frame.size.width, 145)];
            [scrViewTool setFrame:CGRectMake(0, 73, scrViewTool.frame.size.width, scrViewTool.frame.size.height)];
        }
        
        [viewAddTool addSubview:scrViewTool];
        [scrViewTool setScrollEnabled:NO];
        
        sliderLineWidth.minimumTrackTintColor=[UIColor redColor];
        sliderLineWidth.maximumTrackTintColor=[UIColor grayColor];
        sliderLineWidth.thumbTintColor=[UIColor whiteColor];
        sliderLineWidth.contentMode = UIViewContentModeScaleToFill;
        sliderLineWidth.minimumValue = 1.0;
        sliderLineWidth.maximumValue = 40.0;
        sliderLineWidth.continuous = YES;
        [sliderLineWidth setValue:5.0];
        [sliderLineWidth addTarget:self action:@selector(sliderValueChange) forControlEvents:UIControlEventValueChanged];
        
        //DropDownBox Code
        self.strFontStyle=@"Helvetica";
        lblFontStyle.text=self.strFontStyle;
        arrFont = [[NSMutableArray alloc]initWithObjects:@"14",@"16",@"18",@"20",@"22",@"24",@"26",@"28",@"30",@"32",@"34",nil];
        arrStyle = [[NSMutableArray alloc]initWithObjects:@"Times New Roman",
                    @"Party LET",@"Helvetica",@"Palatino",
                    @"Papyrus Condensed",@"Arial",
                    @"Snell Roundhand",
                    @"American Typewriter",
                    @"Courier",
                    @"AvenirNext",
                    @"Bodoni 72 Smallcaps",nil];
        
    }
    @catch (NSException *exception) {
        NSLog(@"viewDidLoad(DrawingToolVC) :%@",exception);
    }
    @finally {
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    @try
    {
        [super viewWillAppear:animated];
        
        //Set Color For Drawing & Text
        [((DrawLineView *)drawScreen) Setcolor:colorpick];
        lblFontStyle.textColor=colorpick;
    }
    @catch (NSException *exception) {
        NSLog(@"viewWillAppear(DrawingToolVC) :%@",exception);
    }
    @finally {
    }
}

#pragma mark - Event Method

//Photo Tool Button Clicks
-(IBAction)BtnEventClick:(id)sender
{
    @try
    {
        UIButton *btnRef=sender;
        if([btnRef tag]==0)//Cancel & Back
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        if([btnRef tag]==1)//Text
        {
            btnText.enabled=NO;
            btnDraw.enabled=YES;
            btnUndo.enabled=NO;
            btnRedo.enabled=NO;
            
            [self UpDownViewClick:FALSE];
            [((DrawLineView *)drawScreen) LineDrawOrNot:FALSE];
            
            boolLableTouch=TRUE;
            UITapGestureRecognizer *aTapGestureAddLable=[[UITapGestureRecognizer  alloc]initWithTarget:self action:@selector(AddLableTapGestureClick)];
            [aTapGestureAddLable setDelegate:self];
            aTapGestureAddLable.numberOfTapsRequired=2;
            [self.drawScreen addGestureRecognizer:aTapGestureAddLable];
            [self.drawScreen addSubview:viewAddTool];
            [imgViewPhoto addSubview:self.drawScreen];
            [aTapGestureAddLable release];
        }
        if([btnRef tag]==2)//Undo
        {
            if(boolLableTouch==FALSE)
            {
                [((DrawLineView *)drawScreen) undoButtonClicked];
            }
        }
        if([btnRef tag]==3)//Redo
        {
            if(boolLableTouch==FALSE)
            {
                [((DrawLineView *)drawScreen) redoButtonClicked];
            }
        }
        if([btnRef tag]==4)//Color
        {
            //ColorPicker VC
            [self HideFontStyleTableview];
            ILColorPickerDualExampleController *ColorPickerVCObj=[[ILColorPickerDualExampleController alloc]initWithNibName:@"ILColorPickerDualExampleController" bundle:nil];
            [self.navigationController pushViewController:ColorPickerVCObj animated:YES];
            [ColorPickerVCObj release];
        }
        if([btnRef tag]==5)//Save
        {
            [self HideFontStyleTableview];
            [self RemoveTextview];
            [viewAddTool removeFromSuperview];
            
            UIGraphicsBeginImageContext(imgViewPhoto.frame.size);
            [imgViewPhoto.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            imgViewPhoto.image=viewImage;
            
            //Save image in Document Directory
            NSString *strPath = [NSString stringWithFormat:@"%@/DrawTool.png",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]];
            NSData *imageData = UIImagePNGRepresentation(viewImage);
            [imageData writeToFile:strPath atomically:YES];
            [self.navigationController popViewControllerAnimated:YES];
            
            [imgViewPhoto setImage:nil];
            [((DrawLineView *)drawScreen) BtnClearScreenClick];
        }
        if([btnRef tag]==8)//Draw
        {
            [self HideFontStyleTableview];
            btnText.enabled=YES;
            btnDraw.enabled=NO;
            btnUndo.enabled=YES;
            btnRedo.enabled=YES;
            
            boolLableTouch=FALSE;
            [((DrawLineView *)drawScreen) LineDrawOrNot:TRUE];
            
            [((DrawLineView *)self.drawScreen)EraseLine:FALSE CameraImg:imgViewPhoto.image PhotoRectSize:CGRectMake(self.drawScreen.frame.origin.x, self.drawScreen.frame.origin.y, self.drawScreen.frame.size.width, self.drawScreen.frame.size.height)];
            [imgViewPhoto addSubview:self.drawScreen];
            [self.drawScreen addSubview:viewAddTool];
            [self UpDownViewClick:TRUE];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"BtnEventClick :%@",exception);
    }
    @finally {
    }
}

-(IBAction)ViewUpDownClick:(id)sender
{
    @try
    {
        int aIntYPos=0;
        int aIntHeight=0;
        int aIntYPosNew=0;
        
        if (isIphone())
        {
            aIntYPos=385+intIPhone5;
            aIntHeight=145;
            aIntYPosNew=336+intIPhone5;
        }
        else
        {
            aIntYPos=854;
            aIntHeight=250;
            aIntYPosNew=755;
        }
        
        if(boolDraw)
        {
            boolDraw=FALSE;
            [btnUpdown setImage:[UIImage imageNamed:@"InArrow"] forState:UIControlStateNormal];
            [self ShowUPDownAnimation:viewAddTool OldFrame:CGRectMake(0, aIntYPos, viewAddTool.frame.size.width, aIntHeight) NewFrame:CGRectMake(0, aIntYPosNew, viewAddTool.frame.size.width, aIntHeight) Duration:0.4];
        }
        else
        {
            boolDraw=TRUE;
            [btnUpdown setImage:[UIImage imageNamed:@"OutArrow"] forState:UIControlStateNormal];
            [self ShowUPDownAnimation:viewAddTool OldFrame:CGRectMake(0, aIntYPosNew, viewAddTool.frame.size.width, aIntHeight) NewFrame:CGRectMake(0, aIntYPos, viewAddTool.frame.size.width, aIntHeight) Duration:0.4];
        }
        
        [self HideFontStyleTableview];
    }
    @catch (NSException *exception) {
        NSLog(@"ViewUpDownClick :%@",exception);
    }
    @finally {
    }
}

//Animation For View UpDown
-(void)ShowUPDownAnimation:(UIView *)aView OldFrame:(CGRect)aOldFrame NewFrame:(CGRect)aNewFrame Duration:(NSTimeInterval)aDuration
{
    @try
    {
        [aView setFrame:aOldFrame];
        [UIView animateWithDuration:aDuration animations:^{
            [aView setFrame:aNewFrame];
        }completion:^(BOOL finished) {
            if (finished) {
            }
        }];
        [scrViewTool setBackgroundColor:[UIColor clearColor]];
    }
    @catch (NSException *exception) {
        NSLog(@"ShowUPDownAnimation :%@",exception);
    }
    @finally {
    }
}

//Erase Line
-(IBAction)BtnEraseLineClick:(id)sender
{
    @try
    {
        UIButton *aBtnRef=sender;
        if([aBtnRef tag]==1)//Add Line
        {
            [((DrawLineView *)self.drawScreen)EraseLine:FALSE CameraImg:imgViewPhoto.image PhotoRectSize:CGRectMake(self.drawScreen.frame.origin.x, self.drawScreen.frame.origin.y, self.drawScreen.frame.size.width, self.drawScreen.frame.size.height)];
            [self.drawScreen addSubview:viewAddTool];
            [imgViewPhoto addSubview:self.drawScreen];
        }
        else//Erase Line
        {
            [((DrawLineView *)self.drawScreen)EraseLine:TRUE CameraImg:imgViewPhoto.image PhotoRectSize:CGRectMake(self.drawScreen.frame.origin.x, self.drawScreen.frame.origin.y, self.drawScreen.frame.size.width, self.drawScreen.frame.size.height)];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"BtnEraseLineClick :%@",exception);
    }
    @finally {
    }
}

//DropDown Btn Click
-(IBAction)BtnDropDownClick:(id)sender
{
    @try
    {
        if(btnText.enabled==NO)
        {
            [self RemoveFontStyleTableview];
            UIButton *btnRef=sender;
            if([btnRef tag]==1)
            {
                if(boolFontSize)
                {
                    boolFontStyle=TRUE;
                    boolFontSize=FALSE;
                    if (!isIphone())//iPad
                    {
                        if(!tblViewDropDown)
                        {
                            tblViewDropDown = [[UITableView alloc]initWithFrame:CGRectMake(0, 144, 130, 660) style:UITableViewStylePlain];
                        }
                    }
                    else
                    {
                        if(!tblViewDropDown)
                        {
                            tblViewDropDown = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, 74, 330) style:UITableViewStylePlain];
                        }
                    }
                    
                    if(isIOS7())
                        [tblViewDropDown setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
                    
                    tblViewDropDown.dataSource=self;
                    tblViewDropDown.delegate=self;
                    tblViewDropDown.bounces=FALSE;
                    tblViewDropDown.rowHeight=30*intIPadFrame;
                    tblViewDropDown.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"SideStripInBig.png"]];
                    [self.drawScreen addSubview:tblViewDropDown];
                    strDropDown=@"Font";
                }
                else
                {
                    boolFontSize=TRUE;
                }
            }
            else
            {
                if(boolFontStyle)
                {
                    boolFontSize=TRUE;
                    boolFontStyle=FALSE;
                    if (!isIphone())//iPad
                    {
                        if(!tblViewStyle)
                        {
                            tblViewStyle = [[UITableView alloc]initWithFrame:CGRectMake(468, 144, 300, 660) style:UITableViewStylePlain];
                        }
                    }
                    else
                    {
                        if(!tblViewStyle)
                        {
                            tblViewStyle = [[UITableView alloc]initWithFrame:CGRectMake(168, 30, 152, 330) style:UITableViewStylePlain];
                        }
                    }
                    
                    if(isIOS7())
                        [tblViewStyle setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
                    
                    tblViewStyle.dataSource=self;
                    tblViewStyle.delegate=self;
                    tblViewStyle.bounces=FALSE;
                    tblViewStyle.rowHeight=30*intIPadFrame;
                    tblViewStyle.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"SideStripInBig.png"]];
                    [self.drawScreen addSubview:tblViewStyle];
                    strDropDown=@"Style";
                }
                else
                {
                    boolFontStyle=TRUE;
                }
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"BtnDropDownClick :%@",exception);
    }
    @finally {
    }
}

//Cancel Click For Tips Screen
-(IBAction)BtnCancelTipsClick:(id)sender
{
    @try
    {
        UIButton *btnRef=sender;
        if([btnRef tag]==1)
        {
            if(boolCheckUnCheck==TRUE)
            {
                boolCheckUnCheck=FALSE;
                [btnDoNotShowTips setImage:[UIImage imageNamed:@"Checkmark.png"] forState:UIControlStateNormal];
                [[NSUserDefaults standardUserDefaults]setObject:@"No" forKey:@"Tips"];
            }
            else
            {
                boolCheckUnCheck=TRUE;
                [btnDoNotShowTips setImage:[UIImage imageNamed:@"Uncheck.png"] forState:UIControlStateNormal];
                [[NSUserDefaults standardUserDefaults]setObject:@"Yes" forKey:@"Tips"];
            }
        }
        else
        {
            [viewTips removeFromSuperview];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"BtnCancelTipsClick :%@",exception);
    }
    @finally {
    }
}

#pragma mark - Other Methods

//Add Lable Method
//Set Text in Lable
-(void)getLabel:(id)aLblText
{
    @try
    {
        NSString *strLabelText = @"";
        if ([aLblText isKindOfClass:[NSArray class]])
        {
            for (NSString *aContact in aLblText)
            {
                if ([strLabelText isEqualToString:@""])
                {
                    strLabelText = aContact;
                }
                else
                {
                    strLabelText = [NSString stringWithFormat:@"%@\n%@",strLabelText,aContact] ;
                }
            }
        }
        else
        {
            strLabelText = aLblText;
        }
        if (!isIphone())//iPad
        {
            lblAddText=[[UILabel alloc]initWithFrame:CGRectMake(15, 25, 740, 180)];
        }
        else
        {
            lblAddText=[[UILabel alloc]initWithFrame:CGRectMake(10, 25, 300, 180)];
        }
        [lblAddText setFont:[UIFont fontWithName:self.strFontStyle size:floatFont]];
        lblAddText.text = strLabelText;
        
        if(![[txtViewAddText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0)
        {
            boolTextView=FALSE;
            lblAddText.userInteractionEnabled = YES ;
            lblAddText.multipleTouchEnabled = YES ;
            [lblAddText setTextAlignment:NSTextAlignmentCenter];
            lblAddText.lineBreakMode = NSLineBreakByWordWrapping;
            [lblAddText setBackgroundColor:[UIColor clearColor]];
            lblAddText.textColor = colorpick;
            
            CGSize size = [lblAddText.text sizeWithFont:lblAddText.font constrainedToSize:lblAddText.frame.size lineBreakMode:NSLineBreakByWordWrapping];
            CGRect newFrame = lblAddText.frame;
            newFrame.size.height = size.height;
            lblAddText.frame = newFrame;
            lblAddText.numberOfLines = 0;
            [lblAddText sizeToFit];
            [self.drawScreen addSubview:lblAddText];
            [self.drawScreen addSubview:viewAddTool];
            
            //Single Tap For Move Text
            UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPiece:)];
            [panGesture setMaximumNumberOfTouches:1];
            [panGesture setDelegate:self];
            [lblAddText addGestureRecognizer:panGesture];
            [panGesture release];
            
            //LongPress For Delete Text
            UILongPressGestureRecognizer *aLongPressGestureRecognizerObj = [[UILongPressGestureRecognizer alloc]                                                                        initWithTarget:self action:@selector(RemoveLableLongPress:)];
            aLongPressGestureRecognizerObj.minimumPressDuration = 0.5;
            aLongPressGestureRecognizerObj.delegate = self;
            [lblAddText addGestureRecognizer:aLongPressGestureRecognizerObj];
            [aLongPressGestureRecognizerObj release];
        }
        else
        {
            [txtViewAddText removeFromSuperview];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"getLabel :%@",exception);
    }
    @finally {
    }
}

//DrawingTool View Animation
-(void)UpDownViewClick:(BOOL)boolTextDraw
{
    @try
    {
        int aIntYPos=0;
        int aIntXPos=0;
        int aIntXPosNew=0;
        
        if (isIphone())
        {
            aIntYPos=73;
            aIntXPosNew=-320;
        }
        else
        {
            aIntYPos=149;
            aIntXPosNew=-768;
        }
        
        [scrViewTool setContentSize:CGSizeMake(scrViewTool.frame.size.width*2, scrViewTool.frame.size.height)];
        if(boolTextDraw)//Draw
        {
            if(boolDrawShow)
            {
                boolDrawShow=FALSE;
                [self ShowUPDownAnimation:scrViewTool OldFrame:CGRectMake(aIntXPos, aIntYPos, scrViewTool.frame.size.width, scrViewTool.frame.size.height) NewFrame:CGRectMake(aIntXPosNew, aIntYPos, scrViewTool.frame.size.width*2, scrViewTool.frame.size.height) Duration:0.4];
            }
        }
        else//Text
        {
            if(!boolDrawShow)
            {
                boolDrawShow=TRUE;
                [self ShowUPDownAnimation:scrViewTool OldFrame:CGRectMake(aIntXPosNew, aIntYPos, scrViewTool.frame.size.width*2, scrViewTool.frame.size.height) NewFrame:CGRectMake(aIntXPos, aIntYPos, scrViewTool.frame.size.width*2, scrViewTool.frame.size.height) Duration:0.4];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"UpDownViewClick :%@",exception);
    }
    @finally {
    }
}

#pragma mark - Tap Click Method

-(void)AddLableTapGestureClick
{
    @try
    {
        //Add TextView For Each Click
        if(boolLableTouch)
        {
            [self RemoveTextview];
            [self HideFontStyleTableview];
            
            intTag=intTag+1;
            boolTextView=TRUE;
            txtViewAddText = [[UITextView alloc] init];
            if (!isIphone())//iPad
            {
                [txtViewAddText setFrame:CGRectMake(16, 24, imgViewPhoto.frame.size.width-30, 134)];
            }
            else
            {
                [txtViewAddText setFrame:CGRectMake(15, 12, imgViewPhoto.frame.size.width-30, 67)];
            }
            txtViewAddText.editable=YES;
            txtViewAddText.layer.cornerRadius = 8*intIPadFrame;
            txtViewAddText.tag=intTag;
            txtViewAddText.delegate=self;
            [txtViewAddText setFont:[UIFont fontWithName:self.strFontStyle size:14*intIPadFrame]];
            txtViewAddText.scrollEnabled=NO;
            txtViewAddText.textAlignment = NSTextAlignmentLeft;
            txtViewAddText.returnKeyType = UIReturnKeyDone;
            [self.drawScreen addSubview:txtViewAddText];
            [txtViewAddText becomeFirstResponder];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"AddLableTapGestureClick :%@",exception);
    }
    @finally {
    }
}

-(void)RemoveLableLongPress:(UILongPressGestureRecognizer *) gesture
{
    @try
    {
        if(boolLableTouch)
        {
            LongPressGestureRecognizerObj=gesture;
            if ([gesture state] == UIGestureRecognizerStateBegan)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Drawing Tool" message:@"Do you want to Delete this Text?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
                [alert show];
                [alert release];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"RemoveLableLongPress :%@",exception);
    }
    @finally {
    }
}

#pragma mark - PanGesture Methods

//Move Text Anywhere Using This PanGesture methods
- (void)panPiece:(UIPanGestureRecognizer *)gestureRecognizer
{
    @try
    {
        if(boolLableTouch==TRUE)
        {
            UIView *piece = [gestureRecognizer view];
            [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
            
            if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged)
            {
                CGPoint translation = [gestureRecognizer translationInView:[piece superview]];
                [piece setCenter:CGPointMake([piece center].x + translation.x, [piece center].y + translation.y)];
                [gestureRecognizer setTranslation:CGPointZero inView:[piece superview]];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"panPiece :%@",exception);
    }
    @finally {
    }
}

- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    @try
    {
        if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
        {
            UIView *piece = gestureRecognizer.view;
            CGPoint locationInView = [gestureRecognizer locationInView:piece];
            CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
            piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
            piece.center = locationInSuperview;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"adjustAnchorPointForGestureRecognizer :%@",exception);
    }
    @finally {
    }
}

#pragma mark - Alert Method

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    @try
    {
        if(buttonIndex==1)//Delete YES
        {
            //Delete Text
            UITextView *aTxtVwTag=(UITextView*)[self.drawScreen viewWithTag:[LongPressGestureRecognizerObj view].tag];
            if(aTxtVwTag.tag == [LongPressGestureRecognizerObj view].tag)
            {
                [[LongPressGestureRecognizerObj view] removeFromSuperview];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"clickedButtonAtIndex :%@",exception);
    }
    @finally {
    }
}

#pragma mark - TextView Methods

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if(boolTextView==TRUE)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    @try
    {
        NSUInteger newLength = [textView.text length] + [text length] - range.length;
        if(!(newLength > 99) ? NO : YES)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Drawing Tool" message:@"Can Not Type More than 100 Characters." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            
            return NO;
        }
        
        if([text isEqualToString:@"\n"])
        {
           if(isIphone())
           {
                [self RemoveTextview];
                [self getLabel:txtViewAddText.text];
           }
            [textView resignFirstResponder];
        }
        return YES;
    }
    @catch (NSException *exception) {
        NSLog(@"shouldChangeTextInRange :%@",exception);
    }
    @finally {
    }
}

#pragma mark - TableView Method

//TableView Methods For Font & Style
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([strDropDown isEqualToString:@"Font"])
    {
        return [arrFont count];
    }
    else
    {
        return [arrStyle count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifire=@"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifire];
    
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifire]autorelease];
    }
    if([strDropDown isEqualToString:@"Font"])
    {
        cell.textLabel.text=[NSString stringWithFormat:@"%@",[arrFont objectAtIndex:indexPath.row]];
    }
    else
    {
        cell.textLabel.text=[NSString stringWithFormat:@"%@",[arrStyle objectAtIndex:indexPath.row]];
    }
    cell.textLabel.textAlignment=NSTextAlignmentCenter;//UITextAlignmentCenter;
    [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:14*intIPadFrame]];
    cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"SideStripInBig.png"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try
    {
        if([strDropDown isEqualToString:@"Font"])
        {
            [tblViewDropDown removeFromSuperview];
            floatFont=[[arrFont objectAtIndex:indexPath.row]floatValue];
            if (!isIphone())//iPad
            {
                floatFont=floatFont*2;
            }
        }
        else
        {
            self.strFontStyle = [NSString stringWithFormat:@"%@", [arrStyle objectAtIndex:indexPath.row]];
            [tblViewStyle removeFromSuperview];
        }
        lblFontStyle.text=self.strFontStyle;
        [lblFontStyle setFont:[UIFont fontWithName:self.strFontStyle size:floatFont]];
    }
    @catch (NSException *exception) {
        NSLog(@"didSelectRowAtIndexPath :%@",exception);
    }
    @finally {
    }
}

-(void)HideFontStyleTableview
{
    boolFontStyle=TRUE;
    boolFontSize=TRUE;
    [self RemoveFontStyleTableview];
}

-(void)RemoveFontStyleTableview
{
    if(tblViewStyle)
        [tblViewStyle removeFromSuperview];
    
    if(tblViewDropDown)
        [tblViewDropDown removeFromSuperview];
}

-(void)RemoveTextview
{
    if([txtViewAddText isFirstResponder])
    {
        [txtViewAddText removeFromSuperview];
    }
}

#pragma mark - Slider Methods

-(void)customizeSlider
{
    @try
    {
        sliderLineWidth.contentMode = UIViewContentModeScaleToFill;
        sliderLineWidth.minimumValue = 1.0;
        sliderLineWidth.maximumValue = 40.0;
        sliderLineWidth.continuous = YES;
        [sliderLineWidth setValue:5.0];
        [sliderLineWidth addTarget:self action:@selector(sliderValueChange) forControlEvents:UIControlEventValueChanged];
    }
    @catch (NSException *exception) {
        NSLog(@"customizeSlider :%@",exception);
    }
    @finally {
    }
}

//Set Value From Slider For Drawing Line
-(void)sliderValueChange
{
    @try
    {
        int aIntSliderValue=(int)sliderLineWidth.value;
        CGPoint center = imgViewWidth.center;
        [imgViewWidth setFrame:CGRectMake(imgViewWidth.center.x, imgViewWidth.center.y, (sliderLineWidth.value+2), (sliderLineWidth.value+2))];
        imgViewWidth.center = center;
        [((DrawLineView *)self.drawScreen) LineWidthClicked:aIntSliderValue];
    }
    @catch (NSException *exception) {
        NSLog(@"sliderValueChange :%@",exception);
    }
    @finally {
    }
}

#pragma mark - iPadKeyboard WillHideHandler

-(void)iPadKeyBoardHideBtnClick
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(iPadKeyboardWillHideHandler:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)iPadKeyboardWillHideHandler:(NSNotification *)notification
{
    [self RemoveTextview];
    [txtViewAddText resignFirstResponder];
    [self getLabel:txtViewAddText.text];
}

#pragma mark - Set StatusBar Style

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Extra Method

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


@end 
