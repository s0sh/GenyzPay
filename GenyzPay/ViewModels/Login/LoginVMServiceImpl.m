//
//  LoginVMServiceImpl.m
//  GenyzPay
//
//  Created by Roman Bigun on 3/17/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import "LoginVMServiceImpl.h"
#import "LoginProtocolImpl.h"

@interface LoginVMServiceImpl ()

@property (strong, nonatomic) LoginProtocolImpl *loginService;

@end

@implementation LoginVMServiceImpl
-(instancetype)init{
    if(self == [super init]){
    _loginService = [LoginProtocolImpl new];
    }
    return self;

}
-(id<LoginProtocol>)getLoginService{
    return self.loginService;
}
@end
