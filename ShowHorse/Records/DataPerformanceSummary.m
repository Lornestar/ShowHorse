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

@implementation DataPerformanceSummary

- (id)init {
    
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    if (appdel.userinfo.UserID){
        [appdel initPerformances];
    }
    return self;
}

-(void)AddPerformance:(Performances*)PerformanceObject{
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    
    PFObject *performobject;
      if (PerformanceObject.PerformanceObject.objectId.length > 0){
        //existing object
          performobject = PerformanceObject.PerformanceObject; //[[PFQuery queryWithClassName:@"User_Performances"] getObjectWithId:PerformanceObject.PerformanceObject.objectId];
          [appdel.listdataPerformances setObject:PerformanceObject atIndexedSubscript:PerformanceObject.listindex];
    }
    else{
        performobject = [PFObject objectWithClassName:@"User_Performances"];
        [appdel.listdataPerformances addObject:PerformanceObject];
    }
   
    
    //Add to db
    
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
    
    
    
}

- (Performances *)objectInListAtIndex:(unsigned)theIndex;
{
    //return specific performance object
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    return [appdel.listdataPerformances objectAtIndex:theIndex];
}

@end
