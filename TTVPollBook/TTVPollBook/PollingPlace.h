//
//  PollingPlace.h
//  TTVPollBook
//
//  Created by Jeff Pharr on 3/3/13.
//  Copyright (c) 2013 Jeff Pharr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PollingPlace : NSManagedObject

@property (nonatomic, retain) NSString * pollingPlaceAddress;
@property (nonatomic, retain) NSString * pollingPlaceCity;
@property (nonatomic, retain) NSString * pollingPlaceLatitude;
@property (nonatomic, retain) NSString * pollingPlaceLongtitude;
@property (nonatomic, retain) NSString * pollingPlaceName;
@property (nonatomic, retain) NSString * pollingPlaceState;
@property (nonatomic, retain) NSString * pollingPlaceZipCode;
@property (nonatomic, retain) NSString * precinctName;
@property (nonatomic, retain) NSString * precinctNumber;

@end
