//
//  ProfileVModel.m
//  GenyzPay
//
//  Created by Roman Bigun on 4/5/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import "ProfileVModel.h"
#import "GPNetworkingManager.h"
#import <ReactiveCocoa.h>
#import "GPDonor+Runtime.h"
@implementation ProfileVModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}
/*!
 * @discussion Fill object getting data from user defaults
 * This data was stored while login/register action
 */
-(void)tempolize
{
    __weak __typeof(self)weakSelf = self;
    [[GPDonor currentDonor] populateObjectsFromMemory];
    weakSelf.nameTxt = [GPDonor currentDonor].name;
    weakSelf.lastNameTxt = [GPDonor currentDonor].lastname ;
    weakSelf.addressTxt = [GPDonor currentDonor].address;
    weakSelf.emailTxt = [GPDonor currentDonor].email;
    weakSelf.phoneTxt = [GPDonor currentDonor].phone;
    weakSelf.countryTxt = [GPDonor currentDonor].country;
    weakSelf.dobTxt = [GPDonor currentDonor].dob;
    weakSelf.avatarUrl = [GPDonor currentDonor].img;

}
- (void)initialize {

    __weak __typeof(self)weakSelf = self;
    
    [self tempolize];
    
    RACSignal *getDataSignal = [[GPNetworkingManager sharedInstance] getProfile];
    
    [getDataSignal subscribeNext:^(NSDictionary *x) {
        
        
        weakSelf.nameTxt = [GPDonor currentDonor].name;
        weakSelf.lastNameTxt = [GPDonor currentDonor].lastname ;
        weakSelf.addressTxt = [GPDonor currentDonor].address;
        weakSelf.emailTxt = [GPDonor currentDonor].email;
        weakSelf.phoneTxt = [GPDonor currentDonor].phone;
        weakSelf.countryTxt = [GPDonor currentDonor].country;
        weakSelf.dobTxt = [GPDonor currentDonor].dob;
        weakSelf.avatarUrl = [GPDonor currentDonor].img;
        
        
        NSLog(@"User\n%@",x);
        
    } completed:^{
                
        
    }];
   
}
@end
