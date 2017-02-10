//
//  PNewCreditCardViewController.h
//  GenyzPay
//
//  Created by Roman Bigun on 5/17/16.
//  Copyright © 2016 n. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PNewCreditCardViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate, UIPickerViewDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *cardNumberTF;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScroll;
@property (weak, nonatomic) IBOutlet UITextField *expirationDateTF;
@property (weak, nonatomic) IBOutlet UITextField *nameOnCardTF;
@property (weak, nonatomic) IBOutlet UITextView *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *stateTF;
@property (weak, nonatomic) IBOutlet UIButton *storeCardDetailsImageView;
@property (weak, nonatomic) IBOutlet UITextField *zipCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *securityCodeTF;
@property (weak, nonatomic) IBOutlet UIImageView *checkBox;
- (IBAction)next:(id)sender;
@end
