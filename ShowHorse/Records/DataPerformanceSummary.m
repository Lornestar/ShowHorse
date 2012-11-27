//
//  DataPerformanceSummary.m
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-10-01.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import "DataPerformanceSummary.h"
#import "AppDelegate.h"
#import "Performances.h"
#import <Parse/Parse.h>
#import <CoreData/CoreData.h>
#import "DB_Performance.h"

@implementation DataPerformanceSummary

- (id)init {
    
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    if (appdel.userinfo.UserID){
        [appdel initPerformances];
    }
    return self;
}

-(Performances*)AddPerformance:(Performances*)PerformanceObject currentselectedindex:(int)currentselectedindex{
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    
    //PFObject *performobject;
      if (!PerformanceObject.PerformanceObject){
          //new one
          
          //performobject = [PFObject objectWithClassName:@"User_Performances"];
          if (appdel.listdataPerformances.count > 0){
              PerformanceObject.listindex = [[appdel.listdataPerformances valueForKeyPath:@"@max.listindex"] intValue]+1;
          }
          else{
              PerformanceObject.listindex = appdel.listdataPerformances.count;
          }
          [appdel.listdataPerformances addObject:PerformanceObject];
    }
    else{
        //existing object
        //performobject = PerformanceObject.PerformanceObject; //[[PFQuery queryWithClassName:@"User_Performances"] getObjectWithId:PerformanceObject.PerformanceObject.objectId];
        [appdel.listdataPerformances setObject:PerformanceObject atIndexedSubscript:currentselectedindex];
        
        
    }
   
    DB_Performance *dbchecklist = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DB_Performance"];
    request.predicate = [NSPredicate predicateWithFormat:@"listindex = %d", PerformanceObject.listindex];
    
    NSError *error = nil;
    NSArray *checklistitems = [appdel.ShowHorseDatabase.managedObjectContext executeFetchRequest:request error:&error];
    
    if (!checklistitems || ([checklistitems count] > 1)) {
        // handle error
    } else if (![checklistitems count]) {
        dbchecklist = [NSEntityDescription insertNewObjectForEntityForName:@"DB_Performance"
                                                    inManagedObjectContext:appdel.ShowHorseDatabase.managedObjectContext];
        //dbchecklist.thelabel = name;
        //dbchecklist.currentselection = [NSNumber numberWithInt:currentselection];
        
        [dbchecklist setValue:PerformanceObject.Date forKey:@"date"];
        [dbchecklist setValue:PerformanceObject.Name forKey:@"name"];
        [dbchecklist setValue:PerformanceObject.Description forKey:@"perf_description"];
        [dbchecklist setValue:PerformanceObject.Placing forKey:@"placing"];
        [dbchecklist setValue:PerformanceObject.Judge forKey:@"judge"];
        [dbchecklist setValue:PerformanceObject.Competitors forKey:@"competitors"];
        [dbchecklist setValue:PerformanceObject.Score forKey:@"score"];
        [dbchecklist setValue:[NSNumber numberWithInt:PerformanceObject.listindex] forKey:@"listindex"];
    } else {
        dbchecklist = [checklistitems lastObject];
        [dbchecklist setValue:PerformanceObject.Date forKey:@"date"];
        [dbchecklist setValue:PerformanceObject.Name forKey:@"name"];
        [dbchecklist setValue:PerformanceObject.Description forKey:@"perf_description"];
        [dbchecklist setValue:PerformanceObject.Placing forKey:@"placing"];
        [dbchecklist setValue:PerformanceObject.Judge forKey:@"judge"];
        [dbchecklist setValue:PerformanceObject.Competitors forKey:@"competitors"];
        [dbchecklist setValue:PerformanceObject.Score forKey:@"score"];
        [dbchecklist setValue:[NSNumber numberWithInt:PerformanceObject.listindex] forKey:@"listindex"];
    }
    
    [appdel SaveDatabase];
    PerformanceObject.PerformanceObject = dbchecklist;
    //Add to db
    /*
    NSDictionary *tempdict = [NSDictionary dictionaryWithObjectsAndKeys:
                              PerformanceObject.Date, @"Date",
                              PerformanceObject.Name, @"Name",
                              PerformanceObject.Description, @"Description",
                              PerformanceObject.Placing, @"Placing",
                              PerformanceObject.Judge, @"Judge",
                              PerformanceObject.Competitors, @"Competitors",
                              PerformanceObject.Score, @"Score", nil];
    
    [performobject setObject:tempdict forKey:@"Performance"];
    [performobject setObject:appdel.userinfo.UserID forKey:@"User_ID"];
    [performobject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if (!error){
            PerformanceObject.PerformanceObject = performobject;
        }
    }];
    */
    
    return PerformanceObject;
}

-(void)DeleteRegPapers:(Performances*)PerformanceObject currentselectedindex:(int)currentselectedindex{
    
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DB_Performance"];
    request.predicate = [NSPredicate predicateWithFormat:@"listindex = %d", PerformanceObject.listindex];
    
    NSError *error = nil;
    NSArray *checklistitems = [appdel.ShowHorseDatabase.managedObjectContext executeFetchRequest:request error:&error];
    DB_Performance *dbchecklist = [checklistitems lastObject];
    [appdel.ShowHorseDatabase.managedObjectContext  deleteObject:dbchecklist];
    [appdel SaveDatabase];
    
    [appdel.listdataPerformances removeObjectAtIndex:currentselectedindex];
}

- (Performances *)objectInListAtIndex:(unsigned)theIndex;
{
    //return specific performance object
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    return [appdel.listdataPerformances objectAtIndex:theIndex];
}

@end
