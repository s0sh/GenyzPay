//
//  LoginProtocol.h
//  GenyzPay
//
//  Created by Roman Bigun on 3/17/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#ifndef LoginProtocol_h
#define LoginProtocol_h


#endif /* LoginProtocol_h */

@import Foundation;
#import <ReactiveCocoa/ReactiveCocoa.h>

typedef void (^LoginSignInResponse)(BOOL);
@protocol LoginProtocol <NSObject>
- (RACSignal *)signInWithUsername:(NSString *)username password:(NSString *)password complete:(LoginSignInResponse)completeBlock;
@end