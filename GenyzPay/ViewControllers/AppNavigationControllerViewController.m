//
//  AppNavigationControllerViewController.m
//  GenyzPay
//
//  Created by admin on 05.05.16.
//  Copyright © 2016 n. All rights reserved.
//

#import "AppNavigationControllerViewController.h"
#import "SWRevealViewController.h"

@interface AppNavigationControllerViewController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate, SWRevealViewControllerDelegate>

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@end



@implementation AppNavigationControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self.revealViewController action:@selector(rightRevealToggle:)];
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
    self.tapGestureRecognizer.enabled = NO;
    
    SWRevealViewController *revealController = [self revealViewController];
    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
    
    self.revealViewController.delegate = self;
}

- (void) loadView {
    [super loadView];
   
    self.delegate = self;
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated;
{    
    UIViewController *first = navigationController.viewControllers.firstObject;
    
    SWRevealViewController *revealController = [self revealViewController];
    
    if (viewController == first) {
        
        [self.navigationController.navigationBar addGestureRecognizer:revealController.panGestureRecognizer];
        
        UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_menu"]
                                                                             style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
        revealButtonItem.tintColor = [UIColor whiteColor];
        
        viewController.navigationItem.leftBarButtonItem = revealButtonItem;
    }
}

#pragma mark - SWRevealViewController Delegate Methods

- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position
{
  
    if (position == FrontViewPositionRight) {
        self.tapGestureRecognizer.enabled = YES;
        self.interactivePopGestureRecognizer.enabled = NO;
        self.topViewController.view.userInteractionEnabled = NO;
    }
    else {
        self.tapGestureRecognizer.enabled = NO;
        self.interactivePopGestureRecognizer.enabled = YES;
        self.topViewController.view.userInteractionEnabled = YES;
    }
}

@end