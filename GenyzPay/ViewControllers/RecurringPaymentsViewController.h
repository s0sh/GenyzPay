//
//  RecurringPaymentsViewController.h
//  GenyzPay
//
//  Created by admin on 05.05.16.
//  Copyright © 2016 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPReccuringPaymentViewModel.h"
@interface RecurringPaymentsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)IBOutlet UITableView *tableList;
@property(nonatomic,retain) GPReccuringPaymentViewModel *viewModel;
@property(nonatomic,retain) NSMutableArray *paymentsArray;
@end
