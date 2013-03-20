//
//  NISignatureViewQuartz.m
//  SignatureDemo
//
//  Created by Jason Harwig on 11/6/12.
//  Copyright (c) 2012 Near Infinity Corporation.

#import "NISignatureViewQuartz.h"
#import <QuartzCore/QuartzCore.h>

@implementation NISignatureViewQuartz

- (void)commonInit {
    [self setPath:[UIBezierPath bezierPath]];
    
    // Capture touches
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    pan.maximumNumberOfTouches = pan.minimumNumberOfTouches = 1;
    [self addGestureRecognizer:pan];
    
    // Erase with long press
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(erase)]];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) [self commonInit];
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) [self commonInit];
    return self;
}

- (void)erase {
    [self setPath:[UIBezierPath bezierPath]];
    [self setNeedsDisplay];
}


- (void)pan:(UIPanGestureRecognizer *)pan {
    CGPoint currentPoint = [pan locationInView:self];
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        [[self path] moveToPoint:currentPoint];
    } else if (pan.state == UIGestureRecognizerStateChanged)
        [[self path] addLineToPoint:currentPoint];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [[UIColor blackColor] setStroke];
    [[self path] stroke];
}


@end
