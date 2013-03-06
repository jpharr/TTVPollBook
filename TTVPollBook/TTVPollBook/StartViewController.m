//
//  StartViewController.m
//  TTVPollBook
//
//  Created by Jeff Pharr on 3/2/13.
//  Copyright (c) 2013 Jeff Pharr. All rights reserved.
//

#import "StartViewController.h"
#import "SearchViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController

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
    
        [[self checkinButton] setBackgroundImage:[[UIImage imageNamed:@"button_grey.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    
        [[self adminButton] setBackgroundImage:[[UIImage imageNamed:@"button_grey.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)checkinAction:(id)sender{
    SearchViewController *searchView = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchView animated:YES];    
}

@end
