//
//  CardInfoViewModel.h
//  GenyzPay
//
//  Created by Roman Bigun on 5/18/16.
//  Copyright © 2016 Erminesoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>
@interface CardInfoViewModel : NSObject
@property (retain, nonatomic) NSString *cardNumberStr;
@property (retain, nonatomic) NSString *expirationDateStr;
@property (retain, nonatomic) NSDate *expirationDate;
@property (retain, nonatomic) NSString *nameOnCardStr;
@property (retain, nonatomic) NSString *addressStr;
@property (retain, nonatomic) NSString *stateStr;
@property (retain, nonatomic) NSString *zipCodeStr;
@property (retain, nonatomic) NSString *securityCodeStr;
@end
