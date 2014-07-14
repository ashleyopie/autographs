
/********************************************************************************\
 *
 * File Name       UIColor+GetHSB.h
 *
 \********************************************************************************/


#import <Foundation/Foundation.h>

typedef struct {
    float hue;
    float saturation;
    float brightness;
} HSBType;

@interface UIColor(GetHSB)

-(HSBType)HSB;

@end
