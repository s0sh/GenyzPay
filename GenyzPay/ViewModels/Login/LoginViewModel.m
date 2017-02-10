//
//  LoginViewModel.m
//  GenyzPay
//
//  Created by Roman Bigun on 3/16/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import "LoginViewModel.h"

static const NSString *termsConst = @"Forgot password?";


@implementation LoginViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

-(void)makeTermsTextUnderlined
{

    _underlinedTermsText = [[NSMutableAttributedString alloc] initWithString:termsConst];

    [_underlinedTermsText addAttribute:(NSString*)kCTUnderlineStyleAttributeName
                      value:[NSNumber numberWithInt:kCTUnderlineStyleSingle]
                                 range:(NSRange){0,[_underlinedTermsText length]}];
    
    _underlinedTextColor =  loginUnderlinedTextColor;

}
-(void)initInstanceVars
{

    _dataToReturn = [NSDictionary new];

}
- (void)initialize {
    
    _dataToReturn = [NSDictionary new];
    [self makeTermsTextUnderlined];
    
    RACSignal *validNameSignal = [RACObserve(self, nameText)
                                  map:^id(NSString *text)
    {
        NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"_-.abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"] invertedSet];
        
        BOOL containsForbiddenCharacters = [text rangeOfCharacterFromSet:set].location != NSNotFound;
        
        // ! uncomment to disable proper validation
        
        return @(text.length >= 5 && text.length <= 20 && !containsForbiddenCharacters);
        //return @(YES);
        
    }];
    [validNameSignal subscribeNext:^(id x) {
       
    }];
    RACSignal *validPasswordSignal = [RACObserve(self, passText) map:^id(NSString *text)
    {
        NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"_-.abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"] invertedSet];
        
        BOOL containsForbiddenCharacters = [text rangeOfCharacterFromSet:set].location != NSNotFound;
        
        // ! uncomment to disable proper validation
        
        return @(text.length >= 8 && text.length <= 18 && !containsForbiddenCharacters);
        //return @(YES);
    }];
    [validPasswordSignal subscribeNext:^(id x) {
      
    }];
    
    _signUpActiveSignal =
    [RACSignal combineLatest:@[validNameSignal, validPasswordSignal]
                      reduce:^id(NSNumber *usernameValid, NSNumber *passwordValid) {
                          return @([usernameValid boolValue] && [passwordValid boolValue]);
                          
                      }];
    
    
}

@end
