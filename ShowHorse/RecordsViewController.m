//
//  RecordsViewController.m
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-09-27.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import "RecordsViewController.h"
#import "DataHorseSummary.h"
#import "Records.h"
#import "PerformancePopup.h"
#import "DataPerformanceSummary.h"
#import "MGScrollView.h"
#import "MGTableBoxStyled.h"
#import "MGLine.h"
#import "PhotoBox.h"
#import "DataRegPapers.h"

#define TOTAL_IMAGES           28
#define IPHONE_INITIAL_IMAGES  0
#define IPAD_INITIAL_IMAGES    11

#define ROW_SIZE               (CGSize){304, 33}

#define IPHONE_PORTRAIT_PHOTO  (CGSize){120, 120}
#define IPHONE_LANDSCAPE_PHOTO (CGSize){152, 152}

#define IPHONE_PORTRAIT_GRID   (CGSize){312, 0}
#define IPHONE_LANDSCAPE_GRID  (CGSize){160, 0}
#define IPHONE_TABLES_GRID     (CGSize){320, 0}

#define HEADER_FONT            [UIFont fontWithName:@"HelveticaNeue" size:18]

@implementation RecordsViewController{
    MGBox *photosGrid, *tablesGrid, *table1, *table2;
}
@synthesize btnHorseSummary,btnRiderSummary,btnPerformanceSummary,btnRegistrationPapers;
@synthesize tblview,tableData,tblresult;
@synthesize dataHorseSummary, dataPerformanceSummary, dataRegPapers;
@synthesize hidingpoint, horsepoint, riderpoint, performpoint, registerpoint;
@synthesize txtEditField;
@synthesize appdelegate;
@synthesize tblviewperformance,CurrentSelection,btnAddPerformance, scrollPapers, vwRegPapers;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    tblview.alpha = 0;
    tblviewperformance.alpha = 0;
    btnAddPerformance.alpha = 0;
    //scrollPapers.alpha = 1;
    vwRegPapers.alpha = 0;
    //tblviewperformance.center = CGPointMake(160, 287);
    tblviewperformance.frame = CGRectMake(20, 113, 280, 280);
    //scrollPapers.frame = CGRectMake(20, 113, 280, 298);
    
    
    hidingpoint = CGPointMake(160, 500);
    horsepoint = CGPointMake(160, 72.5);
    riderpoint = CGPointMake(160, 162.5);
    performpoint = CGPointMake(160, 252.5);
    registerpoint = CGPointMake(160, 342.5);
    
    appdelegate = [UIApplication sharedApplication].delegate;
    CurrentSelection = 0;
    dataPerformanceSummary = [[DataPerformanceSummary alloc]init];
    dataRegPapers = [[DataRegPapers alloc] init];
    
    //photogrid
    // setup the main scroller (using a grid layout)
    scrollPapers.contentLayoutMode = MGLayoutGridStyle;
    scrollPapers.bottomPadding = 8;
    
    // iPhone or iPad grid?
    CGSize photosGridSize = IPHONE_PORTRAIT_GRID;
    
    // the photos grid
    photosGrid = [MGBox boxWithSize:photosGridSize];
    photosGrid.contentLayoutMode = MGLayoutGridStyle;
    [scrollPapers.boxes addObject:photosGrid];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Data Source methods



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Only one section, so return the number of items in the list.
    if ((CurrentSelection ==1) || (CurrentSelection == 2)){
        return [dataHorseSummary countOfList];
    }
    else{
        
        return appdelegate.listdataPerformances.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell;
    if ((CurrentSelection ==1) || (CurrentSelection == 2)){
        static NSString *CellIdentifier = @"mycell";
        
        // Dequeue or create a cell of the appropriate type.
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        // Get the object to display and set the value in the cell.
        Records *recordAtIndex = [dataHorseSummary objectInListAtIndex:indexPath.row];
        //cell.textLabel.text = recordAtIndex.Question;
        
        UILabel *lblQuestion = (UILabel*)[cell.contentView viewWithTag:1];
        lblQuestion.text = recordAtIndex.Question;
        UITextField *txtedit = (UITextField *)[cell.contentView viewWithTag:3];
        txtedit.placeholder = recordAtIndex.Question;
        UILabel *lblAnswer =(UILabel*)[cell.contentView viewWithTag:5];
        lblAnswer.text = recordAtIndex.Answer;
        if (recordAtIndex.Answer.length>0){
            txtedit.text = recordAtIndex.Answer;
        }
        cell.contentView.backgroundColor = [UIColor lightGrayColor];
    }
    else{
        static NSString *CellIdentifier = @"cellperformance";
        
        // Dequeue or create a cell of the appropriate type.
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        Performances *tempperf = [dataPerformanceSummary objectInListAtIndex:indexPath.row];
        
        UILabel *lblPerformance = (UILabel*)[cell.contentView viewWithTag:1];
        lblPerformance.text = tempperf.Name;
        
    }
    
    return cell;
}

