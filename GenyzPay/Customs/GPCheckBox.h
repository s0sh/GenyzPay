//
//  GPCheckBox.h
//  GenyzPay
//
//  Created by Roman Bigun on 5/16/16.
//  Copyright © 2016 n. All rights reserved.
//

#import <UIKit/UIKit.h>

#define checkBoxImages [NSArray arrayWithObjects:@"ic_checkbox",@"ic_check_checked",nil]
@interface GPCheckBox : UIButton
{
    BOOL isSelected;
}
-(IBAction)click:(UIButton*)sender;
@end
