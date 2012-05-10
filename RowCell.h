//
//  RowCell.h
//  GridAlbum
//
//  Created by Yufei Lang on 12-5-7.
//  Copyright (c) 2012年 UB. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RowCell;

@interface RowCell : UITableViewCell

@property (weak, nonatomic) id<RowCell> delegate;

@property (strong, nonatomic) NSIndexPath *cellIndexPath; 

@property (weak, nonatomic) IBOutlet UIButton *btn0;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator0;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator1;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator2;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator3;

// when creating or setting this cell, also tell this cell what's its index path in table view
- (void)setCellForIndexPath: (NSIndexPath *)index;

// start download with a url with index in GridTableViewController's arrayImage
// which button(image), there are four images in one cell
- (void)executeDownloadWithURL: (NSString *)strURL ForOverAllIndex: (NSInteger)iIndexOverAll ForWhichButtonInCell: (NSInteger)iWhichButton;

@end

@protocol RowCell <NSObject>
- (void)btnClickedForImageIndex: (NSInteger)index;
- (void)finishedDownloadingImage: (UIImage *)img ForOverAllIndex: (NSInteger)iIndexOverAll 
            ForWhichButtonInCell: (NSInteger)iWhichButton AtTableViewIndex: (NSIndexPath *)indexPath;
@end