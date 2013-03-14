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
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Voter.h"

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
    
    [[self scanButton] setBackgroundImage:[[UIImage imageNamed:@"button_grey.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    
    [self pullFullVoterList];
    
	// create a filtered list that will contain voters for the search results table.
	self.filteredListContent = [NSMutableArray arrayWithCapacity:[self.listContent count]];
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

-(void)pullFullVoterList{
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Voter" inManagedObjectContext:[[AppDelegate instance]managedObjectContext]];
    
    NSSortDescriptor *familyNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"familyName" ascending:YES];
    NSSortDescriptor *givenNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"givenName" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:familyNameDescriptor,givenNameDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];

    [request setEntity:entity];

	// Execute the fetch -- create a mutable copy of the result.
	NSError *error = nil;
	NSMutableArray *mutableFetchResults = [[[[AppDelegate instance]managedObjectContext] executeFetchRequest:request error:&error] mutableCopy];
	if (mutableFetchResults == nil) {
		// Handle the error.
	}
	
	// Set self's events array to the mutable array
	[self setListContent:mutableFetchResults];
    [_listTable reloadData];
}

-(IBAction)scanIDAction:(id)sender{
    ScanIDViewController *scanView = [[ScanIDViewController alloc] init];
    [self.navigationController pushViewController:scanView animated:YES];
}

-(void)doRowSelectTasksForVoter:(Voter *)selectedVoter{
    VoterDetailViewController *voterView = [[VoterDetailViewController alloc] init];
    [voterView setVoter:selectedVoter];
    [self.navigationController pushViewController:voterView animated:YES];
}

#pragma mark -
#pragma mark UITableView data source and delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	/*
	 If the requesting table view is the search display controller's table view, return the count of
     the filtered list, otherwise return the count of the main list.
	 */
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [self.filteredListContent count];
    }
	else
	{
        return [self.listContent count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *kCellID = @"cellID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(30.0, 0.0, 270.0, 44.0)];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setOpaque:NO];
        [nameLabel setTag:1];
        UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(300.0, 0.0, 724.0, 44.0)];
        [addressLabel setBackgroundColor:[UIColor clearColor]];
        [addressLabel setTag:2];
        [addressLabel setOpaque:NO];
        
        UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grey_row"]];
        [[cell contentView] addSubview:backgroundImage];
        [[cell contentView] addSubview:nameLabel];
        [[cell contentView] addSubview:addressLabel];
        
	}
	
	/*
	 If the requesting table view is the search display controller's table view, configure the cell using the filtered content, otherwise use the main list.
	 */

    Voter *voter = nil;
    
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        voter = [self.filteredListContent objectAtIndex:indexPath.row];
    }
	else
	{
        voter = [self.listContent objectAtIndex:indexPath.row];
    }
	
	UILabel *label1 = (UILabel *)[cell.contentView viewWithTag:1];
    label1.text = [NSString stringWithFormat:@"%@, %@", voter.familyName,voter.givenName];
    
	UILabel *label2 = (UILabel *)[cell.contentView viewWithTag:2];
    label2.text = [NSString stringWithFormat:@"%@, %@, %@ %@", voter.streetAddress, voter.city, voter.state,voter.zipCode];
    
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
	/*
	 If the requesting table view is the search display controller's table view, configure the next view controller using the filtered content, otherwise use the main list.
	 */
    
    Voter *voter = nil;

	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        voter = [self.filteredListContent objectAtIndex:indexPath.row];
    }
	else
	{
        voter = [self.listContent objectAtIndex:indexPath.row];
    }
    [self doRowSelectTasksForVoter:voter];
}


#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	/*
	 Update the filtered array based on the search text and scope.
	 */
	
	[self.filteredListContent removeAllObjects]; // First clear the filtered array.
	
	/*
	 Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
	 */
	for (Voter *thisVoter in _listContent)
	{
        NSComparisonResult result = [thisVoter.familyName compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        if (result == NSOrderedSame)
        {
            [self.filteredListContent addObject:thisVoter];
            NSLog(@"adding filtered item");
        }
	}
}


#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


//- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
//{
//    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
//     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
//    
//    // Return YES to cause the search result table view to be reloaded.
//    return YES;
//}


@end
