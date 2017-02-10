//
//  LoginViewModel.h
//  GenyzPay
//
//  Created by Roman Bigun on 3/16/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "LoginVMServiseProtocol.h"
#import "GPDonor.h"
#import <CoreText/CoreText.h>
#import "GPNetworkingManager.h"
#import "GPDonor+Runtime.h"
#import "AppDelegate.h"
#define loginUnderlinedTextColor [UIColor colorWithRed:179.f/255.f green:218.f/255.f blue:255.f/255.f alpha:1]
#define checkBoxImages [NSArray arrayWithObjects:@"ic_checkbox",@"ic_check_checked",nil]
@interface LoginViewModel : NSObject
@property (strong, nonatomic) RACCommand *executeLogin;
@property (strong, nonatomic) RACCommand *executeRemember;
@property (strong, nonatomic) RACSignal * signUpActiveSignal;
@property (nonatomic, weak) id<LoginVMServiseProtocol> services;
@property (strong, nonatomic) NSString *passText;
@property (strong, nonatomic) NSString *nameText;
@property (strong, nonatomic) NSString *phoneText;
@property (strong, nonatomic) UIImageView *checkbox;
@property (strong, nonatomic) __block NSDictionary *dataToReturn;
@property (strong, nonatomic) UIColor *underlinedTextColor;
@property (strong, nonatomic) NSMutableAttributedString *underlinedTermsText;
-(RACSignal *)login;
- (void)initialize;
@end
