//
//  PNewCreditCardViewController.m
//  GenyzPay
//
//  Created by Roman Bigun on 5/17/16.
//  Copyright © 2016 n. All rights reserved.
//

#import "PNewCreditCardViewController.h"
#import "CardInfoViewModel.h"
#import "GPPaymentEngine.h"
#import "GPNetworkingManager.h"
#import "PPaymentSummaryCreditCardViewController.h"
#import "MBProgressHUD.h"
#define checkBoxImages [NSArray arrayWithObjects:@"ic_checkbox",@"ic_check_checked",nil]
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_6PLUS (IS_IPHONE && [[UIScreen mainScreen] nativeScale] == 3.0f)
@interface PNewCreditCardViewController ()
{

    BOOL storeCardDetails;

}
@property(nonatomic,retain)CardInfoViewModel *viewModel;
@end

@implementation PNewCreditCardViewController

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(textField == self.cardNumberTF)
    {
    __block NSString *text = [textField text];
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *newString = @"";
    while (text.length > 0) {
        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, 4)];
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    
    if (newString.length >= 20) {
        return NO;
    }
    [GPPaymentEngine currentPayment].creditCardNumber = newString;
    [textField setText:newString];
    
    return NO;
    }
    
    return YES;
}
-(void)restoreData
{

    if([GPPaymentEngine currentPayment].expirationDateAsDateObject==nil){
    
        self.expirationDateTF.text = [self formatDate:[NSDate date]];
        [GPPaymentEngine currentPayment].expirationDateAsDateObject = [NSDate date];
        
    }else{
        self.expirationDateTF.text = [self formatDate:[GPPaymentEngine currentPayment].expirationDateAsDateObject];
        
    }
    NSLog(@"%@",[GPPaymentEngine currentPayment].expirationDateAsDateObject);
    self.nameOnCardTF.text = [GPPaymentEngine currentPayment].nameOnCard;
    self.cardNumberTF.text = [GPPaymentEngine currentPayment].creditCardNumber;
    self.stateTF.text = [GPPaymentEngine currentPayment].state;
    self.addressTF.text = [GPPaymentEngine currentPayment].billingAdderss;
    self.zipCodeTF.text = [GPPaymentEngine currentPayment].zipCode;
    self.securityCodeTF.text = [GPPaymentEngine currentPayment].securityCode;
    [self.checkBox setImage:[UIImage imageNamed:checkBoxImages[[GPPaymentEngine currentPayment].storeCardDetails]]];

}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField!=self.cardNumberTF && textField != self.expirationDateTF && textField!=self.securityCodeTF)
    {
       [self animateTextField:textField up:NO];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self animateTextField:textView up:NO];
}
-(void)animateTextField:(id)textField up:(BOOL)up
{
    const int movementDistance = -130; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
    
}
- (void)textViewDidBeginEditing:(UITextView *)textField{
    [self animateTextField:textField up:YES];
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField!=self.cardNumberTF && textField != self.expirationDateTF && textField!=self.securityCodeTF)
    {
       [self animateTextField:textField up:YES];
    }
    if(textField==self.expirationDateTF)
    {
    
        UIDatePicker *datePicker = [[UIDatePicker alloc]init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:-31536000];
        [datePicker setDate:[NSDate date]];
        [datePicker addTarget:self action:@selector(updateDateField:) forControlEvents:UIControlEventValueChanged];
        
        // If the date field has focus, display a date picker instead of keyboard.
        // Set the text to the date currently displayed by the picker.
        
        self.expirationDateTF.inputView = datePicker;
        self.expirationDateTF.text = [self formatDate:datePicker.date];
        [GPPaymentEngine currentPayment].expirationDateAsDateObject = datePicker.date;
        
        
    }
}
-(void)connectViewModel
{

    self.viewModel = [[CardInfoViewModel alloc] init];

    RAC(self.viewModel, cardNumberStr) = self.cardNumberTF.rac_textSignal ;
    RAC(self.viewModel, expirationDateStr) = self.expirationDateTF.rac_textSignal;
    RAC(self.viewModel, nameOnCardStr) = self.nameOnCardTF.rac_textSignal;
    RAC(self.viewModel, addressStr) = self.addressTF.rac_textSignal;
    RAC(self.viewModel, stateStr) = self.stateTF.rac_textSignal;
    RAC(self.viewModel, zipCodeStr) = self.zipCodeTF.rac_textSignal;
    RAC(self.viewModel, securityCodeStr) = self.securityCodeTF.rac_textSignal;
    
    
}
-(void)enableScrolling
{
    if(!IS_IPHONE_6PLUS){
       [self.mainScroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 736)];
    }
    else{
        [self.mainScroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-66)];
        //self.mainScroll.scrollEnabled = NO;
        
    }
    
}
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   

}
-(void)viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:YES];

    self.cardNumberTF.delegate = self;
    self.expirationDateTF.delegate = self;
    self.addressTF.delegate = self;
    self.stateTF.delegate = self;
    self.zipCodeTF.delegate = self;
    self.nameOnCardTF.delegate=self;
    self.securityCodeTF.delegate=self;
    storeCardDetails = NO;
    [self restoreData];
    [self connectViewModel];
    [self enableScrolling];
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapReceived:)];
    [tapGestureRecognizer setDelegate:self];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}
