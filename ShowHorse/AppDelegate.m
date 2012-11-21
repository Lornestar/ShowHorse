//
//  AppDelegate.m
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-09-16.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "Performances.h"
#import "RegistrationPapers.h"
#import "dataCheckList.h"
#import "CalendarDates.h"
#import "TestFlight.h"
#import <CoreData/CoreData.h>
#import "DB_Calendar_Dates.h"
#import "DB_Performance.h"
#import "DB_Registration_Papers.h"


@implementation AppDelegate
@synthesize dataHorseSummary,dataRiderSummary,userinfo,listdataPerformances,listdataPapers;
@synthesize listdataChecklistGrooming, listdataChecklistRiders, listdataChecklistSaddlery, listdataChecklistStable,listdataCalendarDates,df;
@synthesize ShowHorseDatabase;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"Nj1U5DFrtOfwMlA8bGrAGVqK3ymZe0LsGLo9YGLF"
                  clientKey:@"pDEbnN7pSQ6h2Ae8vtxJiMQcxGV2QhVSbwL5dpvv"];
    
    [PFUser enableAutomaticUser];
    PFACL *defaultACL = [PFACL ACL];
    // Optionally enable public read access by default.
    // [defaultACL setPublicReadAccess:YES];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    
    df = [[NSDateFormatter alloc]init];
    [df setDateStyle:NSDateFormatterLongStyle];
    [df setTimeStyle:NSDateFormatterMediumStyle];


    [TestFlight takeOff:@"059244bb96c7be63f638749260df0bda_MTM5ODI0MjAxMi0xMC0xOCAwNDoxMToyMy4yNDMzNTU"];
    
    [self initDatabase];
    
    
    
    /*
    if (!userinfo.UserID){
        userinfo = [[User alloc]init];
        if (userinfo.UserID){
            [self initRecords];
            [self initPerformances];
            [self initPapers];
            
            [self initCalendarDates];
        }
    }
    else{
        UIAlertView *alerttemp = [[UIAlertView alloc]initWithTitle:@"" message:@"Loaded info" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alerttemp show];
    }*/
    
    
    
    
    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self SaveUserinfo];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self LoadUserinfo];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self SaveUserinfo];
}

-(void)SaveUserinfo{
    NSUserDefaults *nsuser = [NSUserDefaults standardUserDefaults];
    
    
    [nsuser setObject:userinfo.UserID forKey:@"userid"];
    [nsuser setObject:userinfo.Username forKey:@"username"];
    
   
    //[nsuser setObject:datatemp forKey:@"listdataCalendarDates"];
    /*[nsuser setObject:[NSArray arrayWithArray:listdataChecklistGrooming.list] forKey:@"listdataChecklistGrooming"];
    [nsuser setObject:[NSArray arrayWithArray:listdataChecklistRiders.list] forKey:@"listdataChecklistRiders"];
    [nsuser setObject:[NSArray arrayWithArray:listdataChecklistSaddlery.list] forKey:@"listdataChecklistSaddlery"];
    [nsuser setObject:[NSArray arrayWithArray:listdataChecklistStable.list] forKey:@"listdataChecklistStable"];
    [nsuser setObject:[NSArray arrayWithArray:listdataPapers] forKey:@"listdataPapers"];
    [nsuser setObject:[NSArray arrayWithArray:listdataPerformances] forKey:@"listdataPerformances"];
    [nsuser synchronize];*/
}

-(void)LoadUserinfo{
    NSUserDefaults *nsuser = [NSUserDefaults standardUserDefaults];
    userinfo.UserID = [nsuser objectForKey:@"userid"];
    userinfo.Username = [nsuser objectForKey:@"username"];
    if (userinfo.UserID){
        /*[self initChecklist];
        
        listdataCalendarDates = [NSKeyedUnarchiver unarchiveObjectWithData:[nsuser objectForKey:@"listdataCalendarDates"]];
        listdataChecklistGrooming.list  = [nsuser objectForKey:@"listdataChecklistGrooming"];
        listdataChecklistRiders.list = [nsuser objectForKey:@"listdataChecklistRiders"];
        listdataChecklistSaddlery.list = [nsuser objectForKey:@"listdataChecklistSaddlery"];
        listdataChecklistStable.list = [nsuser objectForKey:@"listdataChecklistStable"];
        listdataPapers = [nsuser objectForKey:@"listdataPapers"];
        listdataPerformances = [nsuser objectForKey:@"listdataPerformances"];*/
    }
}

