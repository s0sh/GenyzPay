//
//  GPNetworkingManager.h
//  GenyzPay
//
//  Created by Roman Bigun on 3/21/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager+RACSupport.h"
#import "Constants.h"
#define API [GPNetworkingManager sharedInstance]

@interface GPNetworkingManager : NSObject
@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;
+(GPNetworkingManager *)sharedInstance;
-(RACSignal *)getProfile;
-(RACSignal *)loginWithParams:(NSDictionary *)params;
-(RACSignal *)setFavorites:(NSDictionary *)params;
-(RACSignal *)getRecipients:(NSDictionary *)params;
-(RACSignal *)getRecipientsFavoritesOnly:(NSDictionary *)params;
-(RACSignal *)getReccuringPayments:(NSDictionary *)params;
-(RACSignal *)getRecipientProfile:(NSDictionary *)params;
-(RACSignal *)registerWithParams:(NSDictionary *)params;
-(RACSignal *)createNewCard:(NSDictionary *)params;
-(RACSignal *)makePayment:(NSDictionary *)params;
@end
