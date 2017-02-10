//
//  GPCardIOViewController.m
//  GenyzPay
//
//  Created by Roman Bigun on 5/20/16.
//  Copyright © 2016 Erminesoft. All rights reserved.
//

#import "GPCardIOViewController.h"
#import "CardIO.h"
#import "GPPaymentEngine.h"
#import "PNewCreditCardViewController.h"
@interface GPCardIOViewController ()<CardIOPaymentViewControllerDelegate>

@end

@implementation GPCardIOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SCAN CARD";
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [CardIOUtilities preload];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)scanCardClicked:(id)sender {
    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    scanViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:scanViewController animated:YES completion:nil];
}

#pragma mark - CardIOPaymentViewControllerDelegate

- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)info inPaymentViewController:(CardIOPaymentViewController *)paymentViewController {
    NSLog(@"Scan succeeded with info: %@", info);
    // Do whatever needs to be done to deliver the purchased items.
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [GPPaymentEngine currentPayment].creditCardNumber = info.cardNumber;
    [GPPaymentEngine currentPayment].nameOnCard = info.cardholderName;
    [GPPaymentEngine currentPayment].securityCode = info.cvv;
    
    [GPPaymentEngine currentPayment].expirationDateAsDateObject = [self createValidDate:(unsigned long)info.expiryYear andMonth:(unsigned long)info.expiryMonth];
    
    NSLog(@"%@",[NSString stringWithFormat:@"Received card info. Number: %@, expiry: %02lu/%lu, cvv: %@. Name on Card %@", info.redactedCardNumber, (unsigned long)info.expiryMonth, (unsigned long)info.expiryYear, info.cvv, info.cardholderName]);
    
    
}

- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)paymentViewController {
    NSLog(@"User cancelled scan");
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(NSDate *)createValidDate:(long long)year andMonth:(long long)month
{
    NSString *dateStr = [NSString stringWithFormat:@"%lld %lld",month,year];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateStyle:NSDateFormatterShortStyle];
    [dateFormat setDateFormat:@"MM yy"];
    NSDate *date = [dateFormat dateFromString:dateStr];
    NSLog(@"Date : %@", date);

    return  date;

}
-(IBAction)goNext
{

    PNewCreditCardViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"newCard"];
    [self.navigationController pushViewController:newView animated:YES];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
