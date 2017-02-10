//
//  GPDonor.h
//  GenyzPay
//
//  Created by Roman Bigun on 3/18/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Constants.h"

@interface GPDonor : NSObject
-(void)initWithData:(NSDictionary *)data;
@property(nonatomic,strong)NSString *token;
@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *lastname;
@property(nonatomic,strong)NSString *dob;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *country;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *img;
+(GPDonor *)currentDonor;
@end
