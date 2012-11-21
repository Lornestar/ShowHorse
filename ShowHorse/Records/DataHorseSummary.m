//
//  DataHorseSummary.m
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-09-28.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import "DataHorseSummary.h"
#import "Records.h"
#import <Parse/Parse.h>
#import "User.h"
#import "AppDelegate.h"
#import "DB_Records.h"
#import <CoreData/CoreData.h>


@implementation DataHorseSummary
@synthesize list,userinfo;

-(void)getuserinfo{
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    userinfo = appdel.userinfo;
}

- (id)init {
    [self getuserinfo];
    if (self = [super init]) {
        [self createHorseData];
    }
    return self;
}

- (id)initRider {
    [self getuserinfo];
    if (self = [super init]) {
        [self createRiderData];
    }
    return self;
}

// Custom set accessor to ensure the new list is mutable
- (void)setList:(NSMutableArray *)newList {
    if (list != newList) {
        list = [newList mutableCopy];
    }
}

// Accessor methods for list
- (unsigned)countOfList {
    return [list count];
}

- (Records *)objectInListAtIndex:(unsigned)theIndex {
    return [list objectAtIndex:theIndex];
}

- (void)updateobjectInListAtIndex:(unsigned)theIndex updatevalue:(NSString*)updatevalue {
    Records *record = [list objectAtIndex:theIndex];
    record.Answer = updatevalue;
    
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    
    PFObject *recordobject;
    if (record.RecordObjectID.length > 0){
        //existing object
        recordobject = [[PFQuery queryWithClassName:@"User_Records"] getObjectWithId:record.RecordObjectID];
    }
    else{
        recordobject = [PFObject objectWithClassName:@"User_Records"];
    }
    
    [self InsertUpdateHorseSummary:record inManagedObjectContext:appdel.ShowHorseDatabase.managedObjectContext];
    [appdel SaveDatabase];
    /*
    [recordobject setObject:updatevalue forKey:@"Answer"];
    [recordobject setObject:appdel.userinfo.UserID forKey:@"UserID"];
    [recordobject setObject:[NSNumber numberWithInt:record.RecordID] forKey:@"RecordID"];
    
    [recordobject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if (!error){
            record.RecordObjectID = recordobject.objectId;
        }
    }];*/
    
}

-(void)InsertUpdateHorseSummary:(Records*)record
         inManagedObjectContext:(NSManagedObjectContext *)context
{
    DB_Records *dbchecklist = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DB_Records"];
    request.predicate = [NSPredicate predicateWithFormat:@"section == %d AND recordid == %d", record.Section, record.RecordID];
    
    NSError *error = nil;
    NSArray *checklistitems = [context executeFetchRequest:request error:&error];
    
    if (!checklistitems || ([checklistitems count] > 1)) {
        // handle error
    } else if (![checklistitems count]) {
        dbchecklist = [NSEntityDescription insertNewObjectForEntityForName:@"DB_Records"
                                                    inManagedObjectContext:context];
        //dbchecklist.thelabel = name;
        //dbchecklist.currentselection = [NSNumber numberWithInt:currentselection];
        
        [dbchecklist setValue:[NSNumber numberWithInt:record.Section] forKey:@"section"];
        [dbchecklist setValue:[NSNumber numberWithInt:record.RecordID] forKey:@"recordid"];
        [dbchecklist setValue:record.Answer forKey:@"answer"];
    } else {
        [dbchecklist setValue:[NSNumber numberWithInt:record.Section] forKey:@"section"];
        [dbchecklist setValue:[NSNumber numberWithInt:record.RecordID] forKey:@"recordid"];
        [dbchecklist setValue:record.Answer forKey:@"answer"];
    }
    
    
}

- (NSMutableArray *)entirelist{
    return list;
}

