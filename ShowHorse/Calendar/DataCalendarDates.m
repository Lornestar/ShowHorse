//
//  DataCalendarDates.m
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-10-11.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import "DataCalendarDates.h"
#import "CalendarDates.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>

@implementation DataCalendarDates

-(CalendarDates*)AddCalendarDates:(CalendarDates*)CalendarDatesObject{
    //Add new Calendar Date
    
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    
    PFObject *calendardatesobject;
    if (CalendarDatesObject.CalendarDatesObject.objectId.length > 0){
        //existing object
        calendardatesobject = CalendarDatesObject.CalendarDatesObject;
        [appdel.listdataCalendarDates setObject:CalendarDatesObject atIndexedSubscript:CalendarDatesObject.listindex];
    }
    else{
        calendardatesobject = [PFObject objectWithClassName:@"User_Calendar_Dates"];
        CalendarDatesObject.listindex = appdel.listdataCalendarDates.count;
        [appdel.listdataCalendarDates addObject:CalendarDatesObject];
    }
    
    
    //Add to d
    [calendardatesobject setObject:CalendarDatesObject.EventTitle forKey:@"EventTitle"];
    [calendardatesobject setObject:CalendarDatesObject.EventDescription forKey:@"EventDescription"];
    [calendardatesobject setObject:CalendarDatesObject.EventDate forKey:@"EventDate"];
    [calendardatesobject setObject:appdel.userinfo.UserID forKey:@"User_ID"];
    [calendardatesobject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if (!error){
            CalendarDatesObject.CalendarDatesObject = calendardatesobject;
        }
    }];
    
    return CalendarDatesObject;
}

-(void)DeleteCalendarDates:(CalendarDates*)CalendarDatesObject{
    //Delete Calendar Date
    
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    [appdel.listdataCalendarDates removeObjectAtIndex:CalendarDatesObject.listindex];
    
    [CalendarDatesObject.CalendarDatesObject deleteInBackground];
}

-(CalendarDates*)objectInListAtIndex:(unsigned)theIndex{
    AppDelegate *appdel  = [UIApplication sharedApplication].delegate;
    return [appdel.listdataCalendarDates objectAtIndex:theIndex];
}

@end
