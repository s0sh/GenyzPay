//
//  RecipientsListViewController.h
//  GenyzPay
//
//  Created by admin on 05.05.16.
//  Copyright © 2016 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipientViewModel.h"
#import "GPAnnotation.h"
@interface RecipientsListViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate>
{
    
    BOOL bannerPlaced;
}
- (IBAction)showMenu;
@property (weak, nonatomic) IBOutlet UISegmentedControl * segment;
@property (weak, nonatomic) CLLocation *curLocation;
@property (weak, nonatomic) IBOutlet MKMapView *mainMap;
@property (weak, nonatomic) IBOutlet UIView *baseViewForRoadway;
@property (weak, nonatomic) IBOutlet UITableView *recipientTable;
@property (strong, nonatomic) IBOutlet UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSMutableArray *recipients;
@property (strong, nonatomic) RecipientViewModel *viewModel;
@end
