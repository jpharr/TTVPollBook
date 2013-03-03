//
//  Voter.h
//  TTVPollBook
//
//  Created by Jeff Pharr on 3/3/13.
//  Copyright (c) 2013 Jeff Pharr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Voter : NSManagedObject

@property (nonatomic, retain) NSString * activeRegistration;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * electoralDistrict;
@property (nonatomic, retain) NSString * emailAddress;
@property (nonatomic, retain) NSString * familyName;
@property (nonatomic, retain) NSString * givenName;
@property (nonatomic, retain) NSString * hasVoted;
@property (nonatomic, retain) NSString * localityName;
@property (nonatomic, retain) NSString * middleName;
@property (nonatomic, retain) NSString * personFullName;
@property (nonatomic, retain) NSString * precinctName;
@property (nonatomic, retain) NSString * precinctNumber;
@property (nonatomic, retain) NSString * precinctSplitId;
@property (nonatomic, retain) NSString * preferredLanguage;
@property (nonatomic, retain) NSString * signatureBlock;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * streetAddress;
@property (nonatomic, retain) NSString * voterIdentificationID;
@property (nonatomic, retain) NSString * zipCode;

@end
