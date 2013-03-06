//
//  VoterDetailViewController.h
//  TTVPollBook
//
//  Created by Jeff Pharr on 3/2/13.
//  Copyright (c) 2013 Jeff Pharr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Voter.h"

@interface VoterDetailViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *signatureBtn;
@property (nonatomic, strong) IBOutlet UIButton *printBallotBtn;
@property (nonatomic, strong) IBOutlet UIButton *showPollingLctnBtn;

@property (nonatomic, strong) IBOutlet UILabel *row1Text;
@property (nonatomic, strong) IBOutlet UILabel *row2Text;
@property (nonatomic, strong) IBOutlet UILabel *row3Text;
@property (nonatomic, strong) IBOutlet UILabel *votedStatusMessage;

@property (nonatomic,strong) Voter *voter;

@end
