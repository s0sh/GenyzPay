//
//  UIView+RoudedCorners.m
//  GenyzPay
//
//  Created by Roman Bigun on 4/5/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import "UIView+RoudedCorners.h"

@implementation UIView (RoudedCorners)
-(void)roundCorners
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.height / 2;

}
@end
