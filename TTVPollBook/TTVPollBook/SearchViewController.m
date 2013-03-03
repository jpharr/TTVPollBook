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
    [self pullFullVoterList];
    
	// create a filtered list that will contain voters for the search results table.
	self.filteredListContent = [NSMutableArray arrayWithCapacity:[self.listContent count]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pullFullVoterList{
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Voter" inManagedObjectContext:[[AppDelegate instance]managedObjectContext]];
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

-(IBAction)rowSelectButtonAction:(id)sender{
    [self doRowSelectTasks];
}

-(void)doRowSelectTasks{
    VoterDetailViewController *voterView = [[VoterDetailViewController alloc] init];
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
	
	cell.textLabel.text = voter.familyName;

	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
	/*
	 If the requesting table view is the search display controller's table view, configure the next view controller using the filtered content, otherwise use the main list.
	 */
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
    }
	else
	{
    }
    
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
