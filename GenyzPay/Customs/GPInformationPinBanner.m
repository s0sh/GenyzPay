//
//  GPInformationPinBanner.m
//  GenyzPay
//
//  Created by Roman Bigun on 4/6/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import "GPInformationPinBanner.h"
#import "Constants.h"
#import "UIView+RoudedCorners.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+ViewShadow.h"
@implementation GPInformationPinBanner

@synthesize data = _data;
@synthesize showMe = _showMe;

-(void)initControlls
{
    //View
    self.alpha=0;
    self.layer.cornerRadius = 2;
    
    //Lables
    self.nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(5,5 , 110, 20)];
    self.addressLbl = [[UILabel alloc] initWithFrame:CGRectMake(5,25 , 110, 20)];
    self.nameLbl.textAlignment = NSTextAlignmentRight;
    self.addressLbl.textAlignment = NSTextAlignmentRight;
    self.addressLbl.font = kAddressAnnotationFont;
    self.nameLbl.font = kNameAnnotationFont;
    self.addressLbl.textColor = kAddressAnnotationColor;
    self.nameLbl.textColor = kNameAnnotationColor;
    [self addSubview:self.nameLbl];
    [self addSubview:self.addressLbl];
    
    //Buttons
    UIButton *btnFavorite = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width,self.frame.size.height-30 , 25, 25)];
    [btnFavorite setBackgroundImage:[UIImage imageNamed:@"ic_star_unfav_list"] forState:UIControlStateNormal];
    [self addSubview:btnFavorite];
    
    UIImageView *pay = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-20,self.frame.size.height-25 , 15, 15)];
    [pay setImage:[UIImage imageNamed:@"ic_registred_payment"]];
    [self addSubview:pay];
    
    UIButton *removeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 80, 70)];
    [removeBtn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    removeBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:removeBtn];
    
    
}
-(void)remove
{

    [self removeFromSuperview];

}
-(void)moveTo:(MKAnnotationView *)reciver andSuperview:(MKMapView*)sv
{

    CGPoint annotationPoint = [sv convertCoordinate:reciver.annotation.coordinate
                                      toPointToView:sv];
    float boxDY = annotationPoint.y - 90;
    float boxDX = annotationPoint.x + 10;
    
    [UIView animateWithDuration:0.01
                     animations:^{
                         self.frame = CGRectMake(boxDX, boxDY, 100, 70);
                     }completion:^(BOOL finished){
                         
                         
                     }];

}
-(void)updateData:(NSDictionary *)data coordinates:(MKAnnotationView *)reciver andSuperview:(MKMapView*)sv
{
        //Common init
        [self initControlls];
        //Custom init
        self.mapView = sv;
        CGPoint annotationPoint = [sv convertCoordinate:reciver.annotation.coordinate
                                               toPointToView:sv];
        float boxDY = annotationPoint.y - 90;
        float boxDX = annotationPoint.x + 10;
    
    
    
    _showMe = NO;
    [UIView animateWithDuration:0.01
                     animations:^{
                         self.frame = CGRectMake(boxDX, boxDY, 130, 70);
                     }completion:^(BOOL finished){
                         
                     
                     }];
    
    self.nameLbl.text = [data[kObjectKeyName] copy];
    self.addressLbl.text = [data[kObjectKeyAddress] copy];
    self.backgroundColor = [UIColor whiteColor];
    [sv addSubview:self];
    [self addShadow];

}
-(void)show
{
    _showMe = !_showMe;
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         
                         self.alpha = (int)_showMe;
                     }completion:^(BOOL finished){
                         self.alpha = (int)_showMe;
                     }];

}

@end
