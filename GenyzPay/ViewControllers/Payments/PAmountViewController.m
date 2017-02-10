//
//  PAmountViewController.m
//  GenyzPay
//
//  Created by Roman Bigun on 5/16/16.
//  Copyright © 2016 n. All rights reserved.
//

#import "PAmountViewController.h"

@interface PAmountViewController ()

@end

@implementation PAmountViewController

@synthesize objId = _objId;

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_6PLUS (IS_IPHONE && [[UIScreen mainScreen] nativeScale] == 3.0f)
#define checkBoxImages [NSArray arrayWithObjects:@"ic_checkbox",@"ic_check_checked",nil]

-(IBAction)back:(id)sender
{

    [self.navigationController popViewControllerAnimated:YES];

}
-(void)initVars
{
    
    [self.otherAmountTF setEnabled:NO];
    self.otherAmountTF.delegate = self;
    isOtherAmmountRequired = NO;
    self.checkbox1.selected=YES;
    [GPPaymentEngine currentPayment].paymentAmmount=@"100";
    
    if(_objId.length==0)
        _objId = @"1";
    
}
-(void)connectModel
{
    
    self.viewModel = [[AmountViewModel alloc] init];
    RAC(self.recipientNameLbl, text) = RACObserve(self.viewModel, recipientNameTxt);
    RAC(self.pAmount1Lbl, text) = RACObserve(self.viewModel, pAmount1Txt);
    RAC(self.pAmount2Lbl, text) = RACObserve(self.viewModel, pAmount2Txt);
    RAC(self.pAmount3Lbl, text) = RACObserve(self.viewModel, pAmount3Txt);
    RAC(self.pAmount4Lbl, text) = RACObserve(self.viewModel, pAmount4Txt);
    RAC(self.viewModel, pAmount5Txt) = self.otherAmountTF.rac_textSignal;
    
}
-(void)applyTapGesture
{

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapReceived:)];
    [tapGestureRecognizer setDelegate:self];
    [self.view addGestureRecognizer:tapGestureRecognizer];

}
-(void)tapReceived:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [[self view] endEditing:YES];
    [self.otherAmountTF resignFirstResponder];
    
    
}

-(IBAction)saveAmount:(UIButton*)sender
{

    if(sender.tag==0){
        [GPPaymentEngine currentPayment].paymentAmmount=@"100";
    }
    else if(sender.tag==1){
        [GPPaymentEngine currentPayment].paymentAmmount=@"200";
    }
    else if(sender.tag==2){
        [GPPaymentEngine currentPayment].paymentAmmount=@"500";
    }
    else if(sender.tag==3){
        [GPPaymentEngine currentPayment].paymentAmmount=@"1000";
    }
    
    if(sender.tag==4){
       [self.otherAmountTF setEnabled:YES];
        
    }else{
       [self.otherAmountTF setEnabled:NO];
        self.otherAmountTF.text=@"";
        
    }
}
-(void)restorEndSelectRadiobutton
{
    NSArray * arr = [self.view subviews];
    for(RadioButton *btn in arr){
        if([btn isKindOfClass:[RadioButton class]])
        {
            if(btn.tag == [GPPaymentEngine currentPayment].selectedTag){
                btn.selected = YES;
                
            }
        }
    
    }


}
-(void)enableScrolling
{
   
    if(!IS_IPHONE_6PLUS){
         [self.mainScroll setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-66)];
        
    //   [self.mainScroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 736)];
    }
    else{
        [self.mainScroll setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+66)];
        self.mainScroll.scrollEnabled = NO;
        [self.mainScroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 736)];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self enableScrolling];
    [self restorEndSelectRadiobutton];
    [self initVars];
    [self connectModel];
    [self applyTapGesture];
    [self.viewModel getDataForRecipientWithId:_objId];
    self.mainScroll.scrollEnabled = NO;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - Navigation
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{

    if((self.viewModel.pAmount5Txt.length==0 && self.otherAmountTF.isEnabled) || (![self scanForDigits:self.otherAmountTF.text] &&  self.otherAmountTF.isEnabled)){
    
        [[[UIAlertView alloc] initWithTitle:@"Validation"
                                    message:@"Add payment ammount[digits only]"
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil, nil] show];
        return NO;
    
    }
   
    return YES;

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    self.otherAmountTF.text.length>0?[GPPaymentEngine currentPayment].paymentAmmount=self.otherAmountTF.text:[GPPaymentEngine currentPayment].paymentAmmount;
}

#pragma mark Textfields Delegates and helpers
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self animateTextField:textField up:YES];
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [GPPaymentEngine currentPayment].paymentAmmount = textField.text;
    [self animateTextField:textField up:NO];
}
-(void)animateTextField:(id)textField up:(BOOL)up
{
    const int movementDistance = -130;
    const float movementDuration = 0.3f;
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
-(BOOL)scanForDigits:(NSString *)text
{
    
    NSScanner* scan = [NSScanner scannerWithString:text];
    int val;
    BOOL ret = [scan scanInt:&val] && [scan isAtEnd];
    return ret;
    
}
@end
