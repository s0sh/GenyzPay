//
//  RecipientDetailViewModel.h
//  GenyzPay
//
//  Created by Roman Bigun on 4/6/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import "Recipient.h"

@interface RecipientDetailViewModel : Recipient
@property(nonatomic,retain)NSDictionary *recipientData;
@property BOOL isFavorites;
-(void)refreshDataWithId:(NSString *)_id;
-(void)addToFavorite;
@end
