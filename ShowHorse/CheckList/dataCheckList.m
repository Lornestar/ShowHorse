//
//  dataCheckList.m
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-10-09.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import "dataCheckList.h"
#import "CheckList.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <CoreData/CoreData.h>
#import "DB_CheckList.h"

@implementation dataCheckList
@synthesize list;

-(id)init:(int)type{
    list = [[NSMutableArray alloc]init];
    switch (type) {
        case 1://Rider init
            [self setupRider];
            break;
        case 2://Saddlery
            [self setupSaddlery];
            break;
        case 3://Grooming
            [self setupGrooming];
            break;
        case 4://Stable
            [self setupStable];
            break;
        
        default:
            break;
    }
    
    //Check for additional checklist items
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DB_CheckList"];
    //request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    request.predicate = [NSPredicate predicateWithFormat:@"currentselection = %d", type];

    NSArray *results = [appdel.ShowHorseDatabase.managedObjectContext executeFetchRequest:request error:nil];
    
    for (DB_CheckList *currentrow in results){
        CheckList *caltemp = [[CheckList alloc]init];
        caltemp.theLabel = currentrow.thelabel;
        caltemp.listindex = list.count;
        [list addObject:caltemp];
    }
    
    //loop through results
    
    /*AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    PFQuery *query = [PFQuery queryWithClassName:@"User_CheckList"];
    [query whereKey:@"User_ID" equalTo:appdel.userinfo.UserID];
    [query whereKey:@"CurrentSelection" equalTo:[NSNumber numberWithInt:type]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error){
            //find succeeded
            for (PFObject* currentrecord in objects){
                CheckList *caltemp = [[CheckList alloc]init];
                
                NSString *tempthelabel = [currentrecord objectForKey:@"theLabel"];
                caltemp.theLabel = tempthelabel;
                caltemp.listindex = list.count;
                caltemp.checklistobject =currentrecord;
                [list addObject:caltemp];
            }
        }
        else{
            NSLog(@"Error:%@ %@", error, [error userInfo]);
        }
    }];*/
        
    
    return self;
}

-(CheckList*)AddCheckListItems:(CheckList*)CheckListObject CurrentSelection:(int)CurrentSelection{
    //Add new CheckList Item
    
    AppDelegate *appdel = [UIApplication sharedApplication].delegate;
    
    PFObject *checklistobject;
    if (CheckListObject.checklistobject.objectId.length > 0){
        //existing object
        checklistobject = CheckListObject.checklistobject;
        switch (CurrentSelection) {
            case 1:[appdel.listdataChecklistRiders.list setObject:CheckListObject atIndexedSubscript:CheckListObject.listindex];
                break;
            case 2:[appdel.listdataChecklistSaddlery.list setObject:CheckListObject atIndexedSubscript:CheckListObject.listindex];
                break;
            case 3:[appdel.listdataChecklistGrooming.list setObject:CheckListObject atIndexedSubscript:CheckListObject.listindex];
                break;
            case 4:[appdel.listdataChecklistStable.list setObject:CheckListObject atIndexedSubscript:CheckListObject.listindex];
                break;
        }
    }
    else{
        checklistobject = [PFObject objectWithClassName:@"User_CheckList"];
        switch (CurrentSelection) {
            case 1:
                CheckListObject.listindex = appdel.listdataChecklistRiders.list.count;
                [appdel.listdataChecklistRiders.list addObject:CheckListObject];
                break;
            case 2:CheckListObject.listindex = appdel.listdataChecklistSaddlery.list.count;
                [appdel.listdataChecklistSaddlery.list addObject:CheckListObject];
                break;
            case 3:CheckListObject.listindex = appdel.listdataChecklistGrooming.list.count;
                [appdel.listdataChecklistGrooming.list addObject:CheckListObject];
                break;
            case 4:CheckListObject.listindex = appdel.listdataChecklistStable.list.count;
                [appdel.listdataChecklistStable.list addObject:CheckListObject];
                break;
        }
    }
    
    [self InsertUpdateCheclistItem:CheckListObject.theLabel currentselection:CurrentSelection inManagedObjectContext:appdel.ShowHorseDatabase.managedObjectContext];
    [appdel SaveDatabase];
    /*
    //Add to d
    [checklistobject setObject:CheckListObject.theLabel forKey:@"theLabel"];
    [checklistobject setObject:appdel.userinfo.UserID forKey:@"User_ID"];
    [checklistobject setObject:[NSNumber numberWithInt:CurrentSelection] forKey:@"CurrentSelection"];
    [checklistobject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if (!error){
            CheckListObject.checklistobject = checklistobject;
        }
    }];
     */
    
    return CheckListObject;
}


