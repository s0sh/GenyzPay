//
//  RecipientDetails.m
//  GenyzPay
//
//  Created by Roman Bigun on 3/21/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import "RecipientDetails.h"
#import "CompaignCell.h"
#import <ReactiveCocoa.h>
#import "UIView+RoudedCorners.h"
#import "MBProgressHUD.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "GPNetworkingManager.h"
#import "RecipientDetailsTitleCell.h"
#import "RecipientDetailsCompaignCell.h"
#import "RecipientDetailsDescCell.h"
#import "PAmountViewController.h"
#import "RecipientDetailsAddressCell.h"
#import "RecipientDetailsContactsCell.h"


#define NUMBER_OF_STATIC_CELLS  6

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_6PLUS (IS_IPHONE && [[UIScreen mainScreen] nativeScale] == 3.0f)
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
@interface RecipientDetails() <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)IBOutlet UITableView *compaginesTable;
@property(nonatomic,weak)IBOutlet UIScrollView *mainScroll;
@property int heightOfDescCell;
@property(nonatomic,strong) NSMutableString *idOfCampaign;

@end

@implementation RecipientDetails

@synthesize objId;

-(void)initModel
{
    
    RAC(self.nameLbl, text) = RACObserve(self.viewModel, recipientName);
    RAC(self.contactsLbl, text) = RACObserve(self.viewModel, recipientContacts);
    RAC(self.addressLbl, text) = RACObserve(self.viewModel, recipientAddress);
    RAC(self.descriptionLbl, text) = RACObserve(self.viewModel, recipientDescription);
   
    
    RACSignal *cs  = RACObserve(self.viewModel, compaginesArray);
    @weakify(self)
    [cs subscribeNext:^(NSArray *x) {
        if(![x isKindOfClass:[NSNull class]])
        {
            if(x.count>0)
            {   @strongify(self)
                self.compaginesArray = [NSArray arrayWithArray:x];
                [self.compaginesTable reloadData];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
            else
            {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
        }
        
    }];
    
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    self.idOfCampaign = [@"" mutableCopy];
    self.compaginesArray = [[NSMutableArray alloc] init];
    self.compaginesTable.delegate=self;
    self.compaginesTable.dataSource=self;
    self.viewModel = [[RecipientDetailViewModel alloc] init];
    [self initModel];
    [self.viewModel refreshDataWithId:objId];
}

- (IBAction)dismiss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 298;
    }
    else if (indexPath.row == 1) {
        return 53;
    }
    else if (indexPath.row == 2) {
        
        if (self.heightOfDescCell) {
            
            return self.heightOfDescCell;
        }
        return 128;
    }
    else if (indexPath.row == 3) {
        return 70;
    }
    else if (indexPath.row == 4) {
        return 70;
    }
    else if (indexPath.row == 5) {
        return 56;
    }
    else {
        return 75;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.viewModel.compaginesArray.count + NUMBER_OF_STATIC_CELLS;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row < NUMBER_OF_STATIC_CELLS) {
        
        if (indexPath.row == 0) {
            
            NSString *cellIdentifier = @"Cell0";
            return [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        }
        else if (indexPath.row == 1) {
            
            NSString *cellIdentifier = @"RecipientDetailsTitleCell";
            
            
            RecipientDetailsTitleCell *cell = (RecipientDetailsTitleCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RecipientDetailsTitleCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            cell.recipientTitle.text = self.viewModel.recipientName;
            
            RACSignal *isFSignal = RACObserve(self.viewModel,isFavorites);
            @weakify(cell)
            [isFSignal   subscribeNext:^(NSNumber *x){

                @strongify(cell)
                [cell.favoriteButton setSelected:[x boolValue]];
                NSLog(@"%i",[x intValue]);
                
            }];
            @weakify(self)
            [[[cell.favoriteButton rac_signalForControlEvents:UIControlEventTouchUpInside]
              takeUntil:cell.rac_prepareForReuseSignal]
             subscribeNext:^(id x) {
                @strongify(self)
                 [self.viewModel addToFavorite];
             }];
            
            
            return cell;
        }
        else if (indexPath.row == 2) {
            
            NSString *cellIdentifier = @"RecipientDetailsDescCell";
            
            RecipientDetailsDescCell *cell = (RecipientDetailsDescCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RecipientDetailsDescCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            cell.descTextView.text = self.viewModel.recipientDescription;
            
            if (!self.heightOfDescCell) {
                
                //////////
                CGSize sizeThatFitsTextView = [cell.descTextView sizeThatFits:CGSizeMake(cell.descTextView.frame.size.width, MAXFLOAT)];
                
                int heightOfTextView = sizeThatFitsTextView.height;
                
                cell.descTextViewHeightConstraint.constant = heightOfTextView;
                
                //////////
                
                int heightOfCell = (cell.frame.origin.y +cell.recipientDesc.frame.origin.y)
                + cell.recipientDesc.frame.size.height
                + (cell.recipientDesc.frame.origin.y)
                + heightOfTextView-8;
                
                self.heightOfDescCell = heightOfCell;
                
                [self.compaginesTable reloadData];
            }
            
            return cell;
        }
        else if (indexPath.row == 3) {
            
            NSString *cellIdentifier = @"RecipientDetailsAddressCell";
            
            RecipientDetailsAddressCell *cell = (RecipientDetailsAddressCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RecipientDetailsAddressCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            cell.recipientAddress.text = self.viewModel.recipientAddress;
            
            return cell;
            
        }
        else if (indexPath.row == 4) {
            
            NSString *cellIdentifier = @"RecipientDetailsContactsCell";
            
            RecipientDetailsContactsCell *cell = (RecipientDetailsContactsCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RecipientDetailsContactsCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            cell.recipientDetailsContacts.titleLabel.text = self.viewModel.recipientContacts;
            
            return cell;
        }
        else {
            
            NSString *cellIdentifier = @"RecipientDetailsCampaignsCell";
            return [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        }
        
    } else {

        
        NSString *cellIdentifier = @"RecipientDetailsCompaignCell";
        
        RecipientDetailsCompaignCell *cell = (RecipientDetailsCompaignCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RecipientDetailsCompaignCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

        
        NSLog(@"> number of item: %d", indexPath.row - 6);
        
        
        int index = indexPath.row - 6;
        
        NSDictionary *campaign = self.viewModel.compaginesArray[index];
        

        cell.recipientCompaign.text = campaign[@"campaign_name"];
        

        NSLog(@"camp2: %@", cell.recipientCompaign.text);
        
        
        cell.payButton.tag = index;
        
        /* FOR MAX: use the following code for touchUpInside
         
        [[[cell.payButton rac_signalForControlEvents:UIControlEventTouchUpInside]
          takeUntil:cell.rac_prepareForReuseSignal]
         subscribeNext:^(id x) {
             [self buyButtonTapped];
         }];
         */
        [cell.payButton addTarget:self action:@selector(buyButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        return cell;
    }
}

- (void)buyButtonTapped:(id)sender
{
    UITableViewCell *clickedCell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath *clickedButtonPath = [self.compaginesTable indexPathForCell:clickedCell];
    
    int index = (int)clickedButtonPath.row - 6;
    
    NSDictionary *campaign = self.viewModel.compaginesArray[index];
    
    self.idOfCampaign = [[NSString stringWithFormat:@"%@", campaign[kObjectKeyCampaignId] ] mutableCopy];
    
    NSLog(@"%i", IS_IPHONE_6PLUS);
    PAmountViewController *board = [[UIStoryboard storyboardWithName:IS_IPHONE_6PLUS?@"Payment":@"Payment6" bundle:nil] instantiateViewControllerWithIdentifier:IS_IPHONE_6PLUS?@"payments1":@"payments6"];
    
    board.objId = [NSString stringWithFormat:@"%@",self.viewModel.rId];
    [GPPaymentEngine currentPayment].compagineId = [NSString stringWithFormat:@"%@", campaign[kObjectKeyCampaignId]];
    [GPPaymentEngine currentPayment].recipientName = campaign[@"campaign_name"];
      
    [self.navigationController pushViewController:board animated:YES];
}

-(IBAction)goNext
{
    
    
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
