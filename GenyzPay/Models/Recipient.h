//
//  Recipient.h
//  GenyzPay
//
//  Created by Roman Bigun on 3/24/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
@interface Recipient : NSObject
@property(nonatomic,strong)NSString *rId;
@property(nonatomic,strong)NSString *avatarUrl;
@property(nonatomic,strong)NSString *recipientName;
@property(nonatomic,strong)NSString *recipientAvatarUrl;
@property(nonatomic,strong)NSString *recipientDescription;
@property(nonatomic,strong)NSString *recipientContacts;
@property(nonatomic,strong)NSString *recipientAddress;
@property(nonatomic,strong)NSArray *compaginesArray;
@property(nonatomic,assign) BOOL isFavorite;
@property(nonatomic,assign) BOOL isRegistered;
-(id)initWithData:(NSDictionary *)data;
@end
