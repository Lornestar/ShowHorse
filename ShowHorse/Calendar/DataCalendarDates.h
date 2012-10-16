//
//  DataCalendarDates.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-10-11.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalendarDates.h"

@interface DataCalendarDates : NSObject

-(CalendarDates*)AddCalendarDates:(CalendarDates*)CalendarDatesObject;
-(void)DeleteCalendarDates:(CalendarDates*)CalendarDatesObject;
-(CalendarDates*)objectInListAtIndex:(unsigned)theIndex;

@end