-(void) initRecords{
    dataHorseSummary = [[DataHorseSummary alloc] init];
    dataRiderSummary = [[DataHorseSummary alloc] initRider];
}

-(void) initPerformances{
    if (listdataPerformances == nil){
        listdataPerformances = [[NSMutableArray alloc] init];
    }
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DB_Performance"];
    //request.predicate = [NSPredicate predicateWithFormat:@"currentselection = %@", type];
    
    NSArray *results = [ShowHorseDatabase.managedObjectContext executeFetchRequest:request error:nil];
    for (DB_Performance *currentrow in results){
        Performances *tempperf = [[Performances alloc]init];
        tempperf.Date = currentrow.date;
        tempperf.Name = currentrow.name;
        tempperf.Description = currentrow.perf_description;
        tempperf.Placing = currentrow.placing;
        tempperf.Judge = currentrow.judge;
        tempperf.Competitors = currentrow.competitors;
        tempperf.Score = currentrow.score;
        tempperf.PerformanceObject = currentrow;
        tempperf.listindex = listdataPerformances.count;
        [listdataPerformances addObject:tempperf];
    }
    
    /*PFQuery *query = [PFQuery queryWithClassName:@"User_Performances"];
    [query whereKey:@"User_ID" equalTo:userinfo.UserID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error){
            if (listdataPerformances.count > 0){
                [listdataPerformances removeAllObjects];
            }
            
            //find succeeded
            for (PFObject* currentrecord in objects){
                NSMutableDictionary *tempdict = [currentrecord objectForKey:@"Performance"];
                Performances *tempperf = [[Performances alloc]init];
                tempperf.Date = [tempdict objectForKey:@"Date"];
                tempperf.Name = [tempdict objectForKey:@"Name"];
                tempperf.Description = [tempdict objectForKey:@"Description"];
                tempperf.Placing = [tempdict objectForKey:@"Placing"];
                tempperf.Judge = [tempdict objectForKey:@"Judge"];
                tempperf.Competitors = [tempdict objectForKey:@"Competitors"];
                tempperf.Score =[tempdict objectForKey:@"Score"];
                tempperf.PerformanceObject = currentrecord;
                tempperf.listindex = listdataPerformances.count;
                [listdataPerformances addObject:tempperf];
            }
        }
        else{
            NSLog(@"Error:%@ %@", error, [error userInfo]);
        }
    }];*/
}

-(void) initPapers{
    if (listdataPapers == nil){
        listdataPapers = [[NSMutableArray alloc] init];
    }
    
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DB_Registration_Papers"];
    //request.predicate = [NSPredicate predicateWithFormat:@"currentselection = %@", type];
    
    NSArray *results = [ShowHorseDatabase.managedObjectContext executeFetchRequest:request error:nil];
    for (DB_Registration_Papers *currentrow in results){
        RegistrationPapers *regtemp = [[RegistrationPapers alloc]init];
        
        NSData *tempdata = currentrow.papersimage;
        UIImage *imgtemp = [[UIImage alloc] initWithData:tempdata];
        regtemp.Papers = imgtemp;
        regtemp.PapersObject = currentrow;
        regtemp.listindex = listdataPapers.count;
        [listdataPapers addObject:regtemp];
    }
    
    /*PFQuery *query = [PFQuery queryWithClassName:@"User_Registration_Papers"];
    [query whereKey:@"User_ID" equalTo:userinfo.UserID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error){
            if (listdataPapers.count > 0){
                [listdataPapers removeAllObjects];
            }
            //find succeeded
            for (PFObject* currentrecord in objects){
                RegistrationPapers *regtemp = [[RegistrationPapers alloc]init];
                
                NSData *tempdata = [currentrecord objectForKey:@"PapersImage"];
                UIImage *imgtemp = [[UIImage alloc] initWithData:tempdata];
                regtemp.Papers = imgtemp;
                regtemp.PapersObject = currentrecord;
                regtemp.listindex = listdataPapers.count;
                [listdataPapers addObject:regtemp];
            }
        }
        else{
            NSLog(@"Error:%@ %@", error, [error userInfo]);
        }
    }];*/
}

