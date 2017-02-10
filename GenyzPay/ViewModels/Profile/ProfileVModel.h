//
//  ProfileVModel.h
//  GenyzPay
//
//  Created by Roman Bigun on 4/5/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ProfileVModel : NSObject

@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *accessToken;
@property(nonatomic,strong)NSString *nameTxt;
@property(nonatomic,strong)NSString *lastNameTxt;
@property(nonatomic,strong)NSString *dobTxt;
@property(nonatomic,strong)NSString *phoneTxt;
@property(nonatomic,strong)NSString *emailTxt;
@property(nonatomic,strong)NSString *countryTxt;
@property(nonatomic,strong)NSString *addressTxt;
@property(nonatomic,strong)NSString *avatarUrl;
@property(nonatomic,strong)UIImageView * avatarImageView;
- (void)initialize;
@end
