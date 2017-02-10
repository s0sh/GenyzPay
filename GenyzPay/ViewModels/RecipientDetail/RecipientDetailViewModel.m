//
//  RecipientDetailViewModel.m
//  GenyzPay
//
//  Created by Roman Bigun on 4/6/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import "RecipientDetailViewModel.h"
#import "GPNetworkingManager.h"
#import "GPPaymentEngine.h"
@implementation RecipientDetailViewModel


- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}
-(NSDictionary *)createParams:(NSString *)_id
{
    
    return [NSDictionary dictionaryWithObjectsAndKeys:_id,@"recipient_id", nil];
    

}
-(void)refreshDataWithId:(NSString *)_id
{
    [GPPaymentEngine currentPayment].recepienID = _id;
    
    
    @weakify(self);
    RACSignal *getDataSignal = [[GPNetworkingManager sharedInstance] getRecipientProfile:[self createParams:_id]];
    [getDataSignal subscribeNext:^(NSDictionary *x) {
        
        @strongify(self)
        self.compaginesArray = x[kObjectKeyCompagines];
        self.recipientContacts = x[kObjectKeyEmail];
        //weakSelf.recipientName = x[kObjectKeyName];
        self.recipientName = x[kObjectKeySimpleName];
        self.isFavorites = [x[kObjectKeyIsFavorite] boolValue];
        self.recipientDescription = x[kObjectKeyDescription];
        self.recipientContacts = x[kObjectKeyEmail];
        self.recipientAvatarUrl = x[kObjectKeyAvatarURL];
        self.recipientAddress = x[kObjectKeyAddress];
        self.rId = x[kObjectKeyJustId];
        
    } completed:^{
        
        
    }];
    
    
}
-(NSDictionary *)generateParams
{

    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSString stringWithFormat:@"%@",self.rId],kObjectKeyRecipientId,
            [NSString stringWithFormat:@"%d",self.isFavorites],@"favorite",nil];

}
-(void)addToFavorite
{
    self.isFavorites=!self.isFavorites;
    RACSignal *getDataSignal = [[GPNetworkingManager sharedInstance] setFavorites:[self generateParams]];
    @weakify(self)
    [getDataSignal subscribeNext:^(NSDictionary *x)
    {
        if(x.count>0 && [x[@"error"] integerValue]==0){
            
        }
        @strongify(self)
        
        NSLog(@"%i",self.isFavorites);
       
    } completed:^{
        
        
    }];

}
- (void)initialize {
    
    self.recipientData = [[NSDictionary alloc] init];
    [[RACObserve(self, isFavorites) filter:^(NSNumber *detached) {
        return [detached boolValue];
    }] subscribeNext:^(id x) {
        
    }];
    
    
}
@end

