//
//  LoginVMServiseProtocol.h
//  GenyzPay
//
//  Created by Roman Bigun on 3/17/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#ifndef LoginVMServiseProtocol_h
#define LoginVMServiseProtocol_h


#endif /* LoginVMServiseProtocol_h */

@import Foundation;
#import "LoginProtocol.h"

@protocol LoginVMServiseProtocol <NSObject>
-(id<LoginProtocol>)getLoginService;

@end