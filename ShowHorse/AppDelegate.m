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


@implementation AppDelegate
@synthesize dataHorseSummary,dataRiderSummary,userinfo,listdataPerformances,listdataPapers;
@synthesize listdataChecklistGrooming, listdataChecklistRiders, listdataChecklistSaddlery, listdataChecklistStable;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"Nj1U5DFrtOfwMlA8bGrAGVqK3ymZe0LsGLo9YGLF"
                  clientKey:@"pDEbnN7pSQ6h2Ae8vtxJiMQcxGV2QhVSbwL5dpvv"];
    
    [PFUser enableAutomaticUser];
    PFACL *defaultACL = [PFACL ACL];
    // Optionally enable public read access by default.
    // [defaultACL setPublicReadAccess:YES];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    
    userinfo = [[User alloc]init];
    if (userinfo.UserID){
        [self initRecords];
        [self initPerformances];
        [self initPapers];
        [self initChecklist];
        
    }
    
        
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
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void) initRecords{
    dataHorseSummary = [[DataHorseSummary alloc] init];
    dataRiderSummary = [[DataHorseSummary alloc] initRider];
}

-(void) initPerformances{
    if (listdataPerformances == nil){
        listdataPerformances = [[NSMutableArray alloc] init];
    }
    
    PFQuery *query = [PFQuery queryWithClassName:@"User_Performances"];
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
    }];
}

-(void) initPapers{
    if (listdataPapers == nil){
        listdataPapers = [[NSMutableArray alloc] init];
    }
    
    PFQuery *query = [PFQuery queryWithClassName:@"User_Registration_Papers"];
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
    }];
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

-(void)logoutVariables{
    listdataChecklistStable = nil;
    listdataChecklistSaddlery = nil;
    listdataChecklistRiders = nil;
    listdataChecklistGrooming = nil;
    userinfo = nil;
    listdataPapers = nil;
    listdataPerformances = nil;
}
@end
