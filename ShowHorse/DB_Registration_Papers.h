//
//  DB_Registration_Papers.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-11-17.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DB_Registration_Papers : NSManagedObject

@property (nonatomic, retain) NSData * papersimage;
@property (nonatomic, retain) NSNumber * listindex;

@end
