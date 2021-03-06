//
//  ViewController.m
//  mapTest
//
//  Created by Joao Alves on 9/25/14.
//  Copyright (c) 2014 joaopaulo. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    PFUser *user = [PFUser user];
    user.username = @"joao";
    user.password = @"12345";
    user.email = @"jalves59@ford.com";
    
    if (nil == self.locationManager){
        self.locationManager = [[CLLocationManager alloc] init];
    
        self.locationManager.delegate = self;
    //Configure Accuracy depending on your needs, default is kCLLocationAccuracyBest
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
        // Set a movement threshold for new events.
        self.locationManager.distanceFilter = 500; // meters
    
        [self.locationManager startUpdatingLocation];
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
    
    self.appleMap.delegate = self;
    
    // Map will show current location
    self.appleMap.showsUserLocation = YES;
    
    // Maps' opening spot
    self.location = [self.locationManager location];
    CLLocationCoordinate2D coordinateActual = [self.location coordinate];
    
    // Map's zoom
    MKCoordinateSpan zoom = MKCoordinateSpanMake(0.010, 0.010);
    
    // Create a region
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinateActual, zoom);
    
    // Method which sets exibition method
    [self.appleMap setRegion:region animated:YES];
    
    self.appleMap.userTrackingMode = MKUserTrackingModeFollow;
    
    //Map's type
    self.appleMap.mapType = MKMapTypeStandard;
    
    
}

#pragma mark - Location Manager Callbacks

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        
        if (!error) {
            
            // Create Object
            PFObject *offersLocation = [PFObject objectWithClassName:@"Places"];
            
            //Create a point for markers
            PFGeoPoint *offersPoint = offersLocation[@"places_coordinate"];
            
            // Check current Location
             NSLog(@"%@", offersPoint);
            
            // Create a query for Places of interest near current location
            PFQuery *query = [PFQuery queryWithClassName:@"Places"];
        
            [query whereKey:@"places_coordinate" nearGeoPoint:geoPoint withinKilometers:5.0];
            
            NSLog(@"Query: %@",query);
            
            // Limit the query
            query.limit = 10;
            
            
            NSArray *offersArray = [query findObjects];
        
            
            NSLog(@"Array: %@",offersArray);
            
            
            
            
            if (!error) {
                for (PFObject *offerObject in offersArray) {
                    
                    PFGeoPoint *offerPoint = [offerObject objectForKey:@"places_coordinate"];
                    
                    self.annotation = [[MKPointAnnotation alloc]
                                                             init];
                    
                    self.annotation.coordinate = CLLocationCoordinate2DMake(offerPoint.latitude, offerPoint.longitude) ;
                    
                    self.annotation.title = offerObject[@"Name"];
                    
                    [self.appleMap addAnnotation:self.annotation];
                    
                    NSLog(@"Annotation: %@",self.annotation);
                
                }
            }
            
        }
    }];
    
    
}


#pragma mark - MKMapViewDelegate
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    static NSString *MapViewAnnotationIdentifier = @"places_coordinate";
    
    MKPinAnnotationView *pinOffers = [[MKPinAnnotationView alloc] initWithAnnotation:self.annotation reuseIdentifier:MapViewAnnotationIdentifier];
    
    //MKPointAnnotation *point =
    
    //pinOffers.pinColor = MKPinAnnotationColorRed;
    
    pinOffers.image = [UIImage imageNamed:@"mapMarker64.png"];
    
    pinOffers.canShowCallout = YES;
    
    pinOffers.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    pinOffers.animatesDrop = YES;
    
    return pinOffers;
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    
    
    
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
    CGPoint annotationCenter=CGPointMake(control.frame.origin.x+(control.frame.size.width/2),control.frame.origin.y+(control.frame.size.height/2));
    
    CLLocationCoordinate2D newCenter=[mapView convertPoint:annotationCenter toCoordinateFromView:control.superview];
    
    [mapView setCenterCoordinate:newCenter animated:YES];
    
    UIViewController *offer = [self.storyboard instantiateViewControllerWithIdentifier:@"offers"];
    
    [self presentViewController:offer animated:YES completion:nil];
    
}

-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
    
    
    
}

- (IBAction)centerMap:(id)sender {
    
    
    [self.appleMap setCenterCoordinate:self.appleMap.userLocation.location.coordinate animated:YES];
    
}
@end





























