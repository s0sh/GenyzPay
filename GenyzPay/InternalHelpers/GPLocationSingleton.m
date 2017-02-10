//
//  GPLocationSingleton.h
//  GP
//
//  Created by Roman Bigun on 06.04.16.
//
//

#import "GPLocationSingleton.h"

@interface GPLocationSingleton () <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}
@end

@implementation GPLocationSingleton


+ (instancetype)sharedManager
{
    static GPLocationSingleton *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        
    });
    return sharedManager;
}

-(void)initLocationManager
{
    self.userLocation = [[CLLocation alloc] init];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
}

-(CLLocation*)getLocation
{
    return self.userLocation;
}
-(NSNumber *)getDistanceFromUserToLong:(NSNumber*)lon andLng:(NSNumber*)lng
{
    CLLocation *destinationLocation = [[CLLocation alloc] initWithLatitude:[lon doubleValue] longitude:[lng doubleValue]];
    CLLocationDistance distance = [self.userLocation distanceFromLocation:destinationLocation] / 1609.344;
    return [NSNumber numberWithFloat:distance];
    
}
- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: {
            
        } break;
        case kCLAuthorizationStatusDenied: {
            
        } break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways: {
            [locationManager startUpdatingLocation]; //Will update location immediately
        } break;
        default:
            break;
    }
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    if(!self.userLocation){
    
        self.userLocation = [CLLocation new];
    }
    self.userLocation = newLocation;
    
    [locationManager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}

@end
