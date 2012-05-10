//
//  GridTableViewController.h
//  GirdLayout
//
//  Created by Yufei Lang on 12-5-7.
//  Copyright (c) 2012年 UB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RowCell.h"

@interface GridTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, RowCell>
{
    // use for setting Network Activity Indicator
    NSInteger _iHowManyImagesNeedToBeDownloaded;
    NSInteger _iHowManyImagesDownloaded;
}

@property (strong, nonatomic) NSMutableArray *arryImages;
@property (strong, nonatomic) NSMutableArray *arryURLs;
@property (strong, nonatomic) NSMutableArray *arryThumbnailImages;

// you may init with an array of images
- (void)initWithImageArray:(NSArray *)arryImages;

// you may also init with an array of images of URLs
// but bad link will be displayed with image file called "photo_not_available.png"
- (void)initWithURLArray:(NSArray *)arryURLs;

@end
