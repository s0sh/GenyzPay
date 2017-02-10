//
//  LoginViewController.m
//  GenyzPay
//
//  Created by Roman Bigun on 3/15/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import "LoginViewController.h"
#import "GPNetworkingManager.h"
#import "GPDonor.h"
#import "MBProgressHUD.h"
#import "SWRevealViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

#define checkBoxImages [NSArray arrayWithObjects:@"ic_checkbox",@"ic_check_checked",nil]


@interface LoginViewController ()
{

    
    
}
@property(nonatomic,weak)IBOutlet UILabel *terms;
@property(nonatomic,assign)BOOL remember;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;



@end

@implementation LoginViewController
@synthesize terms = _terms;



- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //// keyboard show hide
    
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil]
      takeUntil:[self rac_willDeallocSignal]]
     subscribeNext:^(id x) {
         
         NSNotification *note = (NSNotification *)x;
         
         NSNumber *duration = note.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"];
         
         CGPoint offset = self.scrollView.contentOffset;
         
         CGRect keyboardSize = [note.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
         
         if (((self.passwordTF.frame.size.height - (self.passwordTF.frame.origin.y + self.passwordTF.frame.size.height) + self.scrollView.contentOffset.y) < keyboardSize.origin.y) && offset.y == 0.0)
         {
             offset.y += keyboardSize.size.height -50;
             
             [UIView animateWithDuration:[duration floatValue] animations:^{
                 
                 self.scrollView.contentOffset = offset;
             }];
         }
         
     }];
    
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillHideNotification object:nil]
      takeUntil:[self rac_willDeallocSignal]]
     subscribeNext:^(id x) {
         
         NSNotification *note = (NSNotification *)x;
         
         NSNumber *duration = note.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"];
         
         CGPoint offset = self.scrollView.contentOffset;
         offset.y = 0.0;
         
             [UIView animateWithDuration:[duration floatValue] animations:^{
                 
                 self.scrollView.contentOffset = offset;
             }];
}];
    
    
    
    
    
    
    
    _remember = 0;
    
    //Init ViewModel
    self.viewModel = [[LoginViewModel alloc ] init];

    //Sign actions to buttons

   // self.signInBtn.rac_command = self.viewModel.executeLogin;
    __weak __typeof(self)weakSelf = self;
    //Watching for changes happens in TextFields
    RAC(self.viewModel, passText) = self.passwordTF.rac_textSignal;
    RAC(self.viewModel, nameText) = self.userNameTF.rac_textSignal;
   
    
    //Get from ViewModel underlined text
    RAC(self.terms, attributedText) = RACObserve(self.viewModel, underlinedTermsText);
    RAC(self.terms, textColor) = RACObserve(self.viewModel, underlinedTextColor);
    RAC(self,signUpActiveSignal) =  RACObserve(self.viewModel, signUpActiveSignal);
    
    //Observe valid fields. If it is Ok, eneble button
    [_signUpActiveSignal subscribeNext:^(NSNumber *signupActive) {
        self.signInBtn.enabled = [signupActive boolValue];
    }];
    
    [[[[self.signInBtn
        rac_signalForControlEvents:UIControlEventTouchUpInside]
        doNext:^(id x) {
           self.signInBtn.enabled = NO;
       }]
      flattenMap:^id(id x) {
          [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
          
          return [[GPNetworkingManager sharedInstance]
                  loginWithParams:[self makeParams]];
      }] //Login result
     subscribeNext:^(NSDictionary *signedIn) {
         [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
         NSLog(@"%@",signedIn);
        // if(_remember){
             if([signedIn[@"success"] intValue]!= 0)
             {
                  NSLog(@"%@",signedIn);
                 [[GPDonor currentDonor] initWithData:signedIn];
                 [[GPDonor currentDonor] saveObjectAsDictionaryRepresentation];
                 
                 AppDelegate *appDelegateTemp = [[UIApplication sharedApplication] delegate];
                 [appDelegateTemp initRootController];
             }
             else{
             
                 [[[UIAlertView alloc] initWithTitle:@"SignIn" message:signedIn[@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                 
             
             }
         
             
        // }
         
         
         
         
            
         
     }];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapReceived:)];
    [tapGestureRecognizer setDelegate:self];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}
-(void)tapReceived:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [[self view] endEditing:YES];
    [self.passwordTF resignFirstResponder];
    [self.userNameTF resignFirstResponder];
    
//    [UIView animateWithDuration:0.25 animations:^{
//        [self.mainScroll setContentOffset:CGPointMake(0, 0) animated:YES];
//        
//    }];
}
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
}
#pragma mark - Text field delegate

-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    
//    if(textField == self.passwordTextField){
//        [UIView animateWithDuration:0.25 animations:^{
//            [self.mainScroll setContentOffset:CGPointMake(0, self.mainScroll.frame.origin.y+Y_OFFSET) animated:YES];
//            
//        }];
//    }
    
    return YES;
}
-(void) textFieldDidEndEditing:(UITextField *)textField
{
}

-(NSDictionary *)makeParams
{

    return [NSDictionary dictionaryWithObjectsAndKeys:
            self.viewModel.nameText,
            kObjectKeyName,
            self.viewModel.passText,
            kObjectKeyPassword,
            nil];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rememberMe:(id)sender {
    _remember = !_remember;
    [self.rememberMeCheckBoxImgView setImage:[UIImage imageNamed:checkBoxImages[_remember]]];
    
}
@end
