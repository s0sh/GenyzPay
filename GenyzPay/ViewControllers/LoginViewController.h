//
//  LoginViewController.h
//  GenyzPay
//
//  Created by Roman Bigun on 3/15/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPFloatingPlaceholderTextField.h"
#import "LoginViewModel.h"
@interface LoginViewController : UIViewController<UITextFieldDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,weak)IBOutlet UIButton *rememberMeBtn;
@property(nonatomic,weak)IBOutlet UIButton *forgotPasswordBtn;
@property(nonatomic,weak)IBOutlet UIButton *signInBtn;
@property (strong, nonatomic) RACSignal * signUpActiveSignal;
@property (weak, nonatomic) IBOutlet RPFloatingPlaceholderTextField *userNameTF;
@property (weak, nonatomic) IBOutlet RPFloatingPlaceholderTextField *passwordTF;
@property (weak, nonatomic) IBOutlet RPFloatingPlaceholderTextField *phoneTF;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property(nonatomic,weak)IBOutlet UIImageView *rememberMeCheckBoxImgView;
@property(nonatomic,strong)LoginViewModel *viewModel;
- (IBAction)rememberMe:(id)sender;
@property(nonatomic,strong)NSDictionary *loginData;
@end
