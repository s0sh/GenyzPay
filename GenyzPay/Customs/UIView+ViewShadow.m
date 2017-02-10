//
//  UIView+ViewShadow.m
//  GenyzPay
//
//  Created by Roman Bigun on 4/7/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import "UIView+ViewShadow.h"

@implementation UIView (ViewShadow)

-(void)addShadow
{
    
    self.layer.masksToBounds = NO;
    self.layer.cornerRadius = 2;
    self.layer.shadowOffset = CGSizeMake(-5, 5);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    self.layer.shadowColor = [UIColor grayColor].CGColor;
}
@end
