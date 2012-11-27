//
//  DataRegPapers.m
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-10-08.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import "DataRegPapers.h"
#import "RegistrationPapers.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <CoreData/CoreData.h>
#import "DB_Registration_Papers.h"

@implementation DataRegPapers

-(RegistrationPapers*)AddRegPapers:(RegistrationPapers*)RegPapersObject currentselectedindex:(int)currentselectedindex{
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    
    NSData *imgdata = UIImageJPEGRepresentation(RegPapersObject.Papers, .05f);
        
    if (!RegPapersObject.PapersObject){
        //new one
        //regpapersobject = [PFObject objectWithClassName:@"User_Registration_Papers"];
        if (appdel.listdataPapers.count > 0){
            RegPapersObject.listindex = [[appdel.listdataPapers valueForKeyPath:@"@max.listindex"] intValue]+1;
        }
        else{
            RegPapersObject.listindex = appdel.listdataPapers.count;
        }
        [appdel.listdataPapers addObject:RegPapersObject];
    }
    else{
        //existing object
        //regpapersobject = RegPapersObject.PapersObject;
        [appdel.listdataPapers setObject:RegPapersObject atIndexedSubscript:currentselectedindex];
    }
    
    DB_Registration_Papers *dbchecklist = nil;

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DB_Registration_Papers"];
    request.predicate = [NSPredicate predicateWithFormat:@"listindex = %d", RegPapersObject.listindex];
    
    NSError *error = nil;
    NSArray *checklistitems = [appdel.ShowHorseDatabase.managedObjectContext executeFetchRequest:request error:&error];
    
    if (!checklistitems || ([checklistitems count] > 1)) {
        // handle error
    } else if (![checklistitems count]) {
        dbchecklist = [NSEntityDescription insertNewObjectForEntityForName:@"DB_Registration_Papers"
                                                    inManagedObjectContext:appdel.ShowHorseDatabase.managedObjectContext];
        //dbchecklist.thelabel = name;
        //dbchecklist.currentselection = [NSNumber numberWithInt:currentselection];
        
        [dbchecklist setValue:imgdata forKey:@"papersimage"];
        [dbchecklist setValue:[NSNumber numberWithInt:RegPapersObject.listindex] forKey:@"listindex"];
    } else {
        dbchecklist = [checklistitems lastObject];
        [dbchecklist setValue:imgdata forKey:@"papersimage"];
        [dbchecklist setValue:[NSNumber numberWithInt:RegPapersObject.listindex] forKey:@"listindex"];
    }
    
    [appdel SaveDatabase];
    RegPapersObject.PapersObject = dbchecklist;
    
    /*
    //Add to db
    
    NSData *imgdata = UIImageJPEGRepresentation(RegPapersObject.Papers, .05f);
    [regpapersobject setObject:imgdata forKey:@"PapersImage"];
    [regpapersobject setObject:appdel.userinfo.UserID forKey:@"User_ID"];
    [regpapersobject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if (!error){
            RegPapersObject.PapersObject = regpapersobject;
        }
    }];*/
    return RegPapersObject;
}

-(void)DeleteRegPapers:(RegistrationPapers*)RegPapersObject currentselectedindex:(int)currentselectedindex{
    /*
        AppDelegate *appdel = [UIApplication sharedApplication].delegate;
        [appdel.listdataPapers removeObjectAtIndex:RegPapersObject.listindex];

        [RegPapersObject.PapersObject deleteInBackground];
    */
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DB_Registration_Papers"];
    request.predicate = [NSPredicate predicateWithFormat:@"listindex = %d", RegPapersObject.listindex];
    
    NSError *error = nil;
    NSArray *checklistitems = [appdel.ShowHorseDatabase.managedObjectContext executeFetchRequest:request error:&error];
    DB_Registration_Papers *dbchecklist = [checklistitems lastObject];
    [appdel.ShowHorseDatabase.managedObjectContext deleteObject:dbchecklist];
    [appdel SaveDatabase];
    
    currentselectedindex = [appdel.listdataPapers indexOfObject:RegPapersObject];
    [appdel.listdataPapers removeObjectAtIndex:currentselectedindex];
}

- (RegistrationPapers *)objectInListAtIndex:(unsigned)theIndex;
{
    //return specific performance object
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    return [appdel.listdataPapers objectAtIndex:theIndex];
}

@end
