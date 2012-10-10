//
//  Created by matt on 28/09/12.
//

#import "PhotoBox.h"

@implementation PhotoBox

#pragma mark - Init

- (void)setup {

  // positioning
  self.topMargin = 8;
  self.leftMargin = 8;

  // background
  self.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:0];

  // shadow
  //self.layer.shadowColor = [UIColor colorWithWhite:0.12 alpha:1].CGColor;
  //self.layer.shadowOffset = CGSizeMake(0, 0.5);
  //self.layer.shadowRadius = 1;
  //self.layer.shadowOpacity = 1;
}

#pragma mark - Factories

+ (PhotoBox *)photoAddBoxWithSize:(CGSize)size {

  // basic box
  PhotoBox *box = [PhotoBox boxWithSize:size];

  // style and tag
 // box.backgroundColor = [UIColor colorWithRed:0.74 green:0.74 blue:0.75 alpha:0];
  box.tag = -1;

  // add the add image
  UIImage *add = [UIImage imageNamed:@"add.png"];
  UIImageView *addView = [[UIImageView alloc] initWithImage:add];
  [box addSubview:addView];
    
  //addView.center = (CGPoint){box.width / 2, box.height / 2};
  //addView.alpha = 0.2;
  /*addView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin
      | UIViewAutoresizingFlexibleRightMargin
      | UIViewAutoresizingFlexibleBottomMargin
      | UIViewAutoresizingFlexibleLeftMargin;
*/
    addView.size = size;
    addView.contentMode = UIViewContentModeScaleAspectFit;
  return box;
}

+ (PhotoBox *)photoBoxFor:(int)i size:(CGSize)size theimage:(UIImage*)theimage {

  // box with photo number tag
  PhotoBox *box = [PhotoBox boxWithSize:size];
  box.tag = i;
   
    
  // add a loading spinner
  UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]
      initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
  spinner.center = CGPointMake(box.width / 2, box.height / 2);
  spinner.autoresizingMask = UIViewAutoresizingFlexibleTopMargin
      | UIViewAutoresizingFlexibleRightMargin
      | UIViewAutoresizingFlexibleBottomMargin
      | UIViewAutoresizingFlexibleLeftMargin;
  spinner.color = UIColor.lightGrayColor;
  [box addSubview:spinner];
  [spinner startAnimating];

  // do the photo loading async, because internets
  //__block id bbox = box;
  //box.asyncLayoutOnce = ^{
  //    [bbox loadPhoto:theimage];
  //};
    [box loadPhoto:theimage];
    /*UIImageView *imageView = [[UIImageView alloc] initWithImage:theimage];
    imageView.size = size;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [box addSubview:imageView];*/

  return box;
}

#pragma mark - Layout

- (void)layout {
  [super layout];

  // speed up shadows
  self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

#pragma mark - Photo box loading

- (void)loadPhoto:(UIImage*)theimage {

    // ditch the spinner
    UIActivityIndicatorView *spinner = self.subviews.lastObject;
    [spinner stopAnimating];
    [spinner removeFromSuperview];

    
    // got the photo, so lets show it
    //UIImage *image = [UIImage imageWithData:data];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:theimage];
    [self addSubview:imageView];
    imageView.size = self.size;
    imageView.alpha = 0;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth
        | UIViewAutoresizingFlexibleHeight;

    // fade the image in
    [UIView animateWithDuration:0.2 animations:^{
      imageView.alpha = 1;
    }];
}

@end
