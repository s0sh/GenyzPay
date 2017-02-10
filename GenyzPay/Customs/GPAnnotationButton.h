//
//  BFAnnotationButton.h
//  BritishFood
//
//  Created by Roman Bigun on 3/22/16.
//
//

#import <UIKit/UIKit.h>
#import "Recipient.h"
#import "GPInformationPinBanner.h"

@interface GPAnnotationButton : UIButton
@property(nonatomic,retain)NSString *adStringID;
@property(nonatomic,retain)GPInformationPinBanner *banner;
@property(nonatomic,strong) Recipient *recipient;
@property(nonatomic,strong)NSDictionary *data;

@end
