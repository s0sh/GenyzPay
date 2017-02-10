//
//  RegisterViewModel.h
//  GenyzPay
//
//  Created by Roman Bigun on 3/21/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import "LoginViewModel.h"


@interface RegisterViewModel : LoginViewModel
-(RACSignal *)registerWithParams:(NSDictionary *)params;
@end
