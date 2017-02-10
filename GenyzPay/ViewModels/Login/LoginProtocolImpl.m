//
//  LoginProtocolImpl.m
//  GenyzPay
//
//  Created by Roman Bigun on 3/17/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import "LoginProtocolImpl.h"



@implementation LoginProtocolImpl

- (void)signInWithUsername:(NSString *)username password:(NSString *)password complete:(LoginSignInResponse)completeBlock{

    
       NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:username,@"login",password,@"password", nil];
    
    
    
   
    
}

@end
