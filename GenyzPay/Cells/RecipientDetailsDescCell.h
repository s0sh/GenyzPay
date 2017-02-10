//
//  RecipientDetailsDescCell.h
//  GenyzPay
//
//  Created by admin on 24.05.16.
//  Copyright © 2016 Erminesoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipientDetailsDescCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *recipientDesc;
@property (weak, nonatomic) IBOutlet UITextView *descTextView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descTextViewHeightConstraint;

@end
