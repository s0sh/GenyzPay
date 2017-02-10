//
//  GPInformationPinBanner.h
//  GenyzPay
//
//  Created by Roman Bigun on 4/6/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface GPInformationPinBanner : UIView
@property(nonatomic,strong)NSDictionary *data;
@property(nonatomic,strong)UILabel *nameLbl;
@property(nonatomic,strong)UILabel *addressLbl;
@property(nonatomic,strong)UIButton *addFavoriteBtn;
@property(nonatomic,strong)UIImageView *imageTypeImageView;
@property(nonatomic,assign)BOOL showMe;
@property(nonatomic,assign) MKMapView *mapView;
-(void)show;
-(void)updateData:(NSDictionary *)data coordinates:(MKAnnotationView *)reciver andSuperview:(MKMapView*)sv;
@end
