//
//  CalendarDates.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-10-10.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "DB_Calendar_Dates.h"

@interface CalendarDates : NSObject
@property (nonatomic, strong) NSString *EventTitle;
@property (nonatomic, strong) NSDate *EventDate;
@property (nonatomic, strong) NSString *EventDescription;
@property (nonatomic, strong) DB_Calendar_Dates *CalendarDatesObject;
@property (nonatomic) int listindex;
@end
