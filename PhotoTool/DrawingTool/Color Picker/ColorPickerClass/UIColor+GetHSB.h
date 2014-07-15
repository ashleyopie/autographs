//
//  UIColor+GetHSB.h
//  Indystar Autograph
//
//  Created by Indystar on 6/30/14.
//  Copyright (c) 2014 ___Indystar___. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
    float hue;
    float saturation;
    float brightness;
} HSBType;

@interface UIColor(GetHSB)

-(HSBType)HSB;

@end
