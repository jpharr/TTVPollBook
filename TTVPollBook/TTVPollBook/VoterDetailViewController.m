//
//  VoterDetailViewController.m
//  TTVPollBook
//
//  Created by Jeff Pharr on 3/2/13.
//  Copyright (c) 2013 Jeff Pharr. All rights reserved.
//

#import "VoterDetailViewController.h"
#import "PollDetailViewController.h"

@interface VoterDetailViewController ()

@end

@implementation VoterDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //set up button images
    [[self signatureBtn] setBackgroundImage:[[UIImage imageNamed:@"button_grey.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateNormal];
    
    [[self printBallotBtn] setBackgroundImage:[[UIImage imageNamed:@"button_grey.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateNormal];
    
    [[self showPollingLctnBtn] setBackgroundImage:[[UIImage imageNamed:@"button_grey.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    //set up name block
    [_row1Text setText:[NSString stringWithFormat:@"%@ %@",[[self voter] givenName],[[self voter] familyName]]];
    [_row2Text setText:[[self voter] streetAddress]];
    [_row3Text setText:[NSString stringWithFormat:@"%@, %@ %@",[[self voter] city],[[self voter] state],[[self voter] zipCode]]];
    
    //set up voted status
    [_votedStatusMessage setText:[[[self voter]hasVoted] isEqualToString:@"Yes"]?@"Has voted":@"Has not yet voted"];
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

-(IBAction)showPollingLocation:(id)sender{
    PollDetailViewController *pollView = [[PollDetailViewController alloc] init];
    [self.navigationController pushViewController:pollView animated:YES];
}

-(IBAction)printBallot:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
