//
//  PPaymentSummaryCreditCardViewController.h
//  GenyzPay
//
//  Created by Roman Bigun on 5/17/16.
//  Copyright © 2016 n. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPaymentSummaryCreditCardViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *checkBox;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UILabel *recipientNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLbl;
@property (weak, nonatomic) IBOutlet UILabel *feeLbl;
@property (weak, nonatomic) IBOutlet UISwitch *payAnonimouslySwitch;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UILabel *cardNumberLbl;
@property (weak, nonatomic) IBOutlet UILabel *expirationDate;
@property (weak, nonatomic) IBOutlet UILabel *donorName;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet UILabel *zipCodeLbl;
@property(nonatomic,weak)IBOutlet UIScrollView *mainScroll;
- (IBAction)confirmPayment:(id)sender;
- (IBAction)checkUnonimous:(id)sender;
@end
