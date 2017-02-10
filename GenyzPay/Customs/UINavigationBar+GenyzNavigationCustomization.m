//
//  UINavigationBar+GenyzNavigationCustomization.m
//  GenyzPay
//
//  Created by Roman Bigun on 3/15/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import "UINavigationBar+GenyzNavigationCustomization.h"

@implementation UINavigationBar (GenyzNavigationCustomization)

+(void)customizeGenyzNavigationBar
{
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor whiteColor];
    shadow.shadowBlurRadius = 0.0;
    shadow.shadowOffset = CGSizeMake(0.0, 0.0);
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:59.0/255.0 green:126.0/255.0 blue:255.0/255.0 alpha:1.0]];
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
      NSForegroundColorAttributeName,
      shadow,
      NSShadowAttributeName,
      [UIFont fontWithName:@"HelveticaNeue Light" size:21.0],
      NSFontAttributeName,
      nil]];
    
}

@end
