//
//  MenuCell.m
//  GenyzPay
//
//  Created by Roman Bigun on 3/15/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import "RecipientCell.h"
#import "GPNetworkingManager.h"
#import <ReactiveCocoa.h>

@implementation RecipientCell


#define isFavouriteImagesForButton [NSArray arrayWithObjects:@"ic_star_unfav_list",@"ic_star_fav_list",nil]

@synthesize curRecipient = _curRecipient;
-(NSDictionary*)generateParams
{

    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSString stringWithFormat:@"%@",self.curRecipient.rId],@"id",
            [NSString stringWithFormat:@"%d",!self.curRecipient.isFavorite],@"isFavorite",nil];
    

}
-(void)configureCellWithData:(Recipient *)recipient
{
    self.curRecipient = [[Recipient alloc] init];
    self.curRecipient = recipient;
    self.recipientName.text = recipient.recipientName;
    self.recipientAddress.text = recipient.recipientAddress;
    
    [self.favBtn setImage:[UIImage imageNamed:isFavouriteImagesForButton[!recipient.isFavorite]] forState:UIControlStateNormal];
}
@end
