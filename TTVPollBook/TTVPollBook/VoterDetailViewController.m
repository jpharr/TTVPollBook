//
//  VoterDetailViewController.m
//  TTVPollBook
//
//  Created by Jeff Pharr on 3/2/13.
//  Copyright (c) 2013 Jeff Pharr. All rights reserved.
//

#import "VoterDetailViewController.h"
#import "PollDetailViewController.h"
#import "NISignatureView.h"

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
    [[self signatureBtn] setBackgroundImage:[[UIImage imageNamed:@"button_grey.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateNormal];
    
    [[self showPollingLctnBtn] setBackgroundImage:[[UIImage imageNamed:@"button_grey.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateNormal];
    
    [[self notMeBtn] setBackgroundImage:[[UIImage imageNamed:@"button_grey.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateNormal];
    
    [[self continueCheckinBtn] setBackgroundImage:[[UIImage imageNamed:@"button_grey.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateNormal];
    
    [[self signatureClearBtn] setBackgroundImage:[[UIImage imageNamed:@"button_grey.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateNormal];
    
//    NISignatureView *sigView = [[NISignatureView alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, 300.0)];
//    //UIView *sigView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, 300.0)];
//    [sigView setBackgroundColor:[UIColor whiteColor]];
//    [self.view addSubview:sigView];
//    [self.view bringSubviewToFront:sigView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    //set up name block
    [_row1Text setText:[NSString stringWithFormat:@"%@ %@",[[self voter] givenName],[[self voter] familyName]]];
    [_row2Text setText:[[self voter] streetAddress]];
    [_row3Text setText:[NSString stringWithFormat:@"%@, %@ %@",[[self voter] city],[[self voter] state],[[self voter] zipCode]]];
    
    //set up voted status
    [_votedStatusMessage setText:[[[self voter]hasVoted] isEqualToString:@"Yes"]?@"Has voted":@"Has not yet voted"];
    
    [[self signatureBlock] setImage:[UIImage imageNamed:@"signature.png"]];
    [[self signatureBlock] setHidden:YES];
    [[self notMeBtn] setHidden:NO];
    [[self continueCheckinBtn] setHidden:NO];
    [[self signatureBtn] setHidden:YES];
    [[self signatureClearBtn] setHidden:YES];
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

-(IBAction)notMe:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)continueCheckin:(id)sender{
    
    if ([[[self voter] precinctName] isEqualToString:@"327"]){
        [[self notMeBtn] setHidden:YES];
        [[self continueCheckinBtn] setHidden:YES];
        [[self signatureBlock] setHidden:NO];
        [[self signatureBtn] setTitle:@"Save Signature" forState:UIControlStateNormal];
        [[self signatureBtn] setHidden:NO];
        [[self signatureClearBtn] setHidden:NO];
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

-(IBAction)eraseSignature:(id)sender{
    [(NISignatureViewQuartz *)[self signatureCaptureView] erase];
}

@end
