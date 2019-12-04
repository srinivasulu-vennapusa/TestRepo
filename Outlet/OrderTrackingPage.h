//
//  OrderTrackingPageViewController.h
//  OmniRetailer
//
//  Created by Technolabs on 04/12/19.
//

#import "CustomNavigationController.h"
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>

#import <MapKit/MKMapItem.h>
#import <MapKit/MKDirectionsRequest.h>
#import <MapKit/MKDirectionsTypes.h>


NS_ASSUME_NONNULL_BEGIN

@interface OrderTrackingPage : CustomNavigationController<MKMapViewDelegate, MKAnnotation>
{
//    MKMapView

    MKMapView * mapView;
    NSArray* routes;
    BOOL isUpdatingRoutes;
    
    CLLocationCoordinate2D coordinate;

}



//-(void) showRouteFrom: (MKAnnotation*) f to:(MKAnnotation*) t;



@end

NS_ASSUME_NONNULL_END
