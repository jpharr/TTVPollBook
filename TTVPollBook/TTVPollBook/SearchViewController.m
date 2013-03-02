//
//  SearchViewController.m
//  TTVPollBook
//
//  Created by Jeff Pharr on 3/2/13.
//  Copyright (c) 2013 Jeff Pharr. All rights reserved.
//

#import "SearchViewController.h"
#import "VoterDetailViewController.h"
#import "ScanIDViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

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

-(IBAction)scanIDAction:(id)sender{
    ScanIDViewController *scanView = [[ScanIDViewController alloc] init];
    [self.navigationController pushViewController:scanView animated:YES];
}

-(IBAction)rowSelectButtonAction:(id)sender{
    [self doRowSelectTasks];
}

-(void)doRowSelectTasks{
    VoterDetailViewController *voterView = [[VoterDetailViewController alloc] init];
    [self.navigationController pushViewController:voterView animated:YES];
}

@end
