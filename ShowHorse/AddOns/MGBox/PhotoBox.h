//
//  Created by matt on 28/09/12.
//

#import "MGBox.h"

@interface PhotoBox : MGBox

+ (PhotoBox *)photoAddBoxWithSize:(CGSize)size;
+ (PhotoBox *)photoBoxFor:(int)i size:(CGSize)size theimage:(UIImage*)theimage;
- (void)loadPhoto:(UIImage*)theimage;

@end
