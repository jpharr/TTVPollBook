//
//  SearchViewController.h
//  TTVPollBook
//
//  Created by Jeff Pharr on 3/2/13.
//  Copyright (c) 2013 Jeff Pharr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UISearchDisplayDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSArray *listContent;
@property (nonatomic, strong) NSMutableArray *filteredListContent;
@property (nonatomic, strong) IBOutlet UITableView *listTable;
@property (strong) IBOutlet UIButton *scanButton;


@end
