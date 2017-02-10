//
//  GPReccuringPaymentViewModel.m
//  GenyzPay
//
//  Created by Roman Runner on 5/30/16.
//  Copyright © 2016 Erminesoft. All rights reserved.
//

#import "GPReccuringPaymentViewModel.h"

@implementation GPReccuringPaymentViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}
- (void)initialize {
    
    self.paymentsArray = [[NSArray alloc] init];
    
    
}
-(NSDictionary*)createParams
{
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"10",
            kObjectKeyPaginationLimit,
            nil];
    
}

-(void)refreshData
{
    self.paymentsArray = nil;
    
    if(!self.paymentsArray)
        self.paymentsArray = [[NSArray alloc] init];
    
    RACSignal *getDataSignal = [[GPNetworkingManager sharedInstance] getReccuringPayments:[self createParams]];
    @weakify(self)
    [getDataSignal subscribeNext:^(NSArray *x) {
        @strongify(self)
        self.paymentsArray = x;
        NSLog(@"Payments list :\n%@",x);
        
    } completed:^{
        
        
    }];
    
    
}
@end