-(void)tapReceived:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [[self view] endEditing:YES];
    [self.addressTF resignFirstResponder];
    [self.stateTF resignFirstResponder];
    [self.zipCodeTF resignFirstResponder];
    [self.addressTF resignFirstResponder];
    [self.cardNumberTF resignFirstResponder];
    [self.nameOnCardTF resignFirstResponder];
    [self.securityCodeTF resignFirstResponder];
    [self.expirationDateTF resignFirstResponder];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)storeCardDetails
{
    storeCardDetails = !storeCardDetails;
    [self.checkBox setImage:[UIImage imageNamed:checkBoxImages[storeCardDetails]]];
    [GPPaymentEngine currentPayment].storeCardDetails = storeCardDetails;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}
-(BOOL)validateFields
{
    NSLog(@"%@",[GPPaymentEngine currentPayment].creditCardNumber);
    
    if([[GPPaymentEngine currentPayment].creditCardNumber containsString:@" "]?[GPPaymentEngine currentPayment].creditCardNumber.length<19:[GPPaymentEngine currentPayment].creditCardNumber.length<16)
    {
        [[[UIAlertView alloc] initWithTitle:@"Validation"
                                    message:@"Invalid credit card number"
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil, nil] show];
        return NO;
        
    }
    if(self.viewModel.nameOnCardStr.length<=2 || self.viewModel.nameOnCardStr.length>100)
    {
        [[[UIAlertView alloc] initWithTitle:@"Name Validation"
                                    message:@"A-Z letters only and spaces, length more than 2 symbols and not longer than 100 symbols"
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil, nil] show];
        return NO;
        
    }
    if(self.viewModel.addressStr.length==0 || self.viewModel.addressStr.length>300)
    {
        [[[UIAlertView alloc] initWithTitle:@"Address Validation"
                                    message:@"Not longer than 300 symbols and not empty"
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil, nil] show];
        return NO;
        
    }
    if(self.viewModel.stateStr.length==0 || self.viewModel.stateStr.length>300)
    {
        [[[UIAlertView alloc] initWithTitle:@"State Validation"
                                    message:@"Not longer than 300 symbols and not empty"
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil, nil] show];
        return NO;
        
    }
    if(self.viewModel.zipCodeStr.length==0 || self.viewModel.zipCodeStr.length>20)
    {
        [[[UIAlertView alloc] initWithTitle:@"Zip Code Validation"
                                    message:@"Digits only, not longer than 20 symbols and not empty"
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil, nil] show];
        return NO;
        
    }
    if(self.viewModel.securityCodeStr.length==0 || self.viewModel.securityCodeStr.length>4 || ![self scanForDigits:self.viewModel.securityCodeStr])
    {
        [[[UIAlertView alloc] initWithTitle:@"Seecurity Code Validation"
                                    message:@"Please enter a valid security code [3-4 symbols, digits only]"
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil, nil] show];
        return NO;
        
    }
    if([GPPaymentEngine currentPayment].expirationDateAsDateObject==nil)
    {
    
        [[[UIAlertView alloc] initWithTitle:@"Date Validation"
                                    message:@"Date cannnot be empty"
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil, nil] show];
        return NO;
    
    }
    
    return YES;
}
-(BOOL)scanForDigits:(NSString *)text
{

    NSScanner* scan = [NSScanner scannerWithString:text];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
    
}
- (BOOL) connectedToInternet
{
    NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"]];
    return ( URLString != NULL ) ? YES : NO;
}
- (IBAction)next:(id)sender {
    
    if([self connectedToInternet])
    {
    if([self validateFields]){
        self.nextBtn.enabled = NO;
        
        //if([GPPaymentEngine currentPayment].storeCardDetails==YES){
            RACSignal *rc = [[GPNetworkingManager sharedInstance] createNewCard:[[GPPaymentEngine currentPayment] buildCard]];
            [rc subscribeNext:^(id x){
               
                if([x[@"success"] intValue]==1){
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [GPPaymentEngine currentPayment].cardId = [NSString stringWithFormat:@"%@",x[@"data"][@"purse_id"]];
                        if([GPPaymentEngine currentPayment].cardId.length>0){
                            NSLog(@"Purse id : %@",[GPPaymentEngine currentPayment].cardId);
                            PPaymentSummaryCreditCardViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"paymentSummary"];
                            self.nextBtn.enabled = YES;
                            [self.navigationController pushViewController:newView animated:YES];
                        }
            
                    }];
                    
                    
                }
                
            }];
            
    //}
    }
    }
    else{
    
        [[[UIAlertView alloc] initWithTitle:@"Internet connection"
                                        message:@"The Internet connection appears to be offline"
                                        delegate:nil
                                        cancelButtonTitle:@"Ok"
                                        otherButtonTitles:nil, nil]
                   show];
    
    }
    
}

// Called when the date picker changes.
- (void)updateDateField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.expirationDateTF.inputView;
    self.expirationDateTF.text = [self formatDate:picker.date];
    [GPPaymentEngine currentPayment].expirationDateAsDateObject = picker.date;
    
}


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
@end
