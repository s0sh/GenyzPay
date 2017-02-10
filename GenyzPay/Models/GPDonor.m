//
//  GPDonor.m
//  GenyzPay
//
//  Created by Roman Bigun on 3/18/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import "GPDonor.h"

@implementation GPDonor


+(GPDonor*)currentDonor
{
    static GPDonor * _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        
        _sharedInstance = [[GPDonor alloc] init];
        
    });
    return _sharedInstance;
}
-(id)init
{
    self = [super init];
    if(self)
    {
    
        
    }
    return self;

}
-(void)initWithData:(NSDictionary *)data
{
    
    self.user_id = data[@"data"][kObjectKeyId];
    self.name = data[@"data"][kObjectKeyFirstName];
    self.phone = data[@"data"][kObjectKeyPhone];
    self.email = data[@"data"][kObjectKeyEmail];
    _token = data[kObjectKeyAccessToken];
    self.address = data[@"data"][kObjectKeyAddress];
    self.country = data[@"data"][kObjectKeyCity];
    self.lastname = data[@"data"][kObjectKeyLastName];
    self.img = data[@"data"][kObjectKeyAvatarURL];
    self.dob = data[@"data"][kObjectKeyDOB];
      

}

@end
