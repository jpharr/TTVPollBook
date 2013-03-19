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
    
    [[self showPollingLctnBtn] setBackgroundImage:[[UIImage imageNamed:@"button_grey.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateNormal];
    
    [[self notMeBtn] setBackgroundImage:[[UIImage imageNamed:@"button_grey.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateNormal];
    
    [[self continueCheckinBtn] setBackgroundImage:[[UIImage imageNamed:@"button_grey.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    //set up name block
    [_row1Text setText:[NSString stringWithFormat:@"%@ %@",[[self voter] givenName],[[self voter] familyName]]];
    [_row2Text setText:[[self voter] streetAddress]];
    [_row3Text setText:[NSString stringWithFormat:@"%@, %@ %@",[[self voter] city],[[self voter] state],[[self voter] zipCode]]];
    
    //set up voted status
    [_votedStatusMessage setText:[[[self voter]hasVoted] isEqualToString:@"Yes"]?@"Has voted":@"Has not yet voted"];
    
    [[self signatureBlock] setImage:[UIImage imageNamed:@"signature_empty.png"]];
    [[self signatureBlock] setHidden:YES];
    [[self signItBtn] setHidden:YES];
    [[self notMeBtn] setHidden:NO];
    [[self continueCheckinBtn] setHidden:NO];
    [[self signatureBtn] setHidden:YES];
    [[self thanksView]setHidden:YES];
    
    signatureSaved = NO;
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

-(void)checkinCompleted{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

-(IBAction)showPollingLocation:(id)sender{
    PollDetailViewController *pollView = [[PollDetailViewController alloc] init];
    [self.navigationController pushViewController:pollView animated:YES];
}

-(IBAction)signAction:(id)sender{
    [[self signatureBlock] setImage:[UIImage imageNamed:@"signature.png"]];
    [[self signItBtn] setHidden:YES];
    [[self signatureBtn] setTitle:@"Save Signature" forState:UIControlStateNormal];
    [[self signatureBtn] setHidden:NO];
}

-(IBAction)notMe:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)continueCheckin:(id)sender{
    
    if ([[[self voter] precinctName] isEqualToString:@"327"]){
        [[self notMeBtn] setHidden:YES];
        [[self continueCheckinBtn] setHidden:YES];
        [[self signItBtn] setHidden:NO];
        [[self signatureBlock] setHidden:NO];
    }else{
        PollDetailViewController *pollView = [[PollDetailViewController alloc] init];
        [self.navigationController pushViewController:pollView animated:YES];
    }
}

-(IBAction)saveSignature:(id)sender{
    if (signatureSaved) {
        [[self thanksView] setHidden:NO];
        [self performSelector:@selector(checkinCompleted) withObject:nil afterDelay:5.0];
    }else{
        signatureSaved = YES;
        [[self signatureBtn] setTitle:@"Complete Checkin" forState:UIControlStateNormal];

    }
}


@end
