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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)doneAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)txtAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)printAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
