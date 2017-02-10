//
//  RecurringPaymentsViewController.m
//  GenyzPay
//
//  Created by admin on 05.05.16.
//  Copyright © 2016 n. All rights reserved.
//

#import "RecurringPaymentsViewController.h"

@interface RecurringPaymentsViewController ()

@end

@implementation RecurringPaymentsViewController

-(void)connectViewModel
{
    self.viewModel = [[GPReccuringPaymentViewModel alloc] init];
    
    RACSignal *cs  = RACObserve(self.viewModel, paymentsArray);
    @weakify(self)
    [cs subscribeNext:^(NSArray *x) {
        if(![x isKindOfClass:[NSNull class]])
        {
            if(x.count>0)
            {   @strongify(self)
                self.paymentsArray = [NSMutableArray arrayWithArray:x];
                [self.tableList reloadData];
            }
        }
        
    }];

    [self.viewModel refreshData];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableList.delegate=self;
    self.tableList.dataSource=self;
    self.tableList.allowsMultipleSelectionDuringEditing = NO;
    [self connectViewModel];
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.paymentsArray removeObjectAtIndex:indexPath.row];
        [self.tableList deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableList  reloadData];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;//[self.paymentsArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 96;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSString * objId =[self.paymentsArray objectAtIndex:indexPath.row];
    
    /*
    cntrSecondViewController *cntrinnerService = [[cntrSecondViewController alloc] initWithNibName:@"cntrSecondViewController" bundle:nil];
    [self.navigationController pushViewController:cntrinnerService animated:YES];
    */
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
    }
    
    // Here we use the provided setImageWithURL: method to load the web image
    // Ensure you use a placeholder image otherwise cells will be initialized with no image
   // cell.textLabel.text = @"My Text";
    return cell;
}
@end
