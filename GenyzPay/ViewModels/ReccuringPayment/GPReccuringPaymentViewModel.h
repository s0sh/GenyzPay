//
//  GPReccuringPaymentViewModel.h
//  GenyzPay
//
//  Created by Roman Runner on 5/30/16.
//  Copyright © 2016 Erminesoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>
#import "Constants.h"
#import "GPNetworkingManager.h"
@interface GPReccuringPaymentViewModel : NSObject
@property(nonatomic,retain)NSArray *paymentsArray;
-(void)refreshData;
@end