-(void) initChecklist{
    listdataChecklistRiders = [[dataCheckList alloc] init:1];
    listdataChecklistSaddlery = [[dataCheckList alloc] init:2];
    listdataChecklistGrooming = [[dataCheckList alloc] init:3];
    listdataChecklistStable = [[dataCheckList alloc] init:4];
}

-(void) initUser:(NSString*)username userid:(NSString*)userid{
    if (userinfo == nil){
        userinfo = [[User alloc]init];
    }
    userinfo.Username = username;
    userinfo.UserID = userid;
}

-(void) initCalendarDates{
    //initialize Calendar Dates
    
    if (listdataCalendarDates == nil){
        listdataCalendarDates = [[NSMutableArray alloc]init];
    }
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DB_Calendar_Dates"];
    //request.predicate = [NSPredicate predicateWithFormat:@"currentselection = %@", type];
    
    NSArray *results = [ShowHorseDatabase.managedObjectContext executeFetchRequest:request error:nil];
    for (DB_Calendar_Dates *currentrow in results){
        CalendarDates *caltemp = [[CalendarDates alloc]init];
        
        caltemp.EventDate = currentrow.eventdate;
        caltemp.EventDescription = currentrow.eventdescription;
        caltemp.EventTitle = currentrow.eventtitle;
        caltemp.listindex = [currentrow.listindex intValue];
        caltemp.CalendarDatesObject = currentrow;
        [listdataCalendarDates addObject:caltemp];
    }
    
    
    /*PFQuery *query = [PFQuery queryWithClassName:@"User_Calendar_Dates"];
    [query whereKey:@"User_ID" equalTo:userinfo.UserID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error){
            if (listdataCalendarDates.count > 0){
                [listdataCalendarDates removeAllObjects];
            }
            //find succeeded
            for (PFObject* currentrecord in objects){
                CalendarDates *caltemp = [[CalendarDates alloc]init];
                
                NSDate *tempdate = [currentrecord objectForKey:@"EventDate"];
                NSString *temptitle = [currentrecord objectForKey:@"EventTitle"];
                NSString *tempdesc = [currentrecord objectForKey:@"EventDescription"];
                caltemp.EventDate = tempdate;
                caltemp.EventDescription = tempdesc;
                caltemp.EventTitle = temptitle;
                caltemp.listindex = listdataCalendarDates.count;
                caltemp.CalendarDatesObject =currentrecord;
                [listdataCalendarDates addObject:caltemp];
            }
        }
        else{
            NSLog(@"Error:%@ %@", error, [error userInfo]);
        }
    }];
    */
    
    
    
}

-(void)logoutVariables{
    listdataChecklistStable = nil;
    listdataChecklistSaddlery = nil;
    listdataChecklistRiders = nil;
    listdataChecklistGrooming = nil;
    userinfo = nil;
    listdataPapers = nil;
    listdataPerformances = nil;
    listdataCalendarDates = nil;
}

-(void)initDatabase{
    if (!self.ShowHorseDatabase) {  // for demo purposes, we'll create a default database if none is set
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent:@"ShowHorse Database"];
        // url is now "<Documents Directory>/ShowHorse Database"
        self.ShowHorseDatabase = [[UIManagedDocument alloc] initWithFileURL:url]; // setter will create this for us on disk
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.ShowHorseDatabase.fileURL path]]) {
        // does not exist on disk, so create it
        [self.ShowHorseDatabase saveToURL:self.ShowHorseDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            [self initapp];
            
        }];
    } else if (self.ShowHorseDatabase.documentState == UIDocumentStateClosed) {
        // exists on disk, but we need to open it
        [self.ShowHorseDatabase openWithCompletionHandler:^(BOOL success) {
            [self initapp];
        }];
    } else if (self.ShowHorseDatabase.documentState == UIDocumentStateNormal) {
        // already open and ready to use
        [self initapp];
    }
}

-(void)initapp{
    [self initChecklist];
    [self initCalendarDates];
    [self initRecords];
    [self initPerformances];
    [self initPapers];
}

-(void)SaveDatabase{
    [ShowHorseDatabase saveToURL:ShowHorseDatabase.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:NULL];
}

@end
