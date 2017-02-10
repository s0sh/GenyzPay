//
//  MenuCell.h
//  GenyzPay
//
//  Created by Roman Bigun on 3/15/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipient.h"
@interface RecipientCell : UITableViewCell
@property(nonatomic,strong)NSString *rId;
@property(nonatomic,strong)NSString *avatarUrl;
@property(nonatomic,strong)IBOutlet UILabel  *recipientName;
@property(nonatomic,strong)IBOutlet UIButton* favBtn;
@property(nonatomic,strong)NSString *recipientAvatarUrl;
@property(nonatomic,strong)NSString *recipientDescription;
@property(nonatomic,strong)NSString *recipientContacts;
@property(nonatomic,strong)IBOutlet UILabel  *recipientAddress;
@property(nonatomic,strong)NSArray *compaginesArray;
@property(nonatomic,assign)BOOL isFavorite;
@property(nonatomic,strong)Recipient *curRecipient;
-(void)configureCellWithData:(Recipient *)data;
@end