-(void)ReturnState{
    tblview.alpha = 0;
    tblviewperformance.alpha = 0;
    //scrollPapers.alpha = 0;
    btnRiderSummary.alpha = 1;
    btnPerformanceSummary.alpha = 1;
    btnRegistrationPapers.alpha = 1;
    btnHorseSummary.alpha = 1;
    btnAddPerformance.alpha = 0;
    vwRegPapers.alpha = 0;
    
    btnRiderSummary.center = riderpoint;
    btnPerformanceSummary.center = performpoint;
    btnRegistrationPapers.center = registerpoint;
    btnHorseSummary.center = horsepoint;
}


- (IBAction)btnHorseSummary:(id)sender {
    CurrentSelection = 1;
    //Set Data
    dataHorseSummary = appdelegate.dataHorseSummary; //[[DataHorseSummary alloc] init];
    tableData = dataHorseSummary.list;
    [tblview reloadData];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelay:0.25];
    
    if (tblview.alpha == 1){
        //then return to normal
        
        [self ReturnState];
}
    else{
        tblview.alpha = 1;
        tblviewperformance.alpha = 0;
        //btnRiderSummary.alpha = 0;
        //btnPerformanceSummary.alpha = 0;
        //btnRegistrationPapers.alpha = 0;
        
        btnRiderSummary.center = hidingpoint;
        btnPerformanceSummary.center = hidingpoint;
        btnRegistrationPapers.center = hidingpoint;
    }
        
    [UIView commitAnimations];
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ((CurrentSelection ==1) || (CurrentSelection == 2)){
        UITableViewCell *thecell = [tblview cellForRowAtIndexPath:indexPath];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        //[UIView setAnimationDelay:0.25];
        
        //thecell.alpha = 0;
        UIView *tempview = (UIView *)[thecell.contentView viewWithTag:2];
        tempview.center = CGPointMake(tempview.center.x + 300, tempview.center.y);
        
        double offset = ((double)33 * (double)indexPath.row);
        //tblview.center = CGPointMake(tblview.center.x, tblview.center.y - offset);
        tblview.frame = CGRectMake(tblview.frame.origin.x, tblview.frame.origin.y, tblview.frame.size.width, tblview.frame.size.height - offset);
        [tblview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [UIView commitAnimations];
        
        UITextField *txtfield = (UITextField*)[thecell.contentView viewWithTag:3];
        [txtfield becomeFirstResponder];
    }
    else{
        //Selected Performance
        Performances *tempperf = [dataPerformanceSummary objectInListAtIndex:indexPath.row];
        
        PerformancePopup *performancepopup = [[PerformancePopup alloc] initWithFrame:self.view.bounds title:@"Add Performance" PerformanceObject:tempperf nibid:0 RegPapersObject:nil] ;
        
        
        performancepopup.onClosePressed = ^(UAModalPanel* panel) {
            // [panel hide];
            [panel hideWithOnComplete:^(BOOL finished) {
                [panel removeFromSuperview];
            }];
            UADebugLog(@"onClosePressed block called from panel: %@", modalPanel);
        };
        
        ///////////////////////////////////////////
        //   Panel is a reference to the modalPanel
        performancepopup.onActionPressed = ^(UAModalPanel* panel) {
            UADebugLog(@"onActionPressed block called from panel: %@", modalPanel);
            NSLog(@"Button Pressed");
        };
        
        UADebugLog(@"UAModalView will display using blocks: %@", modalPanel);
        
        performancepopup.delegate = self;
        
        ///////////////////////////////////
        // Add the panel to our view
        [self.view addSubview:performancepopup];
        
        ///////////////////////////////////
        // Show the panel from the center of the button that was pressed
        [performancepopup showFromPoint:self.view.center];

    }
}