-(void)InsertUpdateCheclistItem:(NSString *)name currentselection:(int)currentselection
inManagedObjectContext:(NSManagedObjectContext *)context
{
    DB_CheckList *dbchecklist = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DB_CheckList"];
    request.predicate = [NSPredicate predicateWithFormat:@"thelabel = %@", name];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"thelabel" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *checklistitems = [context executeFetchRequest:request error:&error];
    
    if (!checklistitems || ([checklistitems count] > 1)) {
        // handle error
    } else if (![checklistitems count]) {
        dbchecklist = [NSEntityDescription insertNewObjectForEntityForName:@"DB_CheckList"
                                                     inManagedObjectContext:context];
        //dbchecklist.thelabel = name;
        //dbchecklist.currentselection = [NSNumber numberWithInt:currentselection];
        
        [dbchecklist setValue:name forKey:@"thelabel"];
        [dbchecklist setValue:[NSNumber numberWithInt:currentselection] forKey:@"currentselection"];
    } else {
        dbchecklist = [checklistitems lastObject];
        [dbchecklist setValue:name forKey:@"thelabel"];
        [dbchecklist setValue:[NSNumber numberWithInt:currentselection] forKey:@"currentselection"];
    }
    
   
}


-(void)setupRider{
    //Add terms to Rider
    CheckList *tempchecklist;
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Inhand outfit/hat";
    tempchecklist.listindex = 0;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Hacking cane";
    tempchecklist.listindex = 1;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Shirt/tie/vest";
    tempchecklist.listindex = 2;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Stock/pin";
    tempchecklist.listindex = 3;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Show Jacket/s";
    tempchecklist.listindex = 4;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Hunter Jacket/s";
    tempchecklist.listindex = 5;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Show Helmet/Top Hat/Hat";
    tempchecklist.listindex = 6;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Work Helmet/s";
    tempchecklist.listindex = 7;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Boots/Top Boots";
    tempchecklist.listindex = 8;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Socks/stockings";
    tempchecklist.listindex = 9;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Gaiters";
    tempchecklist.listindex = 10;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Gloves";
    tempchecklist.listindex = 11;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Hair-scrunchy/pins/Nets";
    tempchecklist.listindex = 12;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Boot polish";
    tempchecklist.listindex = 13;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Jodhpurs/Breechers";
    tempchecklist.listindex = 14;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Rain Coat/Helmet cover";
    tempchecklist.listindex = 15;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Spurs and straps";
    tempchecklist.listindex = 16;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Jodhpur clips";
    tempchecklist.listindex = 17;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Rider arm band";
    tempchecklist.listindex = 18;
    [list addObject:tempchecklist];
}

