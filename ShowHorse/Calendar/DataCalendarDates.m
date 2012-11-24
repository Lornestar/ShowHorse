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
#import "DB_Calendar_Dates.h"
#import <CoreData/CoreData.h>
#import <EventKit/EventKit.h>

@implementation DataCalendarDates



-(CalendarDates*)AddCalendarDates:(CalendarDates*)CalendarDatesObject{
    //Add new Calendar Date
    
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    
    //PFObject *calendardatesobject;
    if (!CalendarDatesObject.CalendarDatesObject){
        //new one
        //calendardatesobject = [PFObject objectWithClassName:@"User_Calendar_Dates"];
        if (appdel.listdataCalendarDates.count> 0 ){
            CalendarDatesObject.listindex = [[appdel.listdataCalendarDates valueForKeyPath:@"@max.listindex"] intValue]+1;
        }
        else{
            CalendarDatesObject.listindex = appdel.listdataCalendarDates.count;
        }
        [appdel.listdataCalendarDates addObject:CalendarDatesObject];
    }
    else{
        //existing object
        //calendardatesobject = CalendarDatesObject.CalendarDatesObject;
        int indexlocation = [appdel.listdataCalendarDates indexOfObject:CalendarDatesObject];
        [appdel.listdataCalendarDates setObject:CalendarDatesObject atIndexedSubscript:indexlocation];
    }
        
    
    //add to local calendar
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    //NSCalendar *calendar = [NSCalendar currentCalendar];
    EKEvent *event;
    
    
    
    
    if (CalendarDatesObject.EventID){
        //eventid exists so update existing event in calendar
        event = [eventStore eventWithIdentifier:CalendarDatesObject.EventID];
    }
    else{
        //create new event from calendar
        event = [EKEvent eventWithEventStore:eventStore];
    }
    
    event.startDate = CalendarDatesObject.EventDate;
    event.title = CalendarDatesObject.EventTitle;
    event.endDate = [CalendarDatesObject.EventDate addTimeInterval:3600];
    event.notes = CalendarDatesObject.EventDescription;
    
    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
    event.alarms = [NSArray arrayWithObject:[EKAlarm alarmWithAbsoluteDate:event.startDate]];
    NSError *Eventerror = nil;
    
    BOOL result = [eventStore saveEvent:event span:EKSpanThisEvent commit:YES error:&Eventerror];
    if (result){
        CalendarDatesObject.EventID = event.eventIdentifier;
        NSLog(@"Saved Event to event store. %@", event.eventIdentifier);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Event saved to your iPhone Calendar" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        NSLog(@"Error saving event: %@", Eventerror);
    }
    
    //Add to database
    DB_Calendar_Dates *dbchecklist = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DB_Calendar_Dates"];
    request.predicate = [NSPredicate predicateWithFormat:@"listindex = %d", CalendarDatesObject.listindex];
    
    NSError *error = nil;
    NSArray *checklistitems = [appdel.ShowHorseDatabase.managedObjectContext executeFetchRequest:request error:&error];
    
    if (!checklistitems || ([checklistitems count] > 1)) {
        // handle error
    } else if (![checklistitems count]) {
        dbchecklist = [NSEntityDescription insertNewObjectForEntityForName:@"DB_Calendar_Dates"
                                                    inManagedObjectContext:appdel.ShowHorseDatabase.managedObjectContext];
        [dbchecklist setValue:CalendarDatesObject.EventDate forKey:@"eventdate"];
        [dbchecklist setValue:CalendarDatesObject.EventTitle forKey:@"eventtitle"];
        [dbchecklist setValue:CalendarDatesObject.EventDescription forKey:@"eventdescription"];
        [dbchecklist setValue:CalendarDatesObject.EventID forKey:@"eventid"];
        [dbchecklist setValue:[NSNumber numberWithInt:CalendarDatesObject.listindex] forKey:@"listindex"];
    } else {
        dbchecklist = [checklistitems lastObject];
        [dbchecklist setValue:CalendarDatesObject.EventDate forKey:@"eventdate"];
        [dbchecklist setValue:CalendarDatesObject.EventTitle forKey:@"eventtitle"];
        [dbchecklist setValue:CalendarDatesObject.EventDescription forKey:@"eventdescription"];
        [dbchecklist setValue:[NSNumber numberWithInt:CalendarDatesObject.listindex] forKey:@"listindex"];
    }
    
    [appdel SaveDatabase];
    CalendarDatesObject.CalendarDatesObject = dbchecklist;
    
    
    
    
    
    /*
    //Add to d
    [calendardatesobject setObject:CalendarDatesObject.EventTitle forKey:@"EventTitle"];
    [calendardatesobject setObject:CalendarDatesObject.EventDescription forKey:@"EventDescription"];
    [calendardatesobject setObject:CalendarDatesObject.EventDate forKey:@"EventDate"];
    [calendardatesobject setObject:appdel.userinfo.UserID forKey:@"User_ID"];
    [calendardatesobject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if (!error){
            CalendarDatesObject.CalendarDatesObject = calendardatesobject;
        }
    }];*/
    
    
    return CalendarDatesObject;
}



-(void)DeleteCalendarDates:(CalendarDates*)CalendarDatesObject{
    //Delete Calendar Date
    
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    int indexlocation = [appdel.listdataCalendarDates indexOfObject:CalendarDatesObject];
    [appdel.listdataCalendarDates removeObjectAtIndex:indexlocation];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DB_Calendar_Dates"];
    request.predicate = [NSPredicate predicateWithFormat:@"listindex = %d", CalendarDatesObject.listindex];
    
    NSError *error = nil;
    NSArray *checklistitems = [appdel.ShowHorseDatabase.managedObjectContext executeFetchRequest:request error:&error];
    DB_Calendar_Dates *dbchecklist = [checklistitems lastObject];
    [appdel.ShowHorseDatabase.managedObjectContext  deleteObject:dbchecklist];
    [appdel SaveDatabase];

    if (CalendarDatesObject.EventID){
        //eventid exists so update existing event in calendar
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        EKEvent *event = [eventStore eventWithIdentifier:CalendarDatesObject.EventID];
        [eventStore removeEvent:event span:EKSpanThisEvent commit:YES error:nil];
    }
    
    //[CalendarDatesObject.CalendarDatesObject deleteInBackground];
}

-(CalendarDates*)objectInListAtIndex:(unsigned)theIndex{
    AppDelegate *appdel  = [UIApplication sharedApplication].delegate;
    return [appdel.listdataCalendarDates objectAtIndex:theIndex];
}

@end
