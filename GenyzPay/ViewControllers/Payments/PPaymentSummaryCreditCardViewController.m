//
//  PPaymentSummaryCreditCardViewController.m
//  GenyzPay
//
//  Created by Roman Bigun on 5/17/16.
//  Copyright © 2016 n. All rights reserved.
//

#import "PPaymentSummaryCreditCardViewController.h"
#import "GPPaymentEngine.h"
#import "GPNetworkingManager.h"
#import "RecipientsListViewController.h"
#import "AppDelegate.h"
@interface PPaymentSummaryCreditCardViewController ()
{

    BOOL unonimousPayment;
    
}
@property BOOL agreeToTermsAndConditions;
@end

@implementation PPaymentSummaryCreditCardViewController
#define checkBoxImages [NSArray arrayWithObjects:@"ic_checkbox",@"ic_check_checked",nil]
// Formats the date chosen with the date picker.
- (NSString *)formatDate:(NSDate *)date
{
    if([date isKindOfClass:[NSString class]]){
    
        return (NSString *)date;
    
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"MM'/'dd'/'yyyy"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}
-(void)loadPaymentInfo
{
    self.recipientNameLbl.text = [GPPaymentEngine currentPayment].recipientName;
    self.totalAmountLbl.text = [NSString stringWithFormat:@"%@$",[GPPaymentEngine currentPayment].paymentAmmount];
    self.feeLbl.text = [NSString stringWithFormat:@"%@$",[GPPaymentEngine currentPayment].fee];
    self.donorName.text = [GPPaymentEngine currentPayment].nameOnCard;
    self.cardNumberLbl.text = [GPPaymentEngine currentPayment].creditCardNumber;
    self.expirationDate.text = [self formatDate:[GPPaymentEngine currentPayment].expirationDateAsDateObject];
    self.state.text = [GPPaymentEngine currentPayment].state;
    self.addressLbl.text = [GPPaymentEngine currentPayment].billingAdderss;
    self.zipCodeLbl.text = [GPPaymentEngine currentPayment].zipCode;
    
}
-(void)buttonActions
{
    @weakify(self)
    RACSignal *agree = [self.agreeBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
    [agree subscribeNext:^(id sender) {
        @strongify(self)
        self.agreeToTermsAndConditions = !self.agreeToTermsAndConditions;
        [self.checkBox setImage:[UIImage imageNamed:checkBoxImages[self.agreeToTermsAndConditions]]];
        NSLog(@"%i",self.agreeToTermsAndConditions);
    }];
    
    RACSignal *submit = [self.confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
    [submit subscribeNext:^(id sender) {
        @strongify(self)
        if(_agreeToTermsAndConditions){
            
            RACSignal *rc = [[GPNetworkingManager sharedInstance]
                             makePayment:
                             [[GPPaymentEngine currentPayment] buildMakePaymentRequestParameters]];
            [rc subscribeNext:^(id x){
                if([x[@"success"] intValue]==1){
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [self performSelector:@selector(paymentSuccessful) withObject:nil afterDelay:1];
                    }];
                    
                    
                }
                
            }];
            
        }else{
            
            [[[UIAlertView alloc] initWithTitle:@"T&C"
                                        message:@"You did't agree with Ts&Cs"
                                       delegate:nil
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil, nil] show];
            
            
        }

        
    }];
      

}
- (void)viewDidLoad {
    [super viewDidLoad];
    unonimousPayment = NO;
    _agreeToTermsAndConditions=NO;
    [self loadPaymentInfo];
    [self buttonActions];
    [self.mainScroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1450)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)checkUnonimous:(id)sender{
    
    unonimousPayment = !unonimousPayment;
    
    NSLog(@"%i",unonimousPayment);
    
}

-(void)paymentSuccessful
{

    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Payment" message:@"Your payment was successful" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Set up a Reccuring payment" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Mark recepient as favorite" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Share payment info" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Invite others to the app" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Register" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [APPDelegate initRootController];
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        
    }]];
    

    [self presentViewController:actionSheet animated:YES completion:nil];

}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    
    
    return YES;
    
}
@end
