//
//  MapViewController.m
//  Avia Tickets
//
//  Created by Марат Нургалиев on 27/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController () <MKMapViewDelegate>

@end

@implementation MapViewController

    - (void)viewDidLoad {
        
        [super viewDidLoad];
        
        self.title = @"Карта цен";
        
        _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
        
        _mapView.showsUserLocation = YES;
        
        _mapView.delegate = self;
        
        [self.view addSubview:_mapView];
        
        [[DataManager sharedInstance] loadData];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataLoadedSuccessfully) name:kDataManagerLoadDataDidComplete object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCurrentLocation:) name:kLocationServiceDidUpdateCurrentLocation object:nil];
    }

    - (void)dealloc {
       
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }


    - (void)dataLoadedSuccessfully {
       
        _locationService = [[LocationService alloc] init];
    }


    - (void)updateCurrentLocation:(NSNotification *)notification {
       
        CLLocation *currentLocation = notification.object;
        
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 1000000, 1000000);
        
        [_mapView setRegion: region animated: YES];
        
        if (currentLocation) {
           
            _origin = [[DataManager sharedInstance] cityForLocation:currentLocation];
           
            if (_origin) {
               
                [[ApiManager sharedInstance] mapPricesFor:_origin withCompletion:^(NSArray *prices) {
                   
                    self.prices = prices;
                }];
                
            }
            
        }
        
    }


    - (void)setPrices:(NSArray *)prices {
       
        _prices = prices;
        
        [_mapView removeAnnotations: _mapView.annotations];
        
        for (MapPrice *price in prices) {
           
            dispatch_async(dispatch_get_main_queue(), ^{
             
                MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
               
                annotation.title = [NSString stringWithFormat:@"%@ (%@)", price.destination.name, price.destination.code];
               
                annotation.subtitle = [NSString stringWithFormat:@"%ld руб.", (long)price.value];
               
                annotation.coordinate = price.destination.coordinate;
                
               
                
                [self->_mapView addAnnotation: annotation];
            });
            
        }
        
    }


    - (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
        
        [mapView deselectAnnotation:view.annotation animated:YES];
        
        if ([view.annotation isKindOfClass:[MKUserLocation class]]) {
            
            return;
        }
        
        [self getMapPriceBy:view.annotation.title];
    }


    - (void)getMapPriceBy:(NSString *)title {
        
        NSString *priceTitle = @"";
        
        for (MapPrice *price in _prices) {
            
            priceTitle = [NSString stringWithFormat:@"%@ (%@)", price.destination.name, price.destination.code];
            
            if ([priceTitle isEqualToString:title]) {
                
                [self showFavoriteAlert:price];
                
                break;
            }
            
        }
    
    }


    - (void) showFavoriteAlert:(MapPrice *) mapPrice {
    
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Действия с билетом" message:@"Что необходимо сделать с выбранным билетом?" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *favoriteAction;
        
        if ([[CoreDataHelper sharedInstance] isFavoriteMapPrice:mapPrice]) {
            
            favoriteAction = [UIAlertAction actionWithTitle:@"Удалить из избранного" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                [[CoreDataHelper sharedInstance] removeFromFavoriteMapPrice:mapPrice];
            }];
            
        }
        else {
            
            favoriteAction = [UIAlertAction actionWithTitle:@"Добавить в избранное" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [[CoreDataHelper sharedInstance] addToFavoriteMapPrice:mapPrice];
            }];
            
        }
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:favoriteAction];
        
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }



@end