- (void)createHorseData {

    NSMutableArray *playList = [[NSMutableArray alloc] init];
    Records *record;

    record = [[Records alloc] init];
    record.Question = @"Horse Name";
    record.Section = 0;
    record.RecordID = 1;
    [playList addObject:record];
    
    record = [[Records alloc] init];
    record.Question = @"DOB/Age";
    record.Section = 0;
    record.RecordID = 2;
    [playList addObject:record];
    
    record = [[Records alloc] init];
    record.Question = @"Micro Chip #";
    record.Section = 0;
    record.RecordID = 3;
    [playList addObject:record];
    
    record = [[Records alloc] init];
    record.Question = @"Height";
    record.Section = 0;
    record.RecordID = 4;
    [playList addObject:record];
    
    record = [[Records alloc] init];
    record.Question = @"Rug Size";
    record.Section = 0;
    record.RecordID = 5;
    [playList addObject:record];
    
    record = [[Records alloc] init];
    record.Question = @"Hood Size";
    record.Section = 0;
    record.RecordID = 6;
    [playList addObject:record];
    
    record = [[Records alloc] init];
    record.Question = @"Bridle Size";
    record.Section = 0;
    record.RecordID = 7;
    [playList addObject:record];
    
    record = [[Records alloc] init];
    record.Question = @"Bit Size";
    record.Section = 0;
    record.RecordID = 8;
    [playList addObject:record];
    
    record = [[Records alloc] init];
    record.Question = @"Sire";
    record.Section = 0;
    record.RecordID = 9;
    [playList addObject:record];
    
    record = [[Records alloc] init];
    record.Question = @"Dam";
    record.Section = 0;
    record.RecordID = 10;
    [playList addObject:record];
    
    record = [[Records alloc] init];
    record.Question = @"Markings/Colour";
    record.Section = 0;
    record.RecordID = 11;
    [playList addObject:record];
    
    record = [[Records alloc] init];
    record.Question = @"Brands";
    record.Section = 0;
    record.RecordID = 12;
    [playList addObject:record];
    
    record = [[Records alloc] init];
    record.Question = @"Breeder";
    record.Section = 0;
    record.RecordID = 13;
    [playList addObject:record];
    
    record = [[Records alloc] init];
    record.Question = @"Registration #1";
    record.Section = 0;
    record.RecordID = 14;
    [playList addObject:record];
    
    record = [[Records alloc] init];
    record.Question = @"Registration #2";
    record.Section = 0;
    record.RecordID = 15;
    [playList addObject:record];
    
    record = [[Records alloc] init];
    record.Question = @"Registration #3";
    record.Section = 0;
    record.RecordID = 16;
    [playList addObject:record];
    
    record = [[Records alloc] init];
    record.Question = @"Other";
    record.Section = 0;
    record.RecordID = 17;
    [playList addObject:record];

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DB_Records"];
    request.predicate = [NSPredicate predicateWithFormat:@"section = %d", 0];
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    
    NSArray *results = [appdel.ShowHorseDatabase.managedObjectContext executeFetchRequest:request error:nil];
    
    for (DB_Records *currentrow in results){
        NSInteger recordindex = [currentrow.recordid integerValue] - 1;
        if ((playList.count > recordindex) && (recordindex > -1)){
            Records *temprecord = [playList objectAtIndex:recordindex];
            temprecord.Answer = currentrow.answer;
        }
    }
    
    
    /*AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    if (appdel.userinfo.UserID){
        PFQuery *query = [PFQuery queryWithClassName:@"User_Records"];
        [query whereKey:@"UserID" equalTo:appdel.userinfo.UserID];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
            if (!error){
                //find succeeded
                for (PFObject* currentrecord in objects){
                    NSInteger recordindex = [[currentrecord objectForKey:@"RecordID"] integerValue] - 1;
                    if ((playList.count > recordindex) && (recordindex > -1)){
                        Records *temprecord = [playList objectAtIndex:recordindex];
                        temprecord.Answer = [currentrecord objectForKey:@"Answer"];
                        temprecord.RecordObjectID = currentrecord.objectId;
                    }                    
                }
            }
            else{
                NSLog(@"Error:%@ %@", error, [error userInfo]);
            }
        }];
    }*/
    
    
    self.list = playList;
}

- (void)createRiderData {
    
    NSMutableArray *playList = [[NSMutableArray alloc] init];
    Records *record;
    
    record = [[Records alloc] init];
    record.Question = @"Name";
    record.Section = 1;
    record.RecordID = 1;
    [playList addObject:record];
    
    record = [[Records alloc] init];
    record.Question = @"D.O.B";
    record.Section = 1;
    record.RecordID = 2;
    [playList addObject:record];
    
    record = [[Records alloc] init];
    record.Question = @"Helmet";
    record.Section = 1;
    record.RecordID = 3;
    [playList addObject:record];
    
    record = [[Records alloc] init];
    record.Question = @"Boot";
    record.Section = 1;
    record.RecordID = 4;
    [playList addObject:record];
    
    record = [[Records alloc] init];
    record.Question = @"Jacket Size";
    record.Section = 1;
    record.RecordID = 5;
    [playList addObject:record];
    
    record = [[Records alloc] init];
    record.Question = @"Qualifications";
    record.Section = 1;
    record.RecordID = 6;
    [playList addObject:record];
    
    record = [[Records alloc] init];
    record.Question = @"Memberships";
    record.Section = 1;
    record.RecordID = 7;
    [playList addObject:record];
    
    record = [[Records alloc] init];
    record.Question = @"Blood Type";
    record.Section = 1;
    record.RecordID = 8;
    [playList addObject:record];
    
    record = [[Records alloc] init];
    record.Question = @"Medical Conditions/Allergies";
    record.Section = 1;
    record.RecordID = 9;
    [playList addObject:record];
    
    record = [[Records alloc] init];
    record.Question = @"Other";
    record.Section = 1;
    record.RecordID = 10;
    [playList addObject:record];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DB_Records"];
    request.predicate = [NSPredicate predicateWithFormat:@"section = %d", 1];
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    
    NSArray *results = [appdel.ShowHorseDatabase.managedObjectContext executeFetchRequest:request error:nil];
    
    for (DB_Records *currentrow in results){
        NSInteger recordindex = [currentrow.recordid integerValue] - 1;
        if ((playList.count > recordindex) && (recordindex > -1)){
            Records *temprecord = [playList objectAtIndex:recordindex];
            temprecord.Answer = currentrow.answer;
        }
    }
    
    /*
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    if (appdel.userinfo.UserID){
        PFQuery *query = [PFQuery queryWithClassName:@"User_Records"];
        [query whereKey:@"UserID" equalTo:appdel.userinfo.UserID];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
            if (!error){
                //find succeeded
                for (PFObject* currentrecord in objects){
                    NSInteger recordindex = [[currentrecord objectForKey:@"RecordID"] integerValue] - 11;
                    if ((playList.count > recordindex) && (recordindex > -1)){
                        Records *temprecord = [playList objectAtIndex:recordindex];
                        temprecord.Answer = [currentrecord objectForKey:@"Answer"];
                        temprecord.RecordObjectID = currentrecord.objectId;
                    }
                }
            }
            else{
                NSLog(@"Error:%@ %@", error, [error userInfo]);
            }
        }];
    }*/
    
    self.list = playList;
}
@end
