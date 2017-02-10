
#import "GPAnnotation.h"

@implementation GPAnnotation
@synthesize title;
@synthesize data = _data;
-(instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    if(self)
    {
        self.data =[NSDictionary dictionaryWithDictionary:data];
        self.imageURLString = data[kObjectKeyAvatarURL];
        self.adAnnotationID = data[kObjectKeyId];
        self.title = data[kObjectKeyName];
    }
    
    return self;

}
@end
