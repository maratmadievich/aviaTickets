//
//  MapViewController.h
//  Avia Tickets
//
//  Created by Марат Нургалиев on 27/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "APIManager.h"
#import "DataManager.h"
#import "LocationService.h"


@interface MapViewController: UIViewController

    @property (strong, nonatomic) MKMapView *mapView;

    @property (nonatomic, strong) LocationService *locationService;

    @property (nonatomic, strong) City *origin;

    @property (nonatomic, strong) NSArray *prices;

@end
