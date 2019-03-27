//
//  Enums.h
//  Avia Tickets
//
//  Created by Марат Нургалиев on 24/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct SearchRequest {
    
    __unsafe_unretained NSString *origin;
    
    __unsafe_unretained NSString *destionation;
    
    __unsafe_unretained NSDate *departDate;
    
    __unsafe_unretained NSDate *returnDate;
} SearchRequest;


typedef enum PlaceType {
    
    PlaceTypeArrival,
    
    PlaceTypeDeparture
} PlaceType;


typedef enum DataSourceType {
    
    DataSourceTypeCountry,
    
    DataSourceTypeCity,
    
    DataSourceTypeAirport
} DataSourceType;


@interface Enums : NSObject

@end