- (IBAction)btnRiderSummary:(id)sender {
    CurrentSelection = 2;
    //Set Data
    dataHorseSummary = appdelegate.dataRiderSummary; //[[DataHorseSummary alloc] initRider];
    tableData = dataHorseSummary.list;
    [tblview reloadData];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelay:0.25];
    
    if (tblview.alpha == 1){
        //then return to normal
        
        [self ReturnState];
    }
    else{
        tblview.alpha = 1;
        tblviewperformance.alpha = 0;
        //btnHorseSummary.alpha = 0;
        //btnPerformanceSummary.alpha = 0;
        //btnRegistrationPapers.alpha = 0;
        
        btnRiderSummary.center = horsepoint;
        btnPerformanceSummary.center = hidingpoint;
        btnRegistrationPapers.center = hidingpoint;
        btnHorseSummary.center = hidingpoint;
    }
    
    
    
    [UIView commitAnimations];
}

- (IBAction)btnPerformanceSummary:(id)sender {
    CurrentSelection = 3;
    //Set Data
    tableData = appdelegate.listdataPerformances;
    [tblviewperformance reloadData];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelay:0.25];
    
    if (tblviewperformance.alpha == 1){
        //then return to normal
        
        [self ReturnState];
    }
    else{
        tblviewperformance.alpha = 1;
        btnAddPerformance.alpha = 1;
        tblview.alpha = 0;
        //btnHorseSummary.alpha = 0;
        //btnPerformanceSummary.alpha = 0;
        //btnRegistrationPapers.alpha = 0;
        
        btnPerformanceSummary.center = horsepoint;
        btnRiderSummary.center = hidingpoint;
        btnRegistrationPapers.center = hidingpoint;
        btnHorseSummary.center = hidingpoint;
    }
    
    
    
    [UIView commitAnimations];
}

-(void)PhotogridReset{
    [photosGrid.boxes removeAllObjects];
    //Set Data
    for (int i = 0; i < appdelegate.listdataPapers.count; i++) {
        RegistrationPapers *regtemp = [dataRegPapers objectInListAtIndex:i];
        [photosGrid.boxes addObject:[self photoBoxFor:1 theimage:regtemp.Papers RegPapersObject:regtemp]];
    }
    // add a blank "add photo" box
    [photosGrid.boxes addObject:self.photoAddBox];
    [photosGrid layoutWithSpeed:0.3 completion:nil];
    [scrollPapers layoutWithSpeed:0.3 completion:nil];
}

- (IBAction)btnRegistrationPapers:(id)sender {
    CurrentSelection = 4;
    
    if (photosGrid.boxes.count < 2){
        [self PhotogridReset];
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelay:0.25];
    
    if (vwRegPapers.alpha == 1){
        //then return to normal
        
        [self ReturnState];
    }
    else{
        tblview.alpha = 0;
        tblviewperformance.alpha =0;
        scrollPapers.alpha = 1;
        vwRegPapers.alpha = 1;
        
        btnPerformanceSummary.center = hidingpoint;
        btnRiderSummary.center = hidingpoint;
        btnRegistrationPapers.center = horsepoint;
        btnHorseSummary.center = hidingpoint;
    }
    [UIView commitAnimations];
    [self ScrollPapers_Show];
}

