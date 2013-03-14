//
//  StartViewController.h
//  TTVPollBook
//
//  Created by Jeff Pharr on 3/2/13.
//  Copyright (c) 2013 Jeff Pharr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartViewController : UIViewController{
    BOOL authenticated;
}

@property (strong) IBOutlet UIButton *checkinButton;
@property (strong) IBOutlet UIButton *adminButton;
@property (strong) IBOutlet UIView *authenticationView;
@property (strong) IBOutlet UITextField *precinctID;
@property (strong) IBOutlet UITextField *authenticationCode;
@property (strong) IBOutlet UIButton *loginButton;

-(IBAction)startSession:(id)sender;

@end
