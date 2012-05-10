//
//  MasterViewController.m
//  GirdLayout
//
//  Created by Yufei Lang on 12-5-7.
//  Copyright (c) 2012年 UB. All rights reserved.
//

#import "MasterViewController.h"


@implementation MasterViewController

@synthesize detailViewController = _detailViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor greenColor]];
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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    // Configure the cell.
    cell.textLabel.text = NSLocalizedString(@"Picture Grid", @"Picture Grid");
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (!self.detailViewController) {
        self.detailViewController = [[GridTableViewController alloc] initWithStyle:UITableViewStylePlain];
        NSArray *arryURLs = [[NSArray alloc] initWithObjects:@"http://collider.com/wp-content/uploads/blake-lively-image1-600x450.jpg", @"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b.jpg", @"http://farm4.static.flickr.com/3364/3338617424_7ff836d55f.jpg", @"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b.jpg",@"http://farm4.static.flickr.com/3364/3338617424_7ff836d55f.jpg", @"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b.jpg",@"http://cdn.thegloss.com/files/2011/12/blake-lively.jpg",@"http://3.bp.blogspot.com/_hN-RNLUCt5Q/TRDnhDvVMaI/AAAAAAAACMc/y82FrlD6H04/s1600/orange+smile+cg+girl+by+Ruoxing+Zhang.jpg",@"http://img5.pcpop.com/bizhi/big/10/179/150/10179150.jpg" ,@"http://img5.pcpop.com/bizhi/big/10/066/765/10066765.jpg",@"http://img5.pcpop.com/bizhi/big/10/179/145/10179145.jpg",@"http://img5.pcpop.com/bizhi/big/10/179/156/10179156.jpg" ,@"http://img5.pcpop.com/bizhi/big/10/173/640/10173640.jpg", @"http://img5.pcpop.com/bizhi/big/10/173/630/10173630.jpg",@"http://img5.pcpop.com/bizhi/big/10/049/877/10049877.jpg", @"http://img5.pcpop.com/bizhi/big/10/059/483/10059483.jpg", @"http://img5.pcpop.com/bizhi/big/10/131/155/10131155.jpg", @"http://img5.pcpop.com/bizhi/big/10/053/515/10053515.jpg",@"http://collider.com/wp-content/uploads/blake-lively-image1-600x450.jpg", @"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b.jpg", @"http://farm4.static.flickr.com/3364/3338617424_7ff836d55f.jpg", @"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b.jpg",@"http://farm4.static.flickr.com/3364/3338617424_7ff836d55f.jpg", @"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b.jpg",@"http://cdn.thegloss.com/files/2011/12/blake-lively.jpg",@"http://3.bp.blogspot.com/_hN-RNLUCt5Q/TRDnhDvVMaI/AAAAAAAACMc/y82FrlD6H04/s1600/orange+smile+cg+girl+by+Ruoxing+Zhang.jpg",@"http://img5.pcpop.com/bizhi/big/10/179/150/10179150.jpg" ,@"http://img5.pcpop.com/bizhi/big/10/066/765/10066765.jpg",@"http://img5.pcpop.com/bizhi/big/10/179/145/10179145.jpg",@"http://img5.pcpop.com/bizhi/big/10/179/156/10179156.jpg" ,@"http://img5.pcpop.com/bizhi/big/10/173/640/10173640.jpg", @"http://img5.pcpop.com/bizhi/big/10/173/630/10173630.jpg",@"http://img5.pcpop.com/bizhi/big/10/049/877/10049877.jpg", @"http://img5.pcpop.com/bizhi/big/10/059/483/10059483.jpg", @"http://img5.pcpop.com/bizhi/big/10/131/155/10131155.jpg", @"http://img5.pcpop.com/bizhi/big/10/053/515/10053515.jpg",@"http://collider.com/wp-content/uploads/blake-lively-image1-600x450.jpg", @"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b.jpg", @"http://farm4.static.flickr.com/3364/3338617424_7ff836d55f.jpg", @"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b.jpg",@"http://farm4.static.flickr.com/3364/3338617424_7ff836d55f.jpg", @"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b.jpg",@"http://cdn.thegloss.com/files/2011/12/blake-lively.jpg",@"http://3.bp.blogspot.com/_hN-RNLUCt5Q/TRDnhDvVMaI/AAAAAAAACMc/y82FrlD6H04/s1600/orange+smile+cg+girl+by+Ruoxing+Zhang.jpg",@"http://img5.pcpop.com/bizhi/big/10/179/150/10179150.jpg" ,@"http://img5.pcpop.com/bizhi/big/10/066/765/10066765.jpg",@"http://img5.pcpop.com/bizhi/big/10/179/145/10179145.jpg",@"http://img5.pcpop.com/bizhi/big/10/179/156/10179156.jpg" ,@"http://img5.pcpop.com/bizhi/big/10/173/640/10173640.jpg", @"http://img5.pcpop.com/bizhi/big/10/173/630/10173630.jpg",@"http://img5.pcpop.com/bizhi/big/10/049/877/10049877.jpg", @"http://img5.pcpop.com/bizhi/big/10/059/483/10059483.jpg", @"http://img5.pcpop.com/bizhi/big/10/131/155/10131155.jpg", @"http://img5.pcpop.com/bizhi/big/10/053/515/10053515.jpg", nil];
        
        [self.detailViewController initWithURLArray:arryURLs];
        
//        NSMutableArray *arryImages = [NSMutableArray array];
//        for (NSString* strURL in arryURLs) {
//            [arryImages addObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:strURL]]]];
//        }
//        [self.detailViewController initWithImageArray:arryImages];
    }
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}



@end
