//
//  CompaignCell.h
//  GenyzPay
//
//  Created by Roman Bigun on 3/24/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipientCell.h"
@interface CompaignCell : RecipientCell
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *address;
@property NSInteger _id;
-(void)configureCellWithData:(NSDictionary*)data;
@end
