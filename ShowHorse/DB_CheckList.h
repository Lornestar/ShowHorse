//
//  DB_CheckList.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-11-15.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DB_CheckList : NSManagedObject

@property (nonatomic, retain) NSNumber * currentselection;
@property (nonatomic, retain) NSString * thelabel;

@end
