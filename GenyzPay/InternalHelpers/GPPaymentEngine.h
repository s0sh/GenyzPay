//
//  GPPaymentEngine.h
//  GenyzPay
//
//  Created by Roman Bigun on 5/19/16.
//  Copyright © 2016 Erminesoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import <ReactiveCocoa.h>
@interface GPPaymentEngine : NSObject
@property int selectedTag;
@property BOOL unonimuous;
@property BOOL storeCardDetails;
@property(nonatomic,strong)NSString *recipientName;
@property(nonatomic,strong)NSString *otherPaymentAmount;
@property(nonatomic,strong)NSString *recepienID;
@property(nonatomic,strong)NSString *compagineId;;
@property(nonatomic,strong)NSString *cardId;
@property(nonatomic,strong)NSString *creditCardNumber;
@property(nonatomic,strong)NSString *billingAdderss;
@property(nonatomic,strong)NSString *cvv;
@property(nonatomic,strong)NSString *paymentAmmount;
@property(nonatomic,strong)NSString *securityCode;
@property(nonatomic,strong)NSDate *expirationDateAsDateObject;
@property(nonatomic,strong)NSString *state;
@property(nonatomic,strong)NSString *zipCode;
@property(nonatomic,strong)NSString *fee;
@property(nonatomic,strong)NSString *nameOnCard;
+ (GPPaymentEngine *)currentPayment;
-(NSDictionary*)buildCard;
-(NSDictionary*)buildMakePaymentRequestParameters;
@end
