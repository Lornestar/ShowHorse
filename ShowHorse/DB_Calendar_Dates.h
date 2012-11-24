//
//  DB_Calendar_Dates.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-11-23.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DB_Calendar_Dates : NSManagedObject

@property (nonatomic, retain) NSDate * eventdate;
@property (nonatomic, retain) NSString * eventdescription;
@property (nonatomic, retain) NSString * eventtitle;
@property (nonatomic, retain) NSNumber * listindex;
@property (nonatomic, retain) NSString * eventid;

@end
