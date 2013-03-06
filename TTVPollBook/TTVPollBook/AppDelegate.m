//
//  AppDelegate.m
//  TTVPollBook
//
//  Created by Jeff Pharr on 3/2/13.
//  Copyright (c) 2013 Jeff Pharr. All rights reserved.
//

#import "AppDelegate.h"
#import "StartViewController.h"
#import <CoreData/CoreData.h>
#import "Voter.h"
#import "PollingPlace.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    StartViewController *masterViewController = [[StartViewController alloc] initWithNibName:@"StartViewController" bundle:nil];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    //[self seedSampleDBRecord];   //just used once to create db template
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+(AppDelegate *)instance {
	return (AppDelegate*) [[UIApplication sharedApplication] delegate];
}

#pragma mark -
#pragma mark CoreData stuff

- (NSManagedObjectContext *) managedObjectContext {
	
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return _managedObjectContext;
}


- (NSManagedObjectModel *)managedObjectModel {
	
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
	
	NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
	
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	NSURL *storeUrl = [NSURL fileURLWithPath: [documentsDirectory stringByAppendingPathComponent: @"coredataV1.sqlite"]];
	
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
	
	if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }
	
    return _persistentStoreCoordinator;
}


-(void)seedSampleDBRecord{
    
	NSError *error;
    PollingPlace *place;
    Voter *voter;
    
    place = (PollingPlace *)[NSEntityDescription insertNewObjectForEntityForName:@"PollingPlace" inManagedObjectContext:[self managedObjectContext]];
    
    [place setPollingPlaceAddress:@"700 Bennett St."];
    [place setPollingPlaceCity:@"Herndon"];
    [place setPollingPlaceLatitude:@""];
    [place setPollingPlaceLongtitude:@""];
    [place setPollingPlaceName:@"Herndon High School"];
    [place setPollingPlaceState:@"VA"];
    [place setPollingPlaceZipCode:@"20170"];
    [place setPrecinctName:@"327-Sugerland"];
    [place setPrecinctNumber:@"327"];
     
    voter = (Voter *)[NSEntityDescription insertNewObjectForEntityForName:@"Voter" inManagedObjectContext:[self managedObjectContext]];
    
    [voter setActiveRegistration:@"YES"];
    [voter setCity:@"Herndon"];
    [voter setElectoralDistrict:@"Dranesville"];
    [voter setEmailAddress:@"anne@email.com"];
    [voter setFamilyName:@"O'Flaherty"];
    [voter setGivenName:@"Anne"];
    [voter setHasVoted:@"NO"];
    [voter setLocalityName:@"Sugerland"];
    [voter setMiddleName:@"Weston"];
    [voter setPersonFullName:@"Anne Weston O'Flaherty"];
    [voter setPrecinctName:@"327-Sugarland"];
    [voter setPrecinctNumber:@"327"];
    [voter setPrecinctSplitId:@"327"];
    [voter setPreferredLanguage:@"English"];
    [voter setSignatureBlock:@"signature"];
    [voter setState:@"VA"];
    [voter setStreetAddress:@"1314 Cassia St"];
    [voter setVoterIdentificationID:@"917796105"];
    [voter setZipCode:@"20170"];
    
	// Commit the change.
	if (![[self managedObjectContext] save:&error]) {}
}

@end
