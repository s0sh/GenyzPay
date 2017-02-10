//
//  RegisterViewModel.m
//  GenyzPay
//
//  Created by Roman Bigun on 3/21/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import "RegisterViewModel.h"

static const NSString *termsConst = @"Terms and conditions of use";

@implementation RegisterViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

-(void)makeTermsTextUnderlined
{
    
    super.underlinedTermsText = [[NSMutableAttributedString alloc] initWithString:termsConst];
    
    [super.underlinedTermsText addAttribute:(NSString*)kCTUnderlineStyleAttributeName
                                 value:[NSNumber numberWithInt:kCTUnderlineStyleSingle]
                                 range:(NSRange){0,[super.underlinedTermsText length]}];
    
    super.underlinedTextColor = loginUnderlinedTextColor;
    
}

- (void)initialize {

    [super initialize];
    
    RACSignal *validNameSignal = [RACObserve(self, nameText) map:^id(NSString *text)    { return @(text.length > 3); }];
    [validNameSignal subscribeNext:^(id x) {
        
    }];
    RACSignal *validPasswordSignal = [RACObserve(self, passText) map:^id(NSString *text) { return @(text.length > 3); }];
    [validPasswordSignal subscribeNext:^(id x) {
        
    }];
    RACSignal *validPhoneSignal = [RACObserve(self, phoneText) map:^id(NSString *text)   { return @(text.length > 8 ); }];
    [validPhoneSignal subscribeNext:^(id x) {
            
     }];
    super.signUpActiveSignal =
    [RACSignal combineLatest:@[validNameSignal, validPasswordSignal, validPhoneSignal]
                      reduce:^id(NSNumber *usernameValid, NSNumber *passwordValid, NSNumber *phoneValid) {
                          return @([usernameValid boolValue] && [passwordValid boolValue] && [phoneValid boolValue]);
                          
                      }];
    
}
-(RACSignal *)registerWithParams:(NSDictionary *)params
{
    
    return [[GPNetworkingManager sharedInstance] registerWithParams:params];
    
    
}


@end
