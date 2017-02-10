//
//  GPLocationSingleton.h
//  GP
//
//  Created by Roman Bigun on 06.04.16.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GPLocationSingleton : NSObject

@property (nonatomic,strong) CLLocation *userLocation;

+ (instancetype)sharedManager;

-(void)initLocationManager;

-(CLLocation*)getLocation;

-(NSNumber *)getDistanceFromUserToLong:(NSNumber*)lon andLng:(NSNumber*)lng;

@end
