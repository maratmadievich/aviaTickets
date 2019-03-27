//
//  LocationService.h
//  Avia Tickets
//
//  Created by Марат Нургалиев on 27/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

#define kLocationServiceDidUpdateCurrentLocation @"LocationServiceDidUpdateCurrentLocation"

@interface LocationService : NSObject

    @property (strong, nonatomic) CLLocation *currentLocation;

    @property (nonatomic, strong) CLLocationManager *locationManager;

@end
