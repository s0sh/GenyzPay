//
//  PMethodsViewController.h
//  GenyzPay
//
//  Created by Roman Bigun on 5/17/16.
//  Copyright © 2016 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioButton.h"

typedef NS_ENUM(NSInteger, GPPaymentMethod) {
    GPPaymentCard = 0,
    GPPaymentTransfer
};
typedef NS_ENUM(NSInteger, GPPaymentBankAccount) {
    GPPaymentAccountExisting = 0,
    GPPaymentAccountNew
};
typedef NS_ENUM(NSInteger, GPPaymentInputMethod) {
    GPPaymentInputMethodManual = 0,
    GPPaymentInputMethodCardIO
};

@interface PMethodsViewController : UIViewController

@property GPPaymentMethod paymentMethod;
@property GPPaymentBankAccount bankAccount;
@property GPPaymentInputMethod inputMethod;
@property(nonatomic,weak)IBOutlet UIScrollView *mainScroll;
@property(nonatomic,weak)IBOutlet RadioButton *bankTransferBtn;
@property(nonatomic,weak)IBOutlet RadioButton *creditCardBtn;
@property(nonatomic,weak)IBOutlet RadioButton *existingBankAccountBtn;
@property(nonatomic,weak)IBOutlet RadioButton *nwBankAccountBtn;
@property(nonatomic,weak)IBOutlet RadioButton *manualInputBtn;
@property(nonatomic,weak)IBOutlet RadioButton *cardIoBtn;
@property (weak, nonatomic) IBOutlet UILabel *recepientNameLbl;

@end
