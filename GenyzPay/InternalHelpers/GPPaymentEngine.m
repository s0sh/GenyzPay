//
//  GPPaymentEngine.m
//  GenyzPay
//
//  Created by Roman Bigun on 5/19/16.
//  Copyright © 2016 Erminesoft. All rights reserved.
//

#import "GPPaymentEngine.h"
@implementation GPPaymentEngine

@synthesize
cardId,
unonimuous,
selectedTag,
fee,
recipientName,
creditCardNumber,
securityCode,
state,
zipCode,
expirationDateAsDateObject,
paymentAmmount,
cvv,
billingAdderss;

+ (GPPaymentEngine *)currentPayment
{
    
    static GPPaymentEngine * _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[GPPaymentEngine alloc] init];
        
    });
    
    return _sharedInstance;
}

-(id)init
{
    
    
    self = [super init];
    if(self)
    {
        [RACObserve(self, fee) subscribeNext:^(NSString *x) {
            
            NSLog(@"%@",x);
            
        }];
        [RACObserve(self, compagineId) subscribeNext:^(NSString *x) {
            
            NSLog(@"%@",x);
            
        }];
        [RACObserve(self, recepienID) subscribeNext:^(NSString *x) {
            
            NSLog(@"%@",x);
            
        }];
        [RACObserve(self, storeCardDetails) subscribeNext:^(NSNumber *x) {
            
            NSLog(@"%@",x);
            
        }];
        [RACObserve(self, recipientName) subscribeNext:^(NSString *x) {
            
             NSLog(@"%@",x);
        }];
        [RACObserve(self, creditCardNumber) subscribeNext:^(NSString *x) {
            
             NSLog(@"%@",x);
        }];
        [RACObserve(self, securityCode) subscribeNext:^(NSString *x) {
            
             NSLog(@"%@",x);
        }];
        [RACObserve(self, state) subscribeNext:^(NSString *x) {
            
             NSLog(@"%@",x);
        }];
        [RACObserve(self, zipCode) subscribeNext:^(NSString *x) {
            
             NSLog(@"%@",x);
        }];
        [RACObserve(self, expirationDateAsDateObject) subscribeNext:^(NSDate *x) {
            
             NSLog(@"%@",x);
        }];
        [RACObserve(self, paymentAmmount) subscribeNext:^(NSString *x) {
            
            self.fee = [NSString stringWithFormat:@"%.2f",[x intValue]*0.02+30];
             NSLog(@"%@",x);
        }];
        [RACObserve(self, cvv) subscribeNext:^(NSString *x) {
            
             NSLog(@"%@",x);
        }];
        [RACObserve(self, billingAdderss) subscribeNext:^(NSString *x) {
            
             NSLog(@"%@",x);
        }];
        [RACObserve(self, nameOnCard) subscribeNext:^(NSString *x) {
            
            NSLog(@"%@",x);
        }];
        [RACObserve(self, unonimuous) subscribeNext:^(id x) {
            
            NSLog(@"%@",x);
        }];
        [RACObserve(self, otherPaymentAmount) subscribeNext:^(NSString * x) {
            
            NSLog(@"%@",x);
            
        }];
        
    }
    
    return self;
    
}
-(void)backgroundStorage{
}
-(void)restorePaymentInfo{
}
-(NSString*)makeTimeStamp{

    if(![self.expirationDateAsDateObject isKindOfClass:[NSString class]]){
       return [NSString stringWithFormat:@"%f",floor([self.expirationDateAsDateObject timeIntervalSince1970])];
    }
    return [NSString stringWithFormat:@"%f",floor([[NSDate date] timeIntervalSince1970])];

}
-(NSDictionary*)buildCard
{
    NSDictionary * d = [NSDictionary dictionaryWithObjectsAndKeys:self.creditCardNumber,kCardKeyCardNumber,self.securityCode,@"sCode",[self makeTimeStamp],@"expired",self.billingAdderss,@"address",self.state,@"state", self.zipCode,@"zipCode",self.nameOnCard,@"nameOnCard", nil];
    NSLog(@"%@",d);
    return d;

}
-(NSDictionary*)buildMakePaymentRequestParameters
{

    return [NSDictionary dictionaryWithObjectsAndKeys:@"USD",@"currency",self.paymentAmmount,@"amount",self.cardId,@"purseId",self.compagineId,@"campaignId",self.recepienID,@"recipientId", nil];
   
}
@end
