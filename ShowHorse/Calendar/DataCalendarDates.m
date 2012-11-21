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

-(void)InsertUpdateCheclistItem:(CalendarDates *)CalendarDatesObject
         inManagedObjectContext:(NSManagedObjectContext *)context
{
    DB_Calendar_Dates *dbcalendar = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DB_Calendar_Dates"];
    request.predicate = [NSPredicate predicateWithFormat:@"eventdate = %@", CalendarDatesObject.EventDate];
    
    NSError *error = nil;
    NSArray *checklistitems = [context executeFetchRequest:request error:&error];
    
    if (!checklistitems || ([checklistitems count] > 1)) {
        // handle error
    } else if (![checklistitems count]) {
        dbcalendar = [NSEntityDescription insertNewObjectForEntityForName:@"DB_Calendar_Dates"
                                                    inManagedObjectContext:context];
        
        [dbcalendar setValue:CalendarDatesObject.EventDate forKey:@"eventdate"];
        [dbcalendar setValue:CalendarDatesObject.EventDescription forKey:@"eventdescription"];
        [dbcalendar setValue:CalendarDatesObject.EventTitle forKey:@"eventtitle"];
    } else {
        dbcalendar = [checklistitems lastObject];
        [dbcalendar setValue:CalendarDatesObject.EventDate forKey:@"eventdate"];
        [dbcalendar setValue:CalendarDatesObject.EventDescription forKey:@"eventdescription"];
        [dbcalendar setValue:CalendarDatesObject.EventTitle forKey:@"eventtitle"];
    }
    
    
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

    //[CalendarDatesObject.CalendarDatesObject deleteInBackground];
}

-(CalendarDates*)objectInListAtIndex:(unsigned)theIndex{
    AppDelegate *appdel  = [UIApplication sharedApplication].delegate;
    return [appdel.listdataCalendarDates objectAtIndex:theIndex];
}

@end
