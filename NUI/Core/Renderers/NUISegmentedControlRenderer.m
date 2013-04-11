//
//  NUISegmentedControlRenderer.m
//  NUIDemo
//
//  Created by Tom Benner on 11/24/12.
//  Copyright (c) 2012 Tom Benner. All rights reserved.
//

#import "NUISegmentedControlRenderer.h"

@implementation NUISegmentedControlRenderer

+ (void)render:(UISegmentedControl*)control withClass:(NSString*)className
{
    if ([NUISettings hasProperty:@"background-color" withClass:className] ||
        [NUISettings hasProperty:@"border-color" withClass:className]) {
        CALayer *layer = [NUIGraphics roundedRectLayerWithClass:className];
        UIImage *normalImage = [NUIGraphics roundedRectImageWithClass:className layer:layer];
        
        if ([NUISettings hasProperty:@"background-color-selected" withClass:className]) {
            [layer setBackgroundColor:[[NUISettings getColor:@"background-color-selected" withClass:className] CGColor]];
        }
        UIImage *selectedImage = [NUIGraphics roundedRectImageWithClass:className layer:layer];
        [control setBackgroundImage:normalImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [control setBackgroundImage:selectedImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        if ([NUISettings hasProperty:@"border-color" withClass:className]) {
            [control setDividerImage:[NUISettings getImageFromColor:@"border-color" withClass:className] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        }
    }
    
    // Set background tint color
    if ([NUISettings hasProperty:@"background-tint-color" withClass:className]) {
        // UISegmentedControlStyleBar is necessary for setTintColor to take effect
        control.segmentedControlStyle = UISegmentedControlStyleBar;
        [control setTintColor:[NUISettings getColor:@"background-tint-color" withClass:className]];
    }
    
    
    // Set background gradient
    if ([NUISettings hasProperty:@"background-color-selected-top" withClass:className]) {
        CAGradientLayer *gradientLayer = [NUIGraphics
                                          gradientLayerWithTop:[NUISettings getColor:@"background-color-selected-top" withClass:className]
                                          bottom:[NUISettings getColor:@"background-color-selected-bottom" withClass:className]
                                          frame:control.bounds
                                          cornerRadius:[NUISettings getFloat:@"corner-radius" withClass:className]];
        int backgroundLayerIndex = [control.layer.sublayers count] == 1 ? 0 : 1;
        
        UIImage *selectedImage = [NUIGraphics roundedRectImageWithClass:className layer:gradientLayer];
        [control setBackgroundImage:selectedImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    }
    
    NSDictionary *titleTextAttributes = [NUIUtilities titleTextAttributesForClass:className];
    
    if ([[titleTextAttributes allKeys] count] > 0) {
        [control setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
}

@end
