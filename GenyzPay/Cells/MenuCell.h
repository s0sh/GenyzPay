//
//  MenuCell.h
//  GenyzPay
//
//  Created by Roman Bigun on 3/15/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel *menuTitle;
@property(nonatomic,weak)IBOutlet UIImageView *menuImage;
-(void)configureCellForIndex:(int)index;
@end
