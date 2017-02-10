//
//  PMethodsViewController.m
//  GenyzPay
//
//  Created by Roman Bigun on 5/17/16.
//  Copyright © 2016 n. All rights reserved.
//

#import "PMethodsViewController.h"
#import "GPPaymentEngine.h"
#import "GPCardIOViewController.h"
#import "PNewCreditCardViewController.h"
@interface PMethodsViewController ()

@end

@implementation PMethodsViewController
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_6PLUS (IS_IPHONE && [[UIScreen mainScreen] nativeScale] == 3.0f)
- (void)viewDidLoad {
    [super viewDidLoad];
     self.recepientNameLbl.text = [GPPaymentEngine currentPayment].recipientName;
    self.manualInputBtn.selected = YES;
    _inputMethod = GPPaymentInputMethodManual;
    
    if(!IS_IPHONE_6PLUS){
        [self.mainScroll setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-66)];
        
        //   [self.mainScroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 736)];
    }
    else{
        [self.mainScroll setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+66)];
        
        [self.mainScroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 736)];
    }

    self.mainScroll.scrollEnabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
-(IBAction)setupMethod:(UIButton*)sender
{
    _paymentMethod = sender.tag;
    NSLog(@"%li",(long)_paymentMethod);
}
-(IBAction)setupBankAccount:(UIButton*)sender
{
    _bankAccount = sender.tag;
    NSLog(@"%li",(long)_bankAccount);
}
-(IBAction)setupInputMethod:(UIButton*)sender
{
    _inputMethod = sender.tag;
    NSLog(@"%li",(long)_inputMethod);
}
-(IBAction)selectMethod{

    if(_inputMethod == GPPaymentInputMethodCardIO){
    
        GPCardIOViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"cardIO"];
        [self.navigationController pushViewController:newView animated:YES];
    
    }
    else
    {
        PNewCreditCardViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"newCard"];
        [self.navigationController pushViewController:newView animated:YES];
    }
        

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
