//
//  ScanIDViewController.m
//  TTVPollBook
//
//  Created by Jeff Pharr on 3/2/13.
//  Copyright (c) 2013 Jeff Pharr. All rights reserved.
//

#import "ScanIDViewController.h"
#import "AppDelegate.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "ZXCapture.h"

@interface ScanIDViewController ()

@property (nonatomic, strong) ZXCapture *capture;
@property (nonatomic, strong) IBOutlet UIImageView *overlayImage;

@end

@implementation ScanIDViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [[AppDelegate instance] setScannedID:@""];
    
    UILabel *newTitleLabel = [[UILabel alloc] init];
    [newTitleLabel setText:@"November 2012 General Election - 327 Sugarland Precinct"];
    [newTitleLabel setTextColor:[UIColor blackColor]];
    [newTitleLabel setBackgroundColor:[UIColor clearColor]];
    [newTitleLabel setOpaque:NO];
    [newTitleLabel sizeToFit];
    [self.navigationController.navigationBar.topItem setTitleView:newTitleLabel];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setCapture:[[ZXCapture alloc] init]];
    [[self capture] setDelegate:self];
    [[self capture] setRotation:0.0f];
    
    // Use the back camera
    self.capture.camera = self.capture.back;
    
    self.capture.layer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.capture.layer];
    CATransform3D transform = CATransform3DMakeRotation(1.57079633, 0, 0, 1.0);
    self.capture.layer.transform = transform;
    self.capture.layer.frame = self.view.bounds;
    [self.view bringSubviewToFront:self.overlayImage];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)doneAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)scanComplete{
    [self.capture.layer removeFromSuperlayer];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ZXCaptureDelegate Methods

- (void)captureResult:(ZXCapture*)capture result:(ZXResult*)result {
    if (result) {
        // Vibrate
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        [[AppDelegate instance] setScannedID:[NSString stringWithFormat:@"%@", result]];

        [self scanComplete];
    }
}

- (void)captureSize:(ZXCapture*)capture width:(NSNumber*)width height:(NSNumber*)height {
}


@end
