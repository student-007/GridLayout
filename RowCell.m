//
//  RowCell.m
//  GridAlbum
//
//  Created by Yufei Lang on 12-5-7.
//  Copyright (c) 2012年 UB. All rights reserved.
//

#import "RowCell.h"

@implementation RowCell

@synthesize btn0 = _btn0;
@synthesize btn1 = _btn1;
@synthesize btn2 = _btn2;
@synthesize btn3 = _btn3;
@synthesize indicator0 = _indicator0;
@synthesize indicator1 = _indicator1;
@synthesize indicator2 = _indicator2;
@synthesize indicator3 = _indicator3;
@synthesize cellIndexPath = _cellIndexPath;
@synthesize delegate = _delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellForIndexPath: (NSIndexPath *)index
{
    self.cellIndexPath = index;
}

- (void)executeDownloadWithURL: (NSString *)strURL ForOverAllIndex: (NSInteger)iIndexOverAll ForWhichButtonInCell: (NSInteger)iWhichButton
{
    // make a signature
    NSMethodSignature *sig = [self.class instanceMethodSignatureForSelector:@selector(downloadImageUseURL:ForOverAllIndex:ForWhichButtonInCell:)];
    
    // create a NSInvocation based on signature
    NSInvocation *invocation=[NSInvocation invocationWithMethodSignature:sig];
    
    // set target
    [invocation setTarget:self];
    
    // set selector
    [invocation setSelector:@selector(downloadImageUseURL:ForOverAllIndex:ForWhichButtonInCell:)];
    
    // atIndex starts with 2
    // 0 1 are set for "target" and "selector"
    [invocation setArgument:&strURL atIndex:2];
    [invocation setArgument:&iIndexOverAll atIndex:3];
    [invocation setArgument:&iWhichButton atIndex:4];
    
    //[NSTimer scheduledTimerWithTimeInterval:0 invocation:invocation repeats:NO];
    [self performSelectorInBackground:@selector(startInvocationInBackground:) withObject:invocation];
}

- (void)startInvocationInBackground: (NSInvocation *)inv
{
    // invoke invocation
    [inv invoke];
}

//- (void)downloadImageUseURL: (NSString *)strURL ForOverAllIndex: (NSInteger)iIndexOverAll ForWhichButtonInCell: (NSInteger)iWhichButton
- (void)downloadImageUseURL: (NSString *)strURL ForOverAllIndex: (NSInteger)iIndexOverAll ForWhichButtonInCell: (NSInteger)iWhichButton
{
    // set status bar as accessing network
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    // download image with URL
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:strURL]]];
    
    // check if image is good one or not
    if ([img isKindOfClass:[UIImage class]]) 
    [self.delegate finishedDownloadingImage:img ForOverAllIndex:iIndexOverAll ForWhichButtonInCell:iWhichButton AtTableViewIndex:self.cellIndexPath];
    else
        [self.delegate finishedDownloadingImage:[UIImage imageNamed:@"photo_not_available.png"] ForOverAllIndex:iIndexOverAll ForWhichButtonInCell:iWhichButton AtTableViewIndex:self.cellIndexPath];
}


- (IBAction)btnImgBtnClicked:(UIButton *)sender {
    if (sender.imageView.image != nil)
    {
        // each btn in cell has a unique tag from 1~4 cause it shouldn't be 0
        // but index should be -1
        NSInteger iWhichBtn = sender.tag - 1;
        [self.delegate btnClickedForImageIndex:self.cellIndexPath.row * 4 + iWhichBtn];
    }
}


@end
