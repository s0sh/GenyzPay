//
//  RecipientsListViewController.m
//  GenyzPay
//
//  Created by admin on 05.05.16.
//  Copyright © 2016 n. All rights reserved.
//

#import "RecipientsListViewController.h"
#import "SWRevealViewController.h"
#import "RecipientCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "Recipient.h"
#import "MBProgressHUD.h"
#import "GPLocationSingleton.h"
#import "UIView+RoudedCorners.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "GPAnnotationButton.h"
#import "GPInformationPinBanner.h"
#import "RecipientDetails.h"


@interface RecipientsListViewController ()

@property (weak, nonatomic) IBOutlet UIButton *favButton;

@property (assign, nonatomic) BOOL showOnlyFavoriteRecipients;
@property (weak, nonatomic) IBOutlet UILabel *youHaveNoFavoritesLabel;

// remove this flag and rewrite related logic after will be known what causing subscribeNext calling twice
@property (assign, nonatomic) BOOL subscribeNextAlreadyWasCalled;

@end

@implementation RecipientsListViewController

@synthesize segment = _segment;
@synthesize recipientTable = _recipientTable;
@synthesize refreshControl = _refreshControl;

-(void)initModels
{
    __weak __typeof(self)weakSelf = self;
    
    self.viewModel = [[RecipientViewModel alloc] init];
    
    [self refreshTable];
    
    self.curLocation = [[GPLocationSingleton sharedManager] getLocation];
    
    RACSignal *rc = RACObserve(self.viewModel, recipientsArray);
    
    
    [rc subscribeNext:^(NSArray *x) {
        
        if(!weakSelf.subscribeNextAlreadyWasCalled)
        {
            if (weakSelf.showOnlyFavoriteRecipients && !x.count) {
                
                weakSelf.youHaveNoFavoritesLabel.hidden = NO;
            } else {
                
                weakSelf.youHaveNoFavoritesLabel.hidden = YES;
            }
            
            weakSelf.subscribeNextAlreadyWasCalled = YES;
        }
        
        weakSelf.recipients = [x mutableCopy];
        [weakSelf.recipientTable reloadData];
        [weakSelf setRadius];
        [weakSelf putAnnotations];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
    } completed:^{
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
    }];
    
    RACSignal *locSig = RACObserve([GPLocationSingleton sharedManager], userLocation);
    [locSig subscribeNext:^(CLLocation *x) {
        
        weakSelf.curLocation = x;
        weakSelf.mainMap.region = MKCoordinateRegionMakeWithDistance(self.curLocation.coordinate, 250, 250);
        [weakSelf setRadius];
        
    } completed:^{
        
        
        
    }];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self initModels];
    
    bannerPlaced = NO;
    self.mainMap.delegate = self;
    [self.mainMap setShowsUserLocation:YES];
    _mainMap.region = MKCoordinateRegionMakeWithDistance(self.curLocation.coordinate, 250, 250);
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        
        return nil;
    }
    
    static NSString * customAnnotationIdentifier = @"annotationViewIdentifier";
    GPAnnotation *currentAnnotation = (GPAnnotation *)annotation;
    __block MKAnnotationView * annotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:customAnnotationIdentifier];
    
    if (!annotationView) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:currentAnnotation reuseIdentifier:nil];
    }
    
    
    annotationView.frame = CGRectMake(annotationView.frame.origin.x, annotationView.frame.origin.y, 60, 60);
    
    
    UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 60, 60)];
    avatar.clipsToBounds = YES;
    [avatar sd_setImageWithURL:[NSURL URLWithString:[currentAnnotation imageURLString]]
                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         
         
     }];
    
    
    [annotationView addSubview:avatar];
    [avatar roundCorners];
    [annotationView roundCorners];
    return annotationView;
}

