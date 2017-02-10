//
//  GPDonor+Runtime.m
//  GenyzPay
//
//  Created by Roman Bigun on 3/18/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#import "GPDonor+Runtime.h"
#import <objc/runtime.h>
@implementation GPDonor (Runtime)

static const NSString * kDataManagerKeyConst = @"kDataManagerKeyConst";

- (NSArray *)allPropertyNames
{
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    NSMutableArray *rv = [NSMutableArray array];
    
    unsigned i;
    for (i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        [rv addObject:name];
    }
    
    free(properties);
    
    return rv;
}
- (void *)pointerOfIvarForPropertyNamed:(NSString *)name
{
    objc_property_t property = class_getProperty([self class], [name UTF8String]);
    const char *attr = property_getAttributes(property);
    const char *ivarName = strchr(attr, 'V') + 1;
    Ivar ivar = object_getInstanceVariable(self, ivarName, NULL);
    return (char *)self + ivar_getOffset(ivar);
}
-(void)saveObjectAsDictionaryRepresentation {
    
    id current;
    
    NSArray *properties = [self allPropertyNames];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithCapacity:properties.count];
    for(NSString *name in properties)
    {
        void *propertyIvarAddress = [self pointerOfIvarForPropertyNamed:name];
        current = *(id *)propertyIvarAddress;
        if(![name containsString:@"Image"])
        {
            current = [self valueForKey:name];
            if(current){
                [dictionary setObject:current forKey:name];
            }
        }
        
    }
    NSLog(@"Saved GPDonor properties\n%@",dictionary);
    [[NSUserDefaults standardUserDefaults] setObject:dictionary forKey:kDataManagerKeyConst];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
-(void)populateObjectsFromMemory
{
    [self initWithData:(NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:kDataManagerKeyConst]];
    NSLog(@"To restore\n %@",(NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:kDataManagerKeyConst]);
    [self setValuesForKeysWithDictionary:(NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:kDataManagerKeyConst]];
    
}


@end
