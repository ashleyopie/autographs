
/********************************************************************************\
 *
 * File Name       DrawLineView.h
 *
 \********************************************************************************/


#import <UIKit/UIKit.h>
#import "ILColorPickerDualExampleController.h"

@interface DrawLineView : UIView
{
    ILColorPickerDualExampleController *ColorPickerVCObj;
    UIBezierPath *myPath;
    UIColor *brushPattern;
    UIImageView *imgView;
    
    NSMutableArray *bufferArray;
    NSMutableArray *mutArrPathWithColor;
    NSMutableArray *amutArrLastColor;

    int lineWidthFinal;
    BOOL boolEraseLine;
    BOOL boolStatDraw;
}

@property(nonatomic,retain)UIColor *brushPattern;

-(void)Setcolor:(UIColor*)aColorRef;
-(void)undoButtonClicked;
-(void)redoButtonClicked;
-(void)BtnClearScreenClick;
-(void)LineWidthClicked:(int)intLineWidth;
-(void)EraseLine:(BOOL)boolErase CameraImg:(UIImage *)imgFromCamera PhotoRectSize:(CGRect)PhotoRect;
-(void)LineDrawOrNot:(BOOL)boolDraw;

@end
