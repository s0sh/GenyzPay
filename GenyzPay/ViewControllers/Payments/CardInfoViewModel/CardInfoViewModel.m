//
//  CardInfoViewModel.m
//  GenyzPay
//
//  Created by Roman Bigun on 5/18/16.
//  Copyright © 2016 Erminesoft. All rights reserved.
//

#import "CardInfoViewModel.h"
#import "GPPaymentEngine.h"
@implementation CardInfoViewModel
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}
- (BOOL)isValidCard:(NSString *)cardNumber
{
       _cardNumberStr = cardNumber;
        [GPPaymentEngine currentPayment].creditCardNumber = _cardNumberStr;
    
    
    return @1;
}
-(void)initCardNumber
{
__weak __typeof(self)weakSelf = self;
    RACSignal *validNameSignal = [RACObserve(self, cardNumberStr)
                                  map:^id(NSString *text)
                                  {
                                      
                                      return @([weakSelf isValidCard:text]);
   
                                  }];
    [validNameSignal subscribeNext:^(id text) {
        NSLog(@"%@",text);
        
    }];

}
-(void)initExpirationDate
{
    
    RACSignal *validNameSignal = [RACObserve(self, expirationDateStr)
                                  map:^id(NSDate *date)
                                  {
                                     
                                      [GPPaymentEngine currentPayment].expirationDateAsDateObject = date;
                                      return date;
                                      
                                  }];
    [validNameSignal subscribeNext:^(id x) {
        
        
    }];
    
    
}
-(void)initNameOnCard
{
    
    RACSignal *validNameSignal = [RACObserve(self, nameOnCardStr)
                                  map:^id(NSString *text)
                                  {
                                      if(text.length<100){
                                      
                                          [GPPaymentEngine currentPayment].nameOnCard = text;
                                      
                                      }
                                      return @(text.length<100?YES:NO);
                                      
                                  }];
    [validNameSignal subscribeNext:^(id x) {
        
        
    }];
    
}
-(void)initAddress
{
    
    RACSignal *validNameSignal = [RACObserve(self, addressStr)
                                  map:^id(NSString *text)
                                  {
                                      
                                      if(text.length<300){
                                      
                                          [GPPaymentEngine currentPayment].billingAdderss = text;
                                          
                                      }
                                      return @(text.length<300?YES:NO);
                                      
                                  }];
    [validNameSignal subscribeNext:^(id x) {
        
        
    }];
    
}
-(void)initState
{
    
    RACSignal *validNameSignal = [RACObserve(self, stateStr)
                                  map:^id(NSString *text)
                                  {
                                      if(text.length<300){
                                          [GPPaymentEngine currentPayment].state = text;
                                      }
                                      return @(text.length<300?YES:NO);
                                      
                                  }];
    [validNameSignal subscribeNext:^(id x) {
        
        
    }];
    
}
-(void)initZip
{
    
    RACSignal *validNameSignal = [RACObserve(self, zipCodeStr)
                                  map:^id(NSString *text)
                                  {
                                      
                                      if(text.length<7){
                                      
                                          [GPPaymentEngine currentPayment].zipCode = text;
                                      }
                                      return @(text.length<7?YES:NO);
                                      
                                  }];
    [validNameSignal subscribeNext:^(id x) {
        
        
    }];
    
}
-(void)initSecurityCode
{
    
    RACSignal *validNameSignal = [RACObserve(self, securityCodeStr)
                                  map:^id(NSString *text)
                                  {
                                      NSScanner* scan = [NSScanner scannerWithString:text];
                                      int val;
                                      BOOL ret = [scan scanInt:&val] && [scan isAtEnd];
                                      if(ret){
                                      
                                          [GPPaymentEngine currentPayment].securityCode = text;
                                          
                                      }
                                      return [NSNumber numberWithBool:ret];
                                      
                                  }];
    [validNameSignal subscribeNext:^(id x) {
        
        
    }];
    
}
- (void)initialize {
    
    [self initCardNumber];
    [self initExpirationDate];
    [self initNameOnCard];
    [self initAddress];
    [self initState];
    [self initZip];
    [self initSecurityCode];
    
}
@end
