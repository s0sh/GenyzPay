//
//  MenuViewController.m
//  GenyzPay
//
//  Created by admin on 04.05.16.
//  Copyright © 2016 n. All rights reserved.
//

#import "MenuViewController.h"
#import "SWRevealViewController.h"

@interface MenuViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingXforImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidth;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *numberOfUpdatesCounterViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingXnumberOfUpdatesCounterView;

@property (weak, nonatomic) IBOutlet UILabel *counterLabel;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (void) loadView
{
    [super loadView];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    SWRevealViewController *reveal = [self revealViewController];
    
    self.leadingXforImage.constant = reveal.rearViewRevealWidth/2 - self.imageWidth.constant/2;
    
    self.leadingXnumberOfUpdatesCounterView.constant = reveal.rearViewRevealWidth - 30 - self.numberOfUpdatesCounterViewWidth.constant;
    
    
}

@end
