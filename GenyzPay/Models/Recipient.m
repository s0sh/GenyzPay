//
//  Recipient.m
//  GenyzPay
//
//  Created by Roman Bigun on 3/24/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import "Recipient.h"

@implementation Recipient

@synthesize rId,recipientAddress,recipientAvatarUrl,recipientContacts,recipientDescription,recipientName,compaginesArray,isFavorite,isRegistered;


-(id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if(self)
    {
        rId = data[kObjectKeyJustId];
        recipientAddress = data[kObjectKeyAddress];
        recipientAvatarUrl = data[kObjectKeyAvatarURL];
        recipientContacts = data[kObjectKeyEmail];
        recipientDescription = data[kObjectKeyDescription];
        //recipientName = data[kObjectKeyName];
  
        recipientName = data[kObjectKeySimpleName];
        
        compaginesArray = [data isKindOfClass:[NSArray class]]?data[kObjectKeyCompagines]:nil;
        isFavorite = [data[kObjectKeyIsFavorite] boolValue];
        isRegistered = [data[kObjectKeyRecRegistered] boolValue];
        
    }
    return self;
    
}

@end
