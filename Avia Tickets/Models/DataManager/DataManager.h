//
//  DataManager.h
//  Avia Tickets
//
//  Created by Марат Нургалиев on 23/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Country.h"
#import "City.h"
#import "Airport.h"

#define kDataManagerLoadDataDidComplete @"DataManagerLoadDataDidComplete"

typedef enum DataSourceType {
    
    DataSourceTypeCountry,
    
    DataSourceTypeCity,
    
    DataSourceTypeAirport
} DataSourceType;

@interface DataManager : NSObject
    
    @property (nonatomic, strong, readonly) NSArray *countries;
    
    @property (nonatomic, strong, readonly) NSArray *cities;
    
    @property (nonatomic, strong, readonly) NSArray *airports;
    
    
    @property (nonatomic, strong) NSMutableArray *countriesArray;
    
    @property (nonatomic, strong) NSMutableArray *citiesArray;
    
    @property (nonatomic, strong) NSMutableArray *airportsArray;
    
    
    + (instancetype)sharedInstance;
    
    - (void)loadData;
    
@end

