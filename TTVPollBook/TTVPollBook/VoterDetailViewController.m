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
    
    [[self signatureBtn] setBackgroundImage:[[UIImage imageNamed:@"button_grey.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateNormal];
    //    [_printBallotBtn setBackgroundImage:[[UIImage imageNamed:@"button_grey_pressed.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:10] forState:UIControlStateHighlighted];
    
    [[self printBallotBtn] setBackgroundImage:[[UIImage imageNamed:@"button_grey.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateNormal];
//    [_printBallotBtn setBackgroundImage:[[UIImage imageNamed:@"button_grey_pressed.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:10] forState:UIControlStateHighlighted];
    
    [[self showPollingLctnBtn] setBackgroundImage:[[UIImage imageNamed:@"button_grey.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateNormal];
//    [_showPollingLctnBtn setBackgroundImage:[[UIImage imageNamed:@"button_grey_pressed.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:10] forState:UIControlStateHighlighted];
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
