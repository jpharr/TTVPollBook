//
//  StartViewController.m
//  TTVPollBook
//
//  Created by Jeff Pharr on 3/2/13.
//  Copyright (c) 2013 Jeff Pharr. All rights reserved.
//

#import "StartViewController.h"
#import "SearchViewController.h"
#import "AppDelegate.h"

@interface StartViewController ()

@end

@implementation StartViewController

- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[self checkinButton] setBackgroundImage:[[UIImage imageNamed:@"button_grey.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];

    [[self adminButton] setBackgroundImage:[[UIImage imageNamed:@"button_grey.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        
    [[self loginButton] setBackgroundImage:[[UIImage imageNamed:@"button_grey.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];

    [[self checkinButton] setHidden:YES];
    authenticated = NO;
    [[self authenticationView] setHidden:NO];
    
    [self performSelector:@selector(hideSplashScreen) withObject:nil afterDelay:5.0];
}

-(void)hideSplashScreen{
    [[self splashScreen] setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)checkinAction:(id)sender{
    [[AppDelegate instance] setScannedID:@""];
    SearchViewController *searchView = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchView animated:YES];    
}

-(IBAction)startSession:(id)sender{
    [[self precinctID] endEditing:YES];
    [[self authenticationCode] endEditing:YES];
    
    [[self authenticationView] setHidden:YES];
    [[self checkinButton] setHidden:NO];
}

@end
