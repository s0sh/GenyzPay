//
//  RecipientViewModel.h
//  GenyzPay
//
//  Created by Roman Bigun on 3/22/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Recipient.h"
@interface RecipientViewModel : Recipient
-(void)refreshData;
-(void)refreshDataWithFavoritesOnly;
@property(nonatomic,strong)NSArray *recipientsArray;
@end
