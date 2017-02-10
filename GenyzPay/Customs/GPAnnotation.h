#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Recipient.h"



@interface GPAnnotation : NSObject <MKAnnotation>
{

     NSString *title;

}
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) UIImageView *image;
@property int type;
@property(nonatomic,strong)NSDictionary *data;
@property (strong, nonatomic) NSString *imageURLString;
@property (strong, nonatomic) NSString *adAnnotationID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) Recipient *recipient;
-(instancetype)initWithData:(NSDictionary *)data;

@end
