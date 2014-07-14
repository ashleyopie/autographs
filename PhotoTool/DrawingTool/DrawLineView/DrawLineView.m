/********************************************************************************\
 *
 * File Name       DrawLineView.m
 *
 \********************************************************************************/


#import "DrawLineView.h"

@implementation DrawLineView
@synthesize brushPattern;

#pragma mark - View lifecycle

-(void)dealloc
{    
    if(myPath)
    {
        [myPath release];
        myPath=nil;
    }
    if(bufferArray)
    {
        [bufferArray removeAllObjects];
        [bufferArray release];
        bufferArray=nil;
    }
    if(mutArrPathWithColor)
    {
        [mutArrPathWithColor removeAllObjects];
        [mutArrPathWithColor release];
        mutArrPathWithColor=nil;
    }
    if(amutArrLastColor)
    {
        [amutArrLastColor removeAllObjects];
        [amutArrLastColor release];
        amutArrLastColor=nil;
    }
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        boolEraseLine=FALSE;
        lineWidthFinal=5;
        self.backgroundColor = [UIColor clearColor];
        myPath = [[UIBezierPath alloc] init];
        myPath.lineCapStyle = kCGLineCapRound;
        myPath.miterLimit = 0;
        myPath.lineWidth=lineWidthFinal;
        bufferArray =  [[NSMutableArray alloc] init];
        mutArrPathWithColor = [[NSMutableArray alloc] init];      
     }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    for(int aIntCnt=0;aIntCnt<[mutArrPathWithColor count];aIntCnt++)
    {
        NSMutableDictionary *aDictRef=[mutArrPathWithColor objectAtIndex:aIntCnt];
        self.brushPattern=(UIColor*)[aDictRef objectForKey:@"LineColor"];
        [self.brushPattern setStroke];
        UIBezierPath *_path=(UIBezierPath *)[aDictRef objectForKey:@"LinePath"];
        [_path strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
    }
}

#pragma mark - Touch Methods

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(boolStatDraw==TRUE)//Start Drawing
    {
        myPath = [[UIBezierPath alloc] init];
        myPath.lineWidth=lineWidthFinal;
        UITouch *mytouch = [[touches allObjects] objectAtIndex:0];
        [myPath moveToPoint:[mytouch locationInView:self]];
        
        if(!self.brushPattern)
        {
            self.brushPattern=[UIColor whiteColor];
        }
        //Add Path & Color In Dictionary For Redo & Undo
        NSMutableDictionary *mutDictColorPath=[[NSMutableDictionary alloc]init];
        [mutDictColorPath setObject:myPath forKey:@"LinePath"];
        [mutDictColorPath setObject:self.brushPattern forKey:@"LineColor"];
        [mutArrPathWithColor addObject:mutDictColorPath];
        [mutDictColorPath release];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(boolStatDraw==TRUE)
    {
        UITouch *mytouch = [[touches allObjects] objectAtIndex:0];
        [myPath addLineToPoint:[mytouch locationInView:self]];
        [self setNeedsDisplay];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}

#pragma mark - EraseLine

-(void)EraseLine:(BOOL)boolErase CameraImg:(UIImage *)imgFromCamera PhotoRectSize:(CGRect)PhotoRect
{
    boolEraseLine=boolErase;
   if(boolEraseLine==TRUE)
   {
       //Set Proper PatternImage Frame & Size
       UIGraphicsBeginImageContext(PhotoRect.size);
       [imgFromCamera drawInRect:PhotoRect];
       UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
       UIGraphicsEndImageContext();
       
       //Set ColorWithPatternImage For Erase Drawing
       self.brushPattern=[UIColor colorWithPatternImage:img];
   }
   else
   {
       if(amutArrLastColor)
       {
           self.brushPattern=[amutArrLastColor lastObject];
       }
       else
       {
           self.brushPattern=[UIColor whiteColor];
       }
  }
}

#pragma mark - Set Line & Color 

-(void)LineDrawOrNot:(BOOL)boolDraw
{
    boolStatDraw=boolDraw;
}

-(void)LineWidthClicked:(int)intLineWidth
{
    if(!intLineWidth)
    {
        intLineWidth=5;
    }
    lineWidthFinal=intLineWidth;
}

-(void)Setcolor:(UIColor*)aColorRef
{
    self.brushPattern=aColorRef;
    amutArrLastColor=[[NSMutableArray alloc]init];
    [amutArrLastColor addObject:aColorRef];
}

#pragma mark - Undo/Redo/Clear Methods

-(void)undoButtonClicked
{
    if([mutArrPathWithColor count]>0)
    {
        UIBezierPath *_path = [mutArrPathWithColor lastObject];
        [bufferArray addObject:_path];
        [mutArrPathWithColor removeLastObject];
        [self setNeedsDisplay];
    }
}

-(void)redoButtonClicked
{
    if([bufferArray count]>0)
    {
        UIBezierPath *_path = [bufferArray lastObject];
        [mutArrPathWithColor addObject:_path];
        [bufferArray removeLastObject];
        [self setNeedsDisplay];
    }
}

-(void)BtnClearScreenClick
{
    [bufferArray removeAllObjects];
    [mutArrPathWithColor removeAllObjects];
    [self setNeedsDisplay];
}

@end
