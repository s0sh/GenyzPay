//
//  GPCheckBox.m
//  GenyzPay
//
//  Created by Roman Bigun on 5/16/16.
//  Copyright © 2016 n. All rights reserved.
//

#import "GPCheckBox.h"

@implementation GPCheckBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
 
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self){
 
    }
    return self;
}
-(void)awakeFromNib
{
    if(self.tag==4){
        [self setBackgroundImage:checkBoxImages[1] forState:UIControlStateNormal];
        isSelected = YES;
    }else{
        [self setBackgroundImage:checkBoxImages[0] forState:UIControlStateNormal];
        isSelected = NO;
    
    }

}
-(IBAction)click:(UIButton*)sender
{
    
    isSelected=!isSelected;
    [self setBackgroundImage:checkBoxImages[isSelected] forState:UIControlStateNormal];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
