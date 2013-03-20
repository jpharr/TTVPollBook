//
//  NISignatureViewQuartzQuadratic.m
//  SignatureDemo
//
//  Created by Jason Harwig on 11/6/12.
//  Copyright (c) 2012 Near Infinity Corporation.

#import "NISignatureViewQuartzQuadratic.h"
#import <QuartzCore/QuartzCore.h>

static CGPoint midpoint(CGPoint p0, CGPoint p1) {
    return (CGPoint) {
        (p0.x + p1.x) / 2.0,
        (p0.y + p1.y) / 2.0
    };
}

@implementation NISignatureViewQuartzQuadratic

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
    CGPoint midPoint = midpoint([self previousPoint], currentPoint);
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        [[self path] moveToPoint:currentPoint];
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        [[self path] addQuadCurveToPoint:midPoint controlPoint:[self previousPoint]];
    }
    
    [self setPreviousPoint:currentPoint];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [[UIColor blackColor] setStroke];
    [[self path] stroke];
}

@end
