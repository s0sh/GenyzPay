//
//  AmountViewModel.m
//  GenyzPay
//
//  Created by Roman Bigun on 5/16/16.
//  Copyright © 2016 n. All rights reserved.
//

#import "AmountViewModel.h"
#import "GPPaymentEngine.h"
@implementation AmountViewModel
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}
- (void)initialize {
    
    
    
    RACSignal *validNameSignal = [RACObserve(self, otherAmountTxt)
                                  map:^id(NSString *text)
                                  {
                                     
                                      return @(text.length>0);
                                      
                                  }];
    [validNameSignal subscribeNext:^(id x) {

        
    }];
    
}
-(NSDictionary *)createParams:(NSString *)_id
{
    
    
    return [NSDictionary dictionaryWithObjectsAndKeys:_id,@"recipient_id", nil];
    
    
}
-(void)getDataForRecipientWithId:(NSString *)_id
{

    __weak __typeof(self)weakSelf = self;
    RACSignal *getDataSignal = [[GPNetworkingManager sharedInstance] getRecipientProfile:[self createParams:_id]];
    [getDataSignal subscribeNext:^(NSDictionary *x) {
        
        for(int i=0;i<[x[@"campaigns"] count];i++){
            if([[NSString stringWithFormat:@"%@",x[@"campaigns"][i][@"campaign_id"]] isEqualToString:[GPPaymentEngine currentPayment].compagineId]){
                weakSelf.recipientNameTxt = x[@"campaigns"][i][@"campaign_name"];
                [GPPaymentEngine currentPayment].recipientName = x[@"campaigns"][i][@"campaign_name"];
            }
        }
     
        
//        weakSelf.pAmount1Txt = x[kObjectKeyAmounts][0];
//        weakSelf.pAmount2Txt = x[kObjectKeyAmounts][1];
//        weakSelf.pAmount3Txt = x[kObjectKeyAmounts][2];
//        weakSelf.pAmount4Txt = x[kObjectKeyAmounts][3];
        
        weakSelf.pAmount1Txt = @"100$";
        weakSelf.pAmount2Txt = @"200$";
        weakSelf.pAmount3Txt = @"500$";
        weakSelf.pAmount4Txt = @"1000$";
        
        
        
    } completed:^{
        
        
    }];

    
}
@end
