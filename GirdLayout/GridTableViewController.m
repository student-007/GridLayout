//
//  GridTableViewController.m
//  GirdLayout
//
//  Created by Yufei Lang on 12-5-7.
//  Copyright (c) 2012年 UB. All rights reserved.
//

#import "GridTableViewController.h"

@implementation GridTableViewController

@synthesize arryImages = _arryImages;
@synthesize arryURLs = _arryURLs;
@synthesize arryThumbnailImages = _arryThumbnailImages;

#pragma mark - self method

// this will return a smaller square UIImage* based on image that you provide
// use for make thumbnails
- (UIImage *)createSquareImageWithImage: (UIImage *)img InSizeOf: (CGSize) newSize
{
    // cut image into a square using the shorter side as square side
    CGFloat w = img.size.width;
    CGFloat h = img.size.height;
    
    CGImageRef imageRef;
    
    if (w > h) {
        imageRef = CGImageCreateWithImageInRect([img CGImage], CGRectMake((w - h) / 2.0, 0, h, h));
    } else {
        imageRef = CGImageCreateWithImageInRect([img CGImage], CGRectMake(0, (h - w) / 2.0, w, w));
    }
    
    UIImage *imgNewImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    UIGraphicsBeginImageContext(newSize);
    [imgNewImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    imgNewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imgNewImage;
}

#pragma mark 

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)initWithImageArray:(NSArray *)arryImages
{
    self.arryImages = [NSMutableArray arrayWithArray:arryImages];
    self.arryThumbnailImages = [NSMutableArray array];
    
    // also add thumbnails into the thumbnails array
    for (UIImage *img in self.arryImages) {
        [self.arryThumbnailImages addObject:[self createSquareImageWithImage:img InSizeOf:CGSizeMake(150, 150)]];
    }
}

- (void)initWithURLArray:(NSArray *)arryURLs
{
    self.arryURLs = [NSMutableArray arrayWithArray:arryURLs];
    
    // set Network Activity Indicator flag
    _iHowManyImagesDownloaded = 0;
    _iHowManyImagesNeedToBeDownloaded = 0;
    
    // image array & thumbnail array are have to be created with same size
    // in order to be replaced by downloaded img from internet
    if (!self.arryImages) 
    {
        self.arryImages = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.arryURLs.count; i++) 
            [self.arryImages addObject:@""];
    }
    
    if (!self.arryThumbnailImages) 
    {
        self.arryThumbnailImages = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.arryURLs.count; i++) 
            [self.arryThumbnailImages addObject:@""];
    }
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
    self.arryThumbnailImages = nil;
    self.arryImages = nil;
    
    // reset Network Activity Indicator flag
    _iHowManyImagesDownloaded = 0;
    _iHowManyImagesNeedToBeDownloaded = 0;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // set background here if you want to
    // but you have to change cell's indicator color as well (small black is the default)
    //[self.view setBackgroundColor:[UIColor blueColor]]; 
    
    // set separator to none
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // set navication bar to transparent
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    
    // set status bar to transparent for better looking
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // set navication bar to transparent
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    
    // set status bar to transparent for better looking
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    // if the thumbnail array has benn inited already
    if (self.arryThumbnailImages) 
    {
        if (self.arryThumbnailImages.count % 4 == 0) 
        {
            return self.arryThumbnailImages.count / 4;
        }
        else
            return self.arryThumbnailImages.count / 4 + 1;
    }
    // if URLs is used to inited
    else if (self.arryURLs)
    {
        if (self.arryURLs.count % 4 == 0) 
        {
            return self.arryURLs.count / 4;
        }
        else
            return self.arryURLs.count / 4 + 1;
    }
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RowCell";
    
    RowCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RowCell" owner:self options:nil] objectAtIndex:0];
        cell.delegate = self;
        if (cell.cellIndexPath == nil) {
            [cell setCellForIndexPath:indexPath];}
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSInteger iImgIndexOverAllRangeBeginAt = indexPath.row * 4;
    NSInteger iOverAllIndexForBtn0 = iImgIndexOverAllRangeBeginAt + 0;
    NSInteger iOverAllIndexForBtn1 = iImgIndexOverAllRangeBeginAt + 1;
    NSInteger iOverAllIndexForBtn2 = iImgIndexOverAllRangeBeginAt + 2;
    NSInteger iOverAllIndexForBtn3 = iImgIndexOverAllRangeBeginAt + 3;
    
    // if all images downloaded are removed from array due to memory warning
    if (self.arryThumbnailImages == nil && 
        self.arryThumbnailImages == nil && 
        self.arryURLs) 
    {
        [self initWithURLArray:self.arryURLs];
    }
    
    if (self.arryThumbnailImages.count > iOverAllIndexForBtn0) {
        NSObject *obj = [self.arryThumbnailImages objectAtIndex:iOverAllIndexForBtn0];
        if ([obj isKindOfClass:[UIImage class]]) {
            [cell.indicator0 stopAnimating];
            [cell.indicator0 setHidden:YES];
            [cell.btn0 setImage:[self.arryThumbnailImages objectAtIndex:iOverAllIndexForBtn0] forState:UIControlStateNormal];
        }
        else if (self.arryURLs.count > iOverAllIndexForBtn0)
        {
            [cell.indicator0 startAnimating];
            [cell executeDownloadWithURL:[self.arryURLs objectAtIndex:iOverAllIndexForBtn0] ForOverAllIndex:iOverAllIndexForBtn0 ForWhichButtonInCell:0];
            ++_iHowManyImagesNeedToBeDownloaded;
        }
        else 
        {
            [cell.indicator0 stopAnimating];
            [cell.indicator0 setHidden:YES];
        }
    }
    
    if (self.arryThumbnailImages.count > iOverAllIndexForBtn1) {
        NSObject *obj = [self.arryThumbnailImages objectAtIndex:iOverAllIndexForBtn1];
        if ([obj isKindOfClass:[UIImage class]]) {
            [cell.indicator1 stopAnimating];
            [cell.indicator1 setHidden:YES];
            [cell.btn1 setImage:[self.arryThumbnailImages objectAtIndex:iOverAllIndexForBtn1] forState:UIControlStateNormal];
        }
        else if (self.arryURLs.count > iOverAllIndexForBtn1)
        {
            [cell.indicator1 startAnimating];
            [cell executeDownloadWithURL:[self.arryURLs objectAtIndex:iOverAllIndexForBtn1] ForOverAllIndex:iOverAllIndexForBtn1 ForWhichButtonInCell:1];
            ++_iHowManyImagesNeedToBeDownloaded;
        }
        else 
        {
            [cell.indicator1 stopAnimating];
            [cell.indicator1 setHidden:YES];
        }
    }
    
    if (self.arryThumbnailImages.count > iOverAllIndexForBtn2) {
        NSObject *obj = [self.arryThumbnailImages objectAtIndex:iOverAllIndexForBtn2];
        if ([obj isKindOfClass:[UIImage class]]) {
            [cell.indicator2 stopAnimating];
            [cell.indicator2 setHidden:YES];
            [cell.btn2 setImage:[self.arryThumbnailImages objectAtIndex:iOverAllIndexForBtn2] forState:UIControlStateNormal];
        }
        else if (self.arryURLs.count > iOverAllIndexForBtn2)
        {
            [cell.indicator2 startAnimating];
            [cell executeDownloadWithURL:[self.arryURLs objectAtIndex:iOverAllIndexForBtn2] ForOverAllIndex:iOverAllIndexForBtn2 ForWhichButtonInCell:2];
            ++_iHowManyImagesNeedToBeDownloaded;
        }
        else 
        {
            [cell.indicator2 stopAnimating];
            [cell.indicator2 setHidden:YES];
        }
    }
    
    if (self.arryThumbnailImages.count > iOverAllIndexForBtn3) {
        NSObject *obj = [self.arryThumbnailImages objectAtIndex:iOverAllIndexForBtn3];
        if ([obj isKindOfClass:[UIImage class]]) {
            [cell.indicator3 stopAnimating];
            [cell.indicator3 setHidden:YES];
            [cell.btn3 setImage:[self.arryThumbnailImages objectAtIndex:iOverAllIndexForBtn3] forState:UIControlStateNormal];
        }
        else if (self.arryURLs.count > iOverAllIndexForBtn3)
        {
            [cell.indicator3 startAnimating];
            [cell executeDownloadWithURL:[self.arryURLs objectAtIndex:iOverAllIndexForBtn3] ForOverAllIndex:iOverAllIndexForBtn3 ForWhichButtonInCell:3];
            ++_iHowManyImagesNeedToBeDownloaded;
        }
        else 
        {
            [cell.indicator3 stopAnimating];
            [cell.indicator3 setHidden:YES];
        }
    }
    
    return cell;
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 79;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - RowCell Delegate

