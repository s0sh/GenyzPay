//
//  RecipientViewModel.m
//  GenyzPay
//
//  Created by Roman Bigun on 3/22/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import "RecipientViewModel.h"
#import "GPNetworkingManager.h"
#import "GPLocationSingleton.h"
@implementation RecipientViewModel
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}
-(NSDictionary*)createParams
{
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSString stringWithFormat:@"%f",[[GPLocationSingleton sharedManager] getLocation].coordinate.latitude],
            kObjectKeyLatitude,
            [NSString stringWithFormat:@"%f",[[GPLocationSingleton sharedManager] getLocation].coordinate.longitude],
            kObjectKeyLongitude,
            @"100000",
            kObjectKeyDistance,
            @"5",
            kObjectKeyPaginationLimit,
            nil];
    
}
-(void)refreshData
{
    
    __weak __typeof(self)weakSelf = self;
    if(!self.recipientsArray)
        self.recipientsArray = [[NSArray alloc] init];
    
    RACSignal *getDataSignal = [[GPNetworkingManager sharedInstance] getRecipients:[self createParams]];
    [getDataSignal subscribeNext:^(NSArray *x) {
        
        weakSelf.recipientsArray = x;
        NSLog(@"Recipoients :\n%@",x);
        
    } completed:^{
        
        
    }];
    
    
}

-(void)refreshDataWithFavoritesOnly
{
    
    __weak __typeof(self)weakSelf = self;
    if(!self.recipientsArray)
        self.recipientsArray = [[NSArray alloc] init];
    
    RACSignal *getDataSignal = [[GPNetworkingManager sharedInstance] getRecipientsFavoritesOnly:[self createParams]];
    [getDataSignal subscribeNext:^(NSArray *x) {
        
        weakSelf.recipientsArray = x;
        NSLog(@"Recipoients :\n%@",x);
        
    } completed:^{
        
        
    }];
    
    
}


- (void)initialize {
    
    self.compaginesArray = [[NSArray alloc] init];
    self.recipientsArray = [[NSArray alloc] init];
    
    
    
}
@end
