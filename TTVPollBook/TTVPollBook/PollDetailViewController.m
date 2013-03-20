//
//  PollDetailViewController.m
//  TTVPollBook
//
//  Created by Jeff Pharr on 3/2/13.
//  Copyright (c) 2013 Jeff Pharr. All rights reserved.
//

#import "PollDetailViewController.h"

@interface PollDetailViewController ()

@end

@implementation PollDetailViewController

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


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //set up button images
    [[self printBtn] setBackgroundImage:[[UIImage imageNamed:@"button_grey.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateNormal];

    [[self finishBtn] setBackgroundImage:[[UIImage imageNamed:@"button_grey.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateNormal];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UILabel *newTitleLabel = [[UILabel alloc] init];
    [newTitleLabel setText:@"November 2012 General Election - 327 Sugarland Precinct"];
    [newTitleLabel setTextColor:[UIColor blackColor]];
    [newTitleLabel setBackgroundColor:[UIColor clearColor]];
    [newTitleLabel setOpaque:NO];
    [newTitleLabel sizeToFit];
    [self.navigationController.navigationBar.topItem setTitleView:newTitleLabel];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)doneAction:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction)printAction:(id)sender{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Printing Directions..." message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
