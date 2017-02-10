//
//  GPNetworkingManager.m
//  GenyzPay
//
//  Created by Roman Bigun on 3/21/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import "GPNetworkingManager.h"
#import <AFNetworking/AFNetworking.h>
#import "GPDonor+Runtime.h"

@implementation GPNetworkingManager

@synthesize manager = _manager;

+(GPNetworkingManager*)sharedInstance
{
    static GPNetworkingManager * _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        
        _sharedInstance = [[GPNetworkingManager alloc] init];
        
    });
    return _sharedInstance;
}
-(id)init
{
    self = [super init];
    if(self)
    {
        _manager = [[AFHTTPRequestOperationManager alloc] init];
        
    }
    return self;
    
}
-(BOOL)respondWithError:(NSDictionary*)res
{
   
//        [[[UIAlertView alloc] initWithTitle:@"Server"
//                              message:res[@"message"]
//                              delegate:nil
//                              cancelButtonTitle:@"Ok"
//                              otherButtonTitles:nil, nil]
//         show];
    
    return [res[@"success"] boolValue];

}
-(RACSignal *)POST:(NSDictionary *)params apiPostfix:(NSString *)postfixApi{


    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber)
    {
        NSLog(@"%@",[NSString stringWithFormat:@"%@%@",kUrlMainSeerverPath,postfixApi]);
        [self.manager.requestSerializer setValue:[[GPDonor currentDonor] token] forHTTPHeaderField:kObjectKeyRestToken];
        [[GPNetworkingManager sharedInstance].manager POST:[NSString stringWithFormat:@"%@%@",kUrlMainSeerverPath,postfixApi]
                                               parameters:params
                                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSLog(@"Server [Post] response\n%@",(NSDictionary*)responseObject);
             if([self respondWithError:(NSDictionary*)responseObject]==NO){
               
             }
             [subscriber sendNext:(NSDictionary*)responseObject];
             [subscriber sendCompleted];
             
         }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             NSLog(@"Error : %@",error.description);
             [subscriber sendError:error];
             
         }];
        
        return nil;
        
    }] ;

}
-(RACSignal *) GET:(NSDictionary *)params apiPostfix:(NSString *)postfixApi
{
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"TOKEN: %@",[[GPDonor currentDonor] token]);
        [self.manager.requestSerializer setValue:[[GPDonor currentDonor] token] forHTTPHeaderField:kObjectKeyRestToken];
        [self.manager GET:[NSString stringWithFormat:@"%@%@",kUrlMainSeerverPath,postfixApi]
                                               parameters:params
                                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
                 NSLog(@"Server response\n%@",(NSDictionary*)responseObject);
                 if([self respondWithError:(NSDictionary*)responseObject]==NO){
                     return;
                 }
                 [subscriber sendNext:responseObject[@"data"]];
                 [subscriber sendCompleted];
             
         }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             NSLog(@"Error : %@",error.description);
             [subscriber sendError:error];
             
         }];
        
        return nil;
        
    }] ;
    
}
-(RACSignal *)getProfile {
    return [self GET:nil apiPostfix:kPostfixBackendUserProfile];
}
-(RACSignal *)setFavorites:(NSDictionary *)params{
    return [self POST:params apiPostfix:kPostfixBackendSetFavourite];
    
}
-(RACSignal *)loginWithParams:(NSDictionary *)params{
    return [self POST:params apiPostfix:kPostfixBackendLogin];
    
}
-(RACSignal *)registerWithParams:(NSDictionary *)params{
    return [self POST:params apiPostfix:kPostfixBackendRegister];
    
}
-(RACSignal *)getRecipientProfile:(NSDictionary *)params{
    return [self GET:params apiPostfix:kPostfixBackendGetRecipientById];
    
}
-(RACSignal *)getRecipients:(NSDictionary *)params
{
   return [self GET:params apiPostfix:kPostfixBackendGetRecipientsList];
  
}
-(RACSignal *)getRecipientsFavoritesOnly:(NSDictionary *)params
{
    return [self GET:params apiPostfix:kPostfixBackendGetFavourite];
    
}
-(RACSignal *)getReccuringPayments:(NSDictionary *)params
{
    return [self GET:params apiPostfix:kPostfixBackendGetReccuringPayments];
    
}
-(RACSignal *)createNewCard:(NSDictionary *)params{
    return [self POST:params apiPostfix:kPostfixBackendMakeNewCard];
    
}
-(RACSignal *)makePayment:(NSDictionary *)params{
    return [self POST:params apiPostfix:kPostfixBackendMakePayment];
    
}

@end
