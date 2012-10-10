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

@implementation DataRegPapers

-(RegistrationPapers*)AddRegPapers:(RegistrationPapers*)RegPapersObject{
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    
    PFObject *regpapersobject;
    if (RegPapersObject.PapersObject.objectId.length > 0){
        //existing object
        regpapersobject = RegPapersObject.PapersObject;
        [appdel.listdataPapers setObject:RegPapersObject atIndexedSubscript:RegPapersObject.listindex];
    }
    else{
        regpapersobject = [PFObject objectWithClassName:@"User_Registration_Papers"];
        RegPapersObject.listindex = appdel.listdataPapers.count;
        [appdel.listdataPapers addObject:RegPapersObject];        
    }
    
    
    //Add to db
    
    NSData *imgdata = UIImageJPEGRepresentation(RegPapersObject.Papers, .05f);
    [regpapersobject setObject:imgdata forKey:@"PapersImage"];
    [regpapersobject setObject:appdel.userinfo.UserID forKey:@"User_ID"];
    [regpapersobject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if (!error){
            RegPapersObject.PapersObject = regpapersobject;
        }
    }];
    return RegPapersObject;
}

-(void)DeleteRegPapers:(RegistrationPapers*)RegPapersObject{
    
        AppDelegate *appdel = [UIApplication sharedApplication].delegate;
        [appdel.listdataPapers removeObjectAtIndex:RegPapersObject.listindex];

        [RegPapersObject.PapersObject deleteInBackground];
    
    
}

- (RegistrationPapers *)objectInListAtIndex:(unsigned)theIndex;
{
    //return specific performance object
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    return [appdel.listdataPapers objectAtIndex:theIndex];
}

@end
