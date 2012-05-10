//
//  MasterViewController.h
//  GirdLayout
//
//  Created by Yufei Lang on 12-5-7.
//  Copyright (c) 2012年 UB. All rights reserved.
//
// git test

#import <UIKit/UIKit.h>
#import "GridTableViewController.h"

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) GridTableViewController *detailViewController;

@end