-(void)setRadius
{
    
    double miles = 5.0;
    double scalingFactor = ABS( (cos(2 * M_PI * _curLocation.coordinate.latitude / 360.0) ));
    MKCoordinateSpan span;
    span.latitudeDelta = miles/69.0;
    span.longitudeDelta = miles/(scalingFactor * 69.0);
    MKCoordinateRegion region;
    region.span = span;
    region.center = _curLocation.coordinate;
    [_mainMap setRegion:region animated:YES];
    
}
-(void)removeBanners
{
    NSArray *banners = [self.mainMap subviews];
    for(UIView *v in banners){
        
        if([v isKindOfClass:[GPInformationPinBanner class]]){
            [(GPInformationPinBanner *)v removeFromSuperview];
        }
        
    }
    
}
-(void)removeAnnotations
{
    id userLocation = [self.mainMap userLocation];
    NSMutableArray *pins = [[NSMutableArray alloc] initWithArray:[self.mainMap annotations]];
    if ( userLocation != nil ) {
        [pins removeObject:userLocation]; // avoid removing user location off the map
    }
    
    [self.mainMap removeAnnotations:pins];
    
    pins = nil;
    
    
}
-(void)putAnnotations
{
    [self removeAnnotations];
    for ( int i=0; i<[self.recipients count]; i++)
    {
        CLLocationCoordinate2D coord;
        
        coord.latitude=[[NSString stringWithFormat:@"%@",self.recipients[i][kObjectKeyLocation][kObjectKeyLatitude]] floatValue];
        coord.longitude=[[NSString stringWithFormat:@"%@",self.recipients[i][kObjectKeyLocation][kObjectKeyLongitude]] floatValue];
        MKCoordinateRegion region1;
        region1.center=coord;
        region1.span.longitudeDelta=20;
        region1.span.latitudeDelta=20;
        [self.mainMap setRegion:region1 animated:YES];
        GPAnnotation *an = [[GPAnnotation alloc] initWithData:self.recipients[i]];
        an.coordinate = coord;
        
        an.title = self.recipients[i][kObjectKeyName];
        [self.mainMap addAnnotation:an];
        
    }
    
    
}
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    [mapView deselectAnnotation:view.annotation animated:YES];
    if(!bannerPlaced){
        GPAnnotation *anData = (GPAnnotation *)view.annotation;
        GPInformationPinBanner *banner = [[GPInformationPinBanner alloc] initWithFrame:CGRectMake(0, 0, 100, 70)];
        [banner updateData:anData.data coordinates:view andSuperview:mapView];
        [banner show];
    }
    else{
        [self removeBanners];
    }
    
    bannerPlaced =!bannerPlaced;
    
    
}
-(void)initRefresher
{
    _refreshControl = [[UIRefreshControl alloc] init];
    [self.recipientTable addSubview:_refreshControl];
    [_refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
}
- (void)refreshTable {
   
    if (self.showOnlyFavoriteRecipients) {
        
        [self.viewModel refreshDataWithFavoritesOnly];
    }
    else
    {
        [self.viewModel refreshData];
    }
    
    [_refreshControl endRefreshing];
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.subscribeNextAlreadyWasCalled = NO;
    
    [self showMap:NO];
    
    _recipientTable.delegate = self;
    _recipientTable.dataSource = self;
    _recipients = [[NSMutableArray alloc] init];
    
    self.showOnlyFavoriteRecipients = NO;
    
    [self initRefresher];
}
- (IBAction)decodeButton:(id)sender {
    _segment.selectedSegmentIndex == 0?[self showMap:NO]:[self showMap:YES];
    
}
-(void)showMap:(BOOL)show
{
    
    [UIView animateWithDuration:.4 animations:^{
        
        [UIView animateWithDuration:.4 animations:^{
            
            self.recipientTable.hidden = show;
            self.mainMap.hidden = !show;
        } completion:^(BOOL finished) {
            
        }];
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _recipients.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"recipientCell";
    
    RecipientCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[RecipientCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    Recipient *object = [[Recipient alloc] initWithData:_recipients[indexPath.row]];
    cell.curRecipient = object;
    [cell configureCellWithData:object];
    
    return cell;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    if([sender isKindOfClass:[UITableViewCell class]]){
        
        RecipientCell *obj = (RecipientCell*)sender;
        RecipientDetails *rd = [segue destinationViewController];
        rd.objId = obj.curRecipient.rId;
    }
    
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (IBAction)favoritesButtonClick:(id)sender {
    
    self.showOnlyFavoriteRecipients = !self.showOnlyFavoriteRecipients;
    
    if (self.showOnlyFavoriteRecipients) {
        
        [self.favButton setImage:[UIImage imageNamed:@"ic_star_unfav_list"] forState:UIControlStateNormal];
    }
    else {
        [self.favButton setImage:[UIImage imageNamed:@"ic_star_fav_list"] forState:UIControlStateNormal];
    }
    
    [self initModels];
}


@end
