//
//  PAmountViewController.h
//  GenyzPay
//
//  Created by Roman Bigun on 5/16/16.
//  Copyright © 2016 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AmountViewModel.h"
#import "GPCheckBox.h"
#import "RadioButton.h"

@interface PAmountViewController : UIViewController<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    
    int amount;
    BOOL isOtherAmmountRequired;

}

@property(nonatomic,retain)RACSignal *enableTF;
@property(nonatomic,retain)NSString *objId;
@property(nonatomic,weak)IBOutlet UIScrollView *mainScroll;
@property(nonatomic,retain)AmountViewModel *viewModel;
@property(nonatomic,weak)IBOutlet UILabel *recipientNameLbl;
@property(nonatomic,weak)IBOutlet UILabel *pAmount1Lbl;
@property(nonatomic,weak)IBOutlet UILabel *pAmount2Lbl;
@property(nonatomic,weak)IBOutlet UILabel *pAmount3Lbl;
@property(nonatomic,weak)IBOutlet UILabel *pAmount4Lbl;
@property(nonatomic,weak)IBOutlet RadioButton *checkbox1;
@property(nonatomic,weak)IBOutlet RadioButton *checkbox2;
@property(nonatomic,weak)IBOutlet RadioButton *checkbox3;
@property(nonatomic,weak)IBOutlet RadioButton *checkbox4;
@property(nonatomic,weak)IBOutlet RadioButton *checkbox5;
@property(nonatomic,weak)IBOutlet UITextField *otherAmountTF;

@end
