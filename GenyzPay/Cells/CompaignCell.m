//
//  CompaignCell.m
//  GenyzPay
//
//  Created by Roman Bigun on 3/24/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import "CompaignCell.h"

@implementation CompaignCell
@synthesize recipientName,recipientAddress,_id;
-(void)configureCellWithData:(NSDictionary*)data{

    self.recipientName.text = data[kObjectKeyName];
    self.recipientAddress.text = data[kObjectKeyAddress];
    self._id = [data[kObjectKeyId] integerValue];
    

}
@end