- (void)btnClickedForImageIndex: (NSInteger)index
{
    NSLog(@"image button tapped!%d", index);
}

- (void)finishedDownloadingImage: (UIImage *)img ForOverAllIndex: (NSInteger)iIndexOverAll 
            ForWhichButtonInCell: (NSInteger)iWhichButton AtTableViewIndex: (NSIndexPath *)indexPath
{
    ++_iHowManyImagesDownloaded;
    if (_iHowManyImagesDownloaded == _iHowManyImagesNeedToBeDownloaded) 
    {
        // set status bar as accessing network
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
    
    if (!self.arryImages) {
        self.arryImages = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.arryURLs.count; i++) {
            [self.arryImages addObject:@""];
        }
    }
    if (!self.arryThumbnailImages) {
        self.arryThumbnailImages = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.arryURLs.count; i++) {
            [self.arryThumbnailImages addObject:@""];
        }
    }
    [self.arryImages replaceObjectAtIndex:iIndexOverAll withObject: img];
    [self.arryThumbnailImages replaceObjectAtIndex:iIndexOverAll withObject:
     [self createSquareImageWithImage:img InSizeOf:CGSizeMake(150, 150)]];
    RowCell *cell = (RowCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    switch (iWhichButton) {
        case 0:
        {
            [cell.btn0 setImage:[self.arryThumbnailImages objectAtIndex:iIndexOverAll] forState:UIControlStateNormal];
            [cell.indicator0 stopAnimating];
        }
            break;
        case 1:
        {
            [cell.btn1 setImage:[self.arryThumbnailImages objectAtIndex:iIndexOverAll] forState:UIControlStateNormal];
            [cell.indicator1 stopAnimating];
        }
            break;
        case 2:
        {
            [cell.btn2 setImage:[self.arryThumbnailImages objectAtIndex:iIndexOverAll] forState:UIControlStateNormal];
            [cell.indicator2 stopAnimating];
        }
            break;
        case 3:
        {
            [cell.btn3 setImage:[self.arryThumbnailImages objectAtIndex:iIndexOverAll] forState:UIControlStateNormal];
            [cell.indicator3 stopAnimating];
        }
            break;
        default:
            break;
    }
}

@end