-(void)ScrollPapers_Show{
    // grid size
    photosGrid.size = IPHONE_PORTRAIT_GRID;
    
    // photo sizes
    CGSize size = IPHONE_PORTRAIT_PHOTO;
    
    // apply to each photo
    for (MGBox *photo in photosGrid.boxes) {
        photo.size = size;
        photo.layer.shadowPath
        = [UIBezierPath bezierPathWithRect:photo.bounds].CGPath;
        photo.layer.shadowOpacity = 0;
    }
    
    // relayout the sections
    [self.scrollPapers layoutWithSpeed:0.5 completion:nil];
}

- (void)viewDidUnload {
    [self setBtnHorseSummary:nil];
    [self setBtnRiderSummary:nil];
    [self setBtnPerformanceSummary:nil];
    [self setBtnRegistrationPapers:nil];
    [self setBtnRegistrationPapers:nil];
    [self setTblview:nil];
    [self setTxtEditField:nil];
    [self setTblviewperformance:nil];
    [self setBtnAddPerformance:nil];
    [self setScrollPapers:nil];
    [self setVwRegPapers:nil];
    [super viewDidUnload];
}

-(void)CloseEditField:(id)sender{
    CurrentSelection = 0;
    UIButton *thebutton = (UIButton*)sender;
    UITableViewCell *cell = [[thebutton superview]superview];
    
    //(UITableViewCell*)thecell = [[thebutton superview]superview];
    //int row = [tblview indexPathForCell:thecell].row;
    UITextField *txtfield = (UITextField*)[cell.contentView viewWithTag:3];
    UILabel *lblAnswer = (UILabel*)[cell.contentView viewWithTag:5];
    lblAnswer.text = txtfield.text;
    lblAnswer.alpha = 0;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    //[UIView setAnimationDelay:0.25];
    
    //thecell.alpha = 0;
    UIView *tempview = (UIView *)[cell.contentView viewWithTag:2];
    tempview.center = CGPointMake(tempview.center.x - 300, tempview.center.y);
    lblAnswer.alpha = 1;
    
    tblview.frame = CGRectMake(tblview.frame.origin.x, tblview.frame.origin.y, tblview.frame.size.width, 298);
    [tblview scrollToRowAtIndexPath:0 atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    
    [UIView commitAnimations];
    
    NSIndexPath *path= [tblview indexPathForCell:cell];
    [dataHorseSummary updateobjectInListAtIndex:path.row updatevalue:txtfield.text];
    
    [txtfield resignFirstResponder];
}

- (IBAction)btnEditDone:(id)sender {
    
    [self CloseEditField:sender];
    
}

- (IBAction)txtEditFieldDone:(id)sender {
    UITextField *txtedit = (UITextField*)sender;
    UITableViewCell *cell = [[txtedit superview]superview];
    UIButton *thebutton = (UIButton*)sender;
    [self CloseEditField:thebutton];
}

- (IBAction)btnPerformanceClicked:(id)sender {
    PerformancePopup *performancepopup = [[PerformancePopup alloc] initWithFrame:self.view.bounds title:[(UIButton *)sender titleForState:UIControlStateNormal] PerformanceObject:nil nibid:0 RegPapersObject:nil] ;
    
    
    performancepopup.onClosePressed = ^(UAModalPanel* panel) {
        // [panel hide];
        [panel hideWithOnComplete:^(BOOL finished) {
            [panel removeFromSuperview];
        }];
        UADebugLog(@"onClosePressed block called from panel: %@", modalPanel);
    };
    
    ///////////////////////////////////////////
    //   Panel is a reference to the modalPanel
    performancepopup.onActionPressed = ^(UAModalPanel* panel) {
        UADebugLog(@"onActionPressed block called from panel: %@", modalPanel);
        NSLog(@"Button Pressed");
    };
    
    UADebugLog(@"UAModalView will display using blocks: %@", modalPanel);
    
    performancepopup.delegate = self;
    
    ///////////////////////////////////
	// Add the panel to our view
	[self.view addSubview:performancepopup];
	
	///////////////////////////////////
	// Show the panel from the center of the button that was pressed
	[performancepopup showFromPoint:self.view.center];
}

-(void)AddPerformance:(Performances*)PerformanceObject{
    //Adds new performance to table & db
    DataPerformanceSummary *dataperformance = [[DataPerformanceSummary alloc] init];
    [dataperformance AddPerformance:PerformanceObject];
    
    tableData = appdelegate.listdataPerformances;
    [tblviewperformance reloadData];
}

-(void)AddRegPapers:(RegistrationPapers*)regtemp{
    //adding image for Reg Papers
    if (regtemp.PapersObject){
        //Existing object
        regtemp = [dataRegPapers AddRegPapers:regtemp];
        //[photosGrid.boxes removeObjectAtIndex:regtemp.listindex];
        [photosGrid.boxes setObject:[self photoBoxFor:1 theimage:regtemp.Papers RegPapersObject:regtemp] atIndex:regtemp.listindex];
    }
    else{
        //New one
        regtemp = [dataRegPapers AddRegPapers:regtemp];
        [photosGrid.boxes setObject:[self photoBoxFor:1 theimage:regtemp.Papers RegPapersObject:regtemp] atIndex:photosGrid.boxes.count-1];
        [photosGrid.boxes addObject:[self photoAddBox]];
    }
        
    
    [photosGrid layoutWithSpeed:0.3 completion:nil];
    [scrollPapers layoutWithSpeed:0.3 completion:nil];
}

-(void)DeleteRegPapers:(RegistrationPapers*)regtemp{
    [dataRegPapers DeleteRegPapers:regtemp];
    [self PhotogridReset];
}

- (void)didSelectActionButton:(UAModalPanel *)modalPanel {
	UADebugLog(@"didSelectActionButton called with modalPanel: %@", modalPanel);
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    // we're going to use a custom UICollectionViewCell, which will hold an image and its label
    //
    /*
    Cell *cell = [cv dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    
    // make the cell's title the actual NSIndexPath value
    cell.label.text = [NSString stringWithFormat:@"{%ld,%ld}", (long)indexPath.row, (long)indexPath.section];
    
    // load the image for this cell
    NSString *imageToLoad = [NSString stringWithFormat:@"%d.JPG", indexPath.row];
    cell.image.image = [UIImage imageNamed:imageToLoad];
    
    return cell;*/
    return nil;
}

- (CGSize)photoBoxSize {
  
    
    // what size plz?
    return IPHONE_PORTRAIT_PHOTO;
}

- (MGBox *)photoBoxFor:(int)i theimage:(UIImage*)theimage RegPapersObject:(RegistrationPapers*)RegPapersObject{
    
    // make the photo box
    PhotoBox *box = [PhotoBox photoBoxFor:i size:[self photoBoxSize] theimage:theimage];
    
    // remove the box when tapped
    __block id bbox = box;
    box.onTap = ^{
        PerformancePopup *performancepopup = [[PerformancePopup alloc] initWithFrame:self.view.bounds title:@"Edit Photo" PerformanceObject:nil nibid:1 RegPapersObject:RegPapersObject];
        
        
        performancepopup.onClosePressed = ^(UAModalPanel* panel) {
            // [panel hide];
            [panel hideWithOnComplete:^(BOOL finished) {
                [panel removeFromSuperview];
            }];
            UADebugLog(@"onClosePressed block called from panel: %@", modalPanel);
        };
        
        ///////////////////////////////////////////
        //   Panel is a reference to the modalPanel
        performancepopup.onActionPressed = ^(UAModalPanel* panel) {
            UADebugLog(@"onActionPressed block called from panel: %@", modalPanel);
            NSLog(@"Button Pressed");
        };
        
        UADebugLog(@"UAModalView will display using blocks: %@", modalPanel);
        
        performancepopup.delegate = self;
        
        ///////////////////////////////////
        // Add the panel to our view
        [self.view addSubview:performancepopup];
        
        ///////////////////////////////////
        // Show the panel from the center of the button that was pressed
        [performancepopup showFromPoint:self.view.center];
    };
    
    return box;
}

- (MGBox *)photoAddBox {
    
    // make the box
    PhotoBox *box = [PhotoBox photoAddBoxWithSize:[self photoBoxSize]];
    
    
    // deal with taps
    __block MGBox *bbox = box;
    box.onTap = ^{
        /*
        // a new photo number
        int photo = 1;//[self randomMissingPhoto];
        
        // replace the add box with a photo loading box
        int idx = [photosGrid.boxes indexOfObject:bbox];
        [photosGrid.boxes removeObject:bbox];
        [photosGrid.boxes insertObject:[self photoBoxFor:photo] atIndex:idx];
        [photosGrid layout];
        
        
        // all photos are in now?
        if (![self randomMissingPhoto]) {
            return;
        }
         
        
        // add another add box
        [photosGrid.boxes addObject:self.photoAddBox];
        
        // animate the section and the scroller
        [photosGrid layoutWithSpeed:0.3 completion:nil];
        [self.scrollPapers layoutWithSpeed:0.3 completion:nil];
         */
        PerformancePopup *performancepopup = [[PerformancePopup alloc] initWithFrame:self.view.bounds title:@"Add Photo" PerformanceObject:nil nibid:1 RegPapersObject:nil] ;
        
        
        performancepopup.onClosePressed = ^(UAModalPanel* panel) {
            // [panel hide];
            [panel hideWithOnComplete:^(BOOL finished) {
                [panel removeFromSuperview];
            }];
            UADebugLog(@"onClosePressed block called from panel: %@", modalPanel);
        };
        
        ///////////////////////////////////////////
        //   Panel is a reference to the modalPanel
        performancepopup.onActionPressed = ^(UAModalPanel* panel) {
            UADebugLog(@"onActionPressed block called from panel: %@", modalPanel);
            NSLog(@"Button Pressed");
        };
        
        UADebugLog(@"UAModalView will display using blocks: %@", modalPanel);
        
        performancepopup.delegate = self;
        
        ///////////////////////////////////
        // Add the panel to our view
        [self.view addSubview:performancepopup];
        
        ///////////////////////////////////
        // Show the panel from the center of the button that was pressed
        [performancepopup showFromPoint:self.view.center];
    };
     
    
    return box;
}

- (void)loadIntroSection {
    
    // intro section
    MGTableBoxStyled *menu = MGTableBoxStyled.box;
    [table1.boxes addObject:menu];
    
    // header line
    MGLine *header = [MGLine lineWithLeft:@"MGBox Demo" right:nil size:ROW_SIZE];
    header.font = HEADER_FONT;
    header.leftPadding = header.rightPadding = 16;
    [menu.topLines addObject:header];
    
    // layout menu line
    /*MGLine *layoutLine = [MGLine lineWithLeft:@"Layout Features" right:arrow
                                         size:ROW_SIZE];
    layoutLine.leftPadding = layoutLine.rightPadding = 16;
    [menu.topLines addObject:layoutLine];
    
    // load the features table on tap
    layoutLine.onTap = ^{
        [self loadLayoutFeaturesSection:YES];
    };
    
    // convenience features menu line
    MGLine
    *conviniLine = [MGLine lineWithLeft:@"Code Convenience Features" right:arrow
                                   size:ROW_SIZE];
    conviniLine.leftPadding = conviniLine.rightPadding = 16;
    [menu.topLines addObject:conviniLine];
    
    // load the features table on tap
    conviniLine.onTap = ^{
        [self loadConviniFeaturesSection:YES];
    };*/
}



@end
