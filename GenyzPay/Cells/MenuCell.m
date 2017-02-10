//
//  MenuCell.m
//  GenyzPay
//
//  Created by Roman Bigun on 3/15/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell
#define IMAGES_FOR_MENU [NSArray arrayWithObjects:@"ic_person",@"ic_recipient_list",@"ic_reccuring_payment",@"ic_trnsaction_history",@"ic_messages",@"ic_reminders",@"ic_faq",@"ic_settings",nil]
#define TITLES [NSArray arrayWithObjects:@"My profile",@"Recipients' list", @"Reccuring payments",@"Transaction history",@"Messages",@"Reminders",@"FAQ & Help",@"Settings",nil]

@synthesize menuImage = _menuImage;
@synthesize menuTitle = _menuTitle;

-(void)configureCellForIndex:(int)index
{
    _menuTitle.text = TITLES[index];
    _menuImage.image = [UIImage imageNamed:IMAGES_FOR_MENU[index]];

}
@end
