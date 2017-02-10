//
//  RecipientDetails.h
//  GenyzPay
//
//  Created by Roman Bigun on 3/21/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipientDetailViewModel.h"
@interface RecipientDetails : UIViewController
@property(nonatomic,retain) RecipientDetailViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLbl;
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet UILabel *contactsLbl;
@property (strong, nonatomic)NSString *avatarUrl;
@property (weak, nonatomic) IBOutlet UIButton *addFavoriteBtn;
@property (strong, nonatomic)NSArray *compaginesArray;
@property (assign, nonatomic)BOOL isFavorite;
@property(nonatomic,strong)NSString *objId;
- (IBAction)dismiss:(id)sender;
@end
