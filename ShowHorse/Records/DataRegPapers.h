//
//  DataRegPapers.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-10-08.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegistrationPapers.h"

@interface DataRegPapers : NSObject

-(RegistrationPapers*)AddRegPapers:(RegistrationPapers*)RegPapersObject;
- (RegistrationPapers *)objectInListAtIndex:(unsigned)theIndex;
-(void)DeleteRegPapers:(RegistrationPapers*)RegPapersObject;
@end