-(void)setupSaddlery{
    //Add terms to Rider
    CheckList *tempchecklist;
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Inhand bridle/halter";
    tempchecklist.listindex = 0;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Number holder/s";
    tempchecklist.listindex = 1;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Lunge/whip";
    tempchecklist.listindex = 2;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Numnah/s";
    tempchecklist.listindex = 3;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Show saddle/s";
    tempchecklist.listindex = 4;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Hunter bridle/s";
    tempchecklist.listindex = 5;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Show Bridle/s";
    tempchecklist.listindex = 6;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Work Bridle/s";
    tempchecklist.listindex = 7;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Saddle Blankets";
    tempchecklist.listindex = 8;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Work boots/bandages";
    tempchecklist.listindex = 9;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Rugs/Hoods/tail bags";
    tempchecklist.listindex = 10;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Canvas rugs";
    tempchecklist.listindex = 11;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"False tails";
    tempchecklist.listindex = 12;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Work Saddle/s";
    tempchecklist.listindex = 13;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Show Brow Bands";
    tempchecklist.listindex = 14;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Hunter Brow Bands";
    tempchecklist.listindex = 15;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Show Girths";
    tempchecklist.listindex = 16;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Stirrups/leathers";
    tempchecklist.listindex = 17;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Reins/lead rein";
    tempchecklist.listindex = 18;
    [list addObject:tempchecklist];
    
}

-(void)setupGrooming{
    //Add terms to Rider
    CheckList *tempchecklist;
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Clean brushes/comb";
    tempchecklist.listindex = 0;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Shampoo/Cond";
    tempchecklist.listindex = 1;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Clipper/razors";
    tempchecklist.listindex = 2;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Plaiting thread/needles";
    tempchecklist.listindex = 3;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Rubber bands";
    tempchecklist.listindex = 4;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Proplait";
    tempchecklist.listindex = 5;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Horse makeup/black/white";
    tempchecklist.listindex = 6;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Coat Shine";
    tempchecklist.listindex = 7;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Disposable gloves";
    tempchecklist.listindex = 8;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Scissors";
    tempchecklist.listindex = 9;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Chalk";
    tempchecklist.listindex = 10;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Sandpaper";
    tempchecklist.listindex = 11;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Clean Towels";
    tempchecklist.listindex = 12;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Wipes";
    tempchecklist.listindex = 13;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Hoof black/Clear/hoof pick";
    tempchecklist.listindex = 14;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Checkers stencil/comb";
    tempchecklist.listindex = 15;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Fly Spray";
    tempchecklist.listindex = 16;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Mount block/plaiting step";
    tempchecklist.listindex = 17;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Leather cleaner";
    tempchecklist.listindex = 18;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Ravens oil";
    tempchecklist.listindex = 19;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Silver/brass cleaner";
    tempchecklist.listindex = 20;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Sponge";
    tempchecklist.listindex = 21;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Baby Oil";
    tempchecklist.listindex = 22;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Leather Hole Punch";
    tempchecklist.listindex = 23;
    [list addObject:tempchecklist];
}

-(void)setupStable{
    //Add terms to Rider
    CheckList *tempchecklist;
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Shovel";
    tempchecklist.listindex = 0;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Fork/manure bucket";
    tempchecklist.listindex = 1;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Broom";
    tempchecklist.listindex = 2;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Extension cord";
    tempchecklist.listindex = 3;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Washing gear/buckets";
    tempchecklist.listindex = 4;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Hose/tap fittings";
    tempchecklist.listindex = 5;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Bedding";
    tempchecklist.listindex = 6;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Hard Feed/hay";
    tempchecklist.listindex = 7;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"feed supplements";
    tempchecklist.listindex = 8;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Hay bags/Feed bins";
    tempchecklist.listindex = 9;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Medical Kit Human";
    tempchecklist.listindex = 10;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Medical Kit Horses";
    tempchecklist.listindex = 11;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Torch/lights";
    tempchecklist.listindex = 12;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Chairs/table";
    tempchecklist.listindex = 13;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Cool bin/Esky";
    tempchecklist.listindex = 14;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Picnic/food hamper";
    tempchecklist.listindex = 15;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Wheel barrow";
    tempchecklist.listindex = 16;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Pocket knife";
    tempchecklist.listindex = 17;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Tool kit";
    tempchecklist.listindex = 18;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Farrier tools/shoes";
    tempchecklist.listindex = 19;
    [list addObject:tempchecklist];
    
    tempchecklist= [[CheckList alloc] init];
    tempchecklist.theLabel = @"Tarps/ropes/tent pegs";
    tempchecklist.listindex = 20;
    [list addObject:tempchecklist];
}

@end
