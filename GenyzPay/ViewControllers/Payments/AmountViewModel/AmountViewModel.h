//
//  AmountViewModel.h
//  GenyzPay
//
//  Created by Roman Bigun on 5/16/16.
//  Copyright © 2016 n. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPPaymentEngine.h"
#import "GPNetworkingManager.h"
@interface AmountViewModel : NSObject
@property(nonatomic,retain)RACSignal *enableTF;
@property(nonatomic,strong)NSString *recipientNameTxt;
@property(nonatomic,strong)NSString *otherAmountTxt;
@property(nonatomic,strong)NSString *pAmount1Txt;
@property(nonatomic,strong)NSString *pAmount2Txt;
@property(nonatomic,strong)NSString *pAmount3Txt;
@property(nonatomic,strong)NSString *pAmount4Txt;
@property(nonatomic,strong)NSString *pAmount5Txt;
-(void)getDataForRecipientWithId:(NSString *)_id;
@end
