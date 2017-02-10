//
//  GPDonor+Runtime.h
//  GenyzPay
//
//  Created by Roman Bigun on 3/18/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import "GPDonor.h"

@interface GPDonor (Runtime)
-(void)saveObjectAsDictionaryRepresentation;
-(void)populateObjectsFromMemory;
@end
